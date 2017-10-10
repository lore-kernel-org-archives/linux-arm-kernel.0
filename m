From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 10 Oct 2017 13:50:43 +0100
Subject: [PATCH 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <20171009152300.yrjdhnwna5r2enae@armageddon.cambridge.arm.com>
References: <1507553734-27854-1-git-send-email-vladimir.murzin@arm.com>
 <1507553734-27854-2-git-send-email-vladimir.murzin@arm.com>
 <20171009152300.yrjdhnwna5r2enae@armageddon.cambridge.arm.com>
Message-ID: <45d505e4-fc79-35df-c5ec-9a50a5189c4e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 09/10/17 16:23, Catalin Marinas wrote:
> Hi Vladimir,
> 
> On Mon, Oct 09, 2017 at 01:55:32PM +0100, Vladimir Murzin wrote:
>> Common Not Private (CNP) is a feature of ARMv8.2 extension which
>> allows translation table entries to be shared between different PEs in
>> the same inner shareable domain, so the hardware can use this fact to
>> optimise the caching of such entries in the TLB.
>>
>> CNP occupies one bit in TTBRx_ELy and VTTBR_EL2, which advertises to
>> the hardware that the translation table entries pointed to by this
>> TTBR are the same as every PE in the same inner shareable domain for
>> which the equivalent TTBR also has CNP bit set. In case CNP bit is set
>> but TTBR does not point at the same translation table entries,
> 
> I would add something like "for a given ASID and VMID".

Done.

> 
>> then
>> the system is mis-configured, so the results of translations are
>> UNPREDICTABLE.
>>
>> This patch adds support for Common Not Private translations on
>> different exceptions levels:
>>
>> (1) For EL0 there are a few cases we need to care of changes in
>>     TTBR0_EL1:
>>     - a switch to idmap
>>     - software emulated PAN
>>     in these cases we make sure that CNP is set for non-zero ASIDs
>>     only.
>>
>> (2) For EL1 we postpone setting CNP till all cpus are up and rely on
>>     cpufeature framework to 1) patch the code which is sensitive to
>>     CNP and 2) update TTBR1_EL1 with CNP bit set. The only case where
>>     TTBR1_EL1 can be reprogrammed is hibirnation, so the code there is
>>     changed to save raw TTBR1_EL1 and blindly restore it on resume.
> 
> Even if you do this when all the CPUs are up, that's not always true.
> Starting with maxcpus=1 allows something like systemd to bring up new
> CPUs once user space starts. The problem we have is that we don't know
> what the firmware is doing, whether it's setting CnP or not. Maybe we
> should add some statement in Documentation/arm64/booting.txt that
> firmware must not use CnP at all.

I think it should be fine if firmware uses CnP in secure world and it is
quite unusual to see firmware executing at the same exception level as Linux.
However, Mark told me in private that kexec can be such sort of "firmware" it
is why PATCH 3/3 exists. Anyway, I do agree that CnP should be mentioned in
booting.txt, but I'm not sure about wording...

> 
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index f7c4d21..9640abc 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -78,6 +78,7 @@
>>  #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
>>  #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
>>  #define TASK_SIZE_64		(UL(1) << VA_BITS)
>> +#define TTBR_CNP_BIT		(UL(1) << 0)
> 
> Please move this to arch/arm64/include/asm/pgtable-hwdef.h. That's where
> we keep the TCR_* bits as well.
> 

Done.

>> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
>> index 3257895a..c8adce2 100644
>> --- a/arch/arm64/include/asm/mmu_context.h
>> +++ b/arch/arm64/include/asm/mmu_context.h
>> @@ -135,6 +135,17 @@ static inline void cpu_replace_ttbr1(pgd_t *pgd)
>>  
>>  	phys_addr_t pgd_phys = virt_to_phys(pgd);
>>  
>> +	if (system_supports_cnp()) {
>> +		/*
>> +		 * cpu_replace_ttbr1() is used when there's a boot CPU up
>> +		 * (i.e. cpufeture framework is not up yet) and latter only
> 
> s/cpufeture/cpufeature/

Done.

> 
>> +		 * when we enable CNP via cpufeature's enable() callback.
>> +		 */
>> +		BUG_ON(pgd != swapper_pg_dir);
>> +
>> +		pgd_phys |= TTBR_CNP_BIT;
>> +	}
> 
> Rather than BUG_ON, can we have:
> 
> 	if (system_supports_cnp() && pgd == swapper_pg_dir)
> 
> or, if you want to keep the warning:
> 
> 	if (system_supports_cnp() && !WARN_ON(pgd != swapper_pg_dir))
> 
> We also seem to rely on the cpu_hwcap bit being set before calling the
> enable() function. We need to be careful not to change this, otherwise
> the above will break.

I kept warning and updated comment to mention cpu_hwcap.

> 
>> @@ -178,6 +189,9 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
>>  		BUG_ON(mm->pgd == swapper_pg_dir);
>>  		task_thread_info(tsk)->ttbr0 =
>>  			virt_to_phys(mm->pgd) | ASID(mm) << 48;
>> +
>> +		if (system_supports_cnp() && ASID(mm))
>> +			task_thread_info(tsk)->ttbr0 |= TTBR_CNP_BIT;
>>  	}
>>  }
>>  #else
>> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
>> index fc0f9eb..14b1799 100644
>> --- a/arch/arm64/include/asm/uaccess.h
>> +++ b/arch/arm64/include/asm/uaccess.h
>> @@ -107,8 +107,14 @@ static inline void __uaccess_ttbr0_disable(void)
>>  {
>>  	unsigned long ttbr;
>>  
>> -	/* reserved_ttbr0 placed at the end of swapper_pg_dir */
>> -	ttbr = read_sysreg(ttbr1_el1) + SWAPPER_DIR_SIZE;
>> +	/*
>> +	 * reserved_ttbr0 is placed at the end of swapper_pg_dir.
>> +	 * When CNP is in use, TTBR1 may have the CNP bit set, but the
>> +	 * reserved_ttbr should only be used without CNP.
>> +	 */
>> +	ttbr = read_sysreg(ttbr1_el1);
>> +	ttbr &= ~TTBR_CNP_BIT;
>> +	ttbr += SWAPPER_DIR_SIZE;
>>  	write_sysreg(ttbr, ttbr0_el1);
>>  	isb();
>>  }
> 
> As for the asm __uaccess_ttbr0_disable, we probably don't care as hw PAN
> is available since ARMv8.1 and CnP is an ARMv8.2 feature. Sow we always
> end up with unnecessary code for sw PAN that's only executed where it
> doesn't matter. We could check for this at feature detection time (with
> a .matches function) or just add a Kconfig line:
> 
> 	depends on ARM64_PAN || !ARM64_SW_TTBR0_PAN

Kconfig updated and unnecessary code gone.

> 
>> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
>> index 095d3c1..1d056f3 100644
>> --- a/arch/arm64/kernel/hibernate.c
>> +++ b/arch/arm64/kernel/hibernate.c
>> @@ -124,7 +124,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>>  		return -EOVERFLOW;
>>  
>>  	arch_hdr_invariants(&hdr->invariants);
>> -	hdr->ttbr1_el1		= __pa_symbol(swapper_pg_dir);
>> +	hdr->ttbr1_el1		= read_sysreg(ttbr1_el1);
>>  	hdr->reenter_kernel	= _cpu_resume;
>>  
>>  	/* We can't use __hyp_get_vectors() because kvm may still be loaded */
> 
> Are all the CPUs up when coming out of hibernation and restoring
> ttbr1_el1?
> 
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 877d42f..1c94030 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -141,6 +141,11 @@ ENTRY(cpu_do_switch_mm)
>>  	pre_ttbr0_update_workaround x0, x2, x3
>>  	mmid	x1, x1				// get mm->context.id
>>  	bfi	x0, x1, #48, #16		// set the ASID
>> +alternative_if ARM64_HAS_CNP
>> +	cbz	x1, 1f
>> +	orr	x0, x0, #TTBR_CNP_BIT
>> +1:
>> +alternative_else_nop_endif
> 
> Some comments here would be useful for future readers (e.g. "do not set
> the CnP bit if ASID == 0).
> 

Done

Vladimir
