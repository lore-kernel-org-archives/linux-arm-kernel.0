From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Thu, 25 Feb 2016 08:28:30 +0900
Subject: [PATCH v3] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <20160224141832.GA26630@red-moon>
References: <1453806638-23167-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160202182657.GC15706@e104818-lin.cambridge.arm.com>
 <20160203112112.GA18387@red-moon> <20160203161834.GB26487@MBP.local>
 <20160224141832.GA26630@red-moon>
Message-ID: <56CE3C9E.7070505@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo,

On Mustang the lockdep warning I reported to you is disappeared and the 
system gets to
the prompt as you implemented, however only 7 CPUs out of 8 brought up.

[    0.069461] ACPI: Core revision 20160108
[    0.098175] ACPI: 4 ACPI AML tables successfully acquired and loaded

[    0.103899] Security Framework initialized
[    0.106883] Mount-cache hash table entries: 65536 (order: 7, 524288 
bytes)
[    0.112616] Mountpoint-cache hash table entries: 65536 (order: 7, 
524288 bytes)
[    0.133953] ftrace: allocating 25237 entries in 99 pages
[    0.228040] ASID allocator initialised with 65536 entries
[    0.253856] Remapping and enabling EFI services.
[    0.257328]   EFI remap 0x0000000010510000 => 0000000020000000
[    0.262000]   EFI remap 0x0000000010548000 => 0000000020018000
[    0.266702]   EFI remap 0x0000000017000000 => 0000000020020000
[    0.271403]   EFI remap 0x000000001c025000 => 0000000020035000
[    0.276060]   EFI remap 0x000000007c0c0000 => 0000000020040000
[    0.280786]   EFI remap 0x000000007c1c0000 => 0000000020050000
[    0.285495]   EFI remap 0x000000007c2c0000 => 0000000020060000
[    0.290204]   EFI remap 0x000000007c3c0000 => 0000000020070000
[    0.294861]   EFI remap 0x000000007c4c0000 => 0000000020080000
[    0.299535]   EFI remap 0x000000007c5c0000 => 0000000020090000
[    0.304244]   EFI remap 0x000000007c6c0000 => 00000000200a0000
[    0.308927]   EFI remap 0x000000007c7c0000 => 00000000200b0000
[    0.313671]   EFI remap 0x00000047fa80c000 => 00000000200cc000
[    0.318428]   EFI remap 0x00000047fa854000 => 00000000200d4000
[    0.323139]   EFI remap 0x00000047ff9fc000 => 00000000202cc000
[    0.327894]   EFI remap 0x00000047ffa10000 => 00000000202e0000
[    0.349223] Unable to handle kernel NULL pointer dereference at 
virtual address 00000008
[    0.349228] pgd = ffffff800a918000
[    0.349236] [00000008] *pgd=00000047ffffe003, *pud=00000047ffffe003, 
*pmd=0000000000000000
[    0.349242] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    0.349248] Modules linked in:
[    0.349255] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.5.0-rc4-core+ #32
[    0.349257] Hardware name: APM X-Gene Mustang board (DT)
[    0.349261] task: ffffffc7fab6c600 ti: ffffffc7fab70000 task.ti: 
ffffffc7fab70000
[    0.349268] PC is at acpi_parking_protocol_cpu_postboot+0x38/0xa8
[    0.349271] LR is at acpi_parking_protocol_cpu_postboot+0x1c/0xa8
[    0.349274] pc : [<ffffff80080a0a98>] lr : [<ffffff80080a0a7c>] 
pstate: 600003c5
[    0.349275] sp : ffffffc7fab73f50
[    0.349280] x29: ffffffc7fab73f50 x28: 00000000fffebd7d
[    0.349285] x27: ffffff8008082d00 x26: 0000004002b18000
[    0.349289] x25: 0000004002b15000 x24: ffffff80097d1608
[    0.349293] x23: ffffff80096554a8 x22: ffffff80097d1000
[    0.349297] x21: ffffff800972d000 x20: 0000000000000001
[    0.349302] x19: 0000000000000008 x18: 0000000030d00800
[    0.349306] x17: 000000001d100000 x16: 00000000fef7ffed
[    0.349310] x15: dedffffebe7efcae x14: 00000000f2fdfbfd
[    0.349314] x13: 00000000ae7e9e7f x12: 00000000800000c9
[    0.349319] x11: 000000009df2cf7c x10: 0000000000000000
[    0.349323] x9 : 0000000000000000 x8 : ffffff80097cf740
[    0.349327] x7 : 0000000000000000 x6 : 00000000000066a7
[    0.349332] x5 : ffffff80097cf740 x4 : ffffff80098607e0
[    0.349336] x3 : 0000000000000003 x2 : 0000000000000004
[    0.349340] x1 : ffffff8009bfa810 x0 : 0000000000000003

[    0.349344] Process swapper/1 (pid: 0, stack limit = 0xffffffc7fab70020)
[    0.349347] Stack: (0xffffffc7fab73f50 to 0xffffffc7fab74000)
[    0.349351] 3f40: ffffffc7fab73f80 ffffff80080972f8
[    0.349355] 3f60: ffffff80096554a8 0000000000000001 ffffff800972d000 
ffffff80080972b8
[    0.349358] 3f80: 0000000000000000 0000004000282cec 000000001d100000 
0000000000000e12
[    0.349362] 3fa0: 000000001d100000 00000000b77ff5fd 000000001d100000 
00000000f77f7d7f
[    0.349365] 3fc0: 0000004002b15000 0000004002b18000 ffffff8008082d00 
00000000fffebd7d
[    0.349368] 3fe0: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.349370] Call trace:
[    0.349374] Exception stack(0xffffffc7fab73d90 to 0xffffffc7fab73eb0)
[    0.349377] 3d80: 0000000000000008 0000000000000001
[    0.349380] 3da0: ffffffc7fab73f50 ffffff80080a0a98 0000000000000000 
0000000000000000
[    0.349383] 3dc0: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.349387] 3de0: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.349390] 3e00: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[    0.349393] 3e20: 0000000000000000 0000000000000000 0000000000000003 
ffffff8009bfa810
[    0.349397] 3e40: 0000000000000004 0000000000000003 ffffff80098607e0 
ffffff80097cf740
[    0.349400] 3e60: 00000000000066a7 0000000000000000 ffffff80097cf740 
0000000000000000
[    0.349404] 3e80: 0000000000000000 000000009df2cf7c 00000000800000c9 
00000000ae7e9e7f
[    0.349406] 3ea0: 00000000f2fdfbfd dedffffebe7efcae
[    0.349411] [<ffffff80080a0a98>] 
acpi_parking_protocol_cpu_postboot+0x38/0xa8
[    0.349415] [<ffffff80080972f8>] secondary_start_kernel+0x268/0x538
[    0.349419] [<0000004000282cec>] 0x4000282cec
[    0.349423] Code: 91204021 cb000040 f8607833 91002273 (b9400273)
[    0.349483] ---[ end trace 80a6d1ac53b24c3c ]---
[    0.349487] Kernel panic - not syncing: Fatal exception
[    0.349496] ---[ end Kernel panic - not syncing: Fatal exception
[    1.350177] CPU1: failed to come online
[    1.367354] Detected PIPT I-cache on CPU2
[    1.367398] CPU2: Booted secondary processor [500f0001]
[    1.379399] Detected PIPT I-cache on CPU3
[    1.379425] CPU3: Booted secondary processor [500f0001]
[    1.391487] Detected PIPT I-cache on CPU4
[    1.391521] CPU4: Booted secondary processor [500f0001]
[    1.403536] Detected PIPT I-cache on CPU5
[    1.403562] CPU5: Booted secondary processor [500f0001]
[    1.415590] Detected PIPT I-cache on CPU6
[    1.415625] CPU6: Booted secondary processor [500f0001]
[    1.427677] Detected PIPT I-cache on CPU7
[    1.427702] CPU7: Booted secondary processor [500f0001]
[    1.427823] Brought up 7 CPUs
[    1.470268] SMP: Total of 7 processors activated.
[    1.473801] CPU: All CPU(s) started at EL2


On 2/24/16 11:18 PM, Lorenzo Pieralisi wrote:
> [+ Itaru]
>
> On Wed, Feb 03, 2016 at 04:18:36PM +0000, Catalin Marinas wrote:
>> On Wed, Feb 03, 2016 at 11:21:12AM +0000, Lorenzo Pieralisi wrote:
>>> On Tue, Feb 02, 2016 at 06:26:58PM +0000, Catalin Marinas wrote:
>>>> On Tue, Jan 26, 2016 at 11:10:38AM +0000, Lorenzo Pieralisi wrote:
>>>>> The SBBR and ACPI specifications allow ACPI based systems that do not
>>>>> implement PSCI (eg systems with no EL3) to boot through the ACPI parking
>>>>> protocol specification[1].
>>>>>
>>>>> This patch implements the ACPI parking protocol CPU operations, and adds
>>>>> code that eases parsing the parking protocol data structures to the
>>>>> ARM64 SMP initializion carried out at the same time as cpus enumeration.
>>>>>
>>>>> To wake-up the CPUs from the parked state, this patch implements a
>>>>> wakeup IPI for ARM64 (ie arch_send_wakeup_ipi_mask()) that mirrors the
>>>>> ARM one, so that a specific IPI is sent for wake-up purpose in order
>>>>> to distinguish it from other IPI sources.
>>>>>
>>>>> Given the current ACPI MADT parsing API, the patch implements a glue
>>>>> layer that helps passing MADT GICC data structure from SMP initialization
>>>>> code to the parking protocol implementation somewhat overriding the CPU
>>>>> operations interfaces. This to avoid creating a completely trasparent
>>>>> DT/ACPI CPU operations layer that would require creating opaque
>>>>> structure handling for CPUs data (DT represents CPU through DT nodes, ACPI
>>>>> through static MADT table entries), which seems overkill given that ACPI
>>>>> on ARM64 mandates only two booting protocols (PSCI and parking protocol),
>>>>> so there is no need for further protocol additions.
>>>>>
>>>>> Based on the original work by Mark Salter <msalter@redhat.com>
>>>>>
>>>>> [1] https://acpica.org/sites/acpica/files/MP%20Startup%20for%20ARM%20platforms.docx
>>>>>
>>>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>> Cc: Hanjun Guo <hanjun.guo@linaro.org>
>>>>> Cc: Loc Ho <lho@apm.com>
>>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>> Cc: Mark Salter <msalter@redhat.com>
>>>>> Cc: Al Stone <ahs3@redhat.com>
>>>> Applied, with a minor addition just to warn people from not using it in
>>>> other configurations (#ifdef still needed otherwise the
>>>> acpi_parking_protocol_valid symbol is not available; but I prefer uglier
>>>> code than people starting to use this IPI in their firmware):
>>> It makes sense, we could include asm/acpi.h in smp.c (which is not
>>> included by linux/acpi.h if !CONFIG_ACPI) to pull in the symbol and
>>> remove the ifdef if you think it is cleaner.
>> I don't think it's worth.
>>
>> BTW, the acpi_parking_protocol_valid() definition has an __init
>> annotation while the declaration does not. I removed the __init
>> altogether since I get a section mismatch warning when being called from
>> handle_IPI.
> Catalin,
>
> Itaru spotted an issue related to ioremapping the mailbox in the
> cpu_postboot method where I can't really use ioremap since irqs
> are disabled on the secondaries coming up at that point, I missed
> that, apologies (I wanted to avoid leaving the mailboxes mapped
> after boot).
>
> So, options to fix it:
>
> (1) we leave the mailboxes mapped
> (2) we remove the FW check in the postboot method (running on
>      secondaries)
> (3) I add a cpu_ops method to clean-up resources used for
>      booting secondaries and there I can unmap the mailboxes
>
> Frankly, they are all unappealing, I would go for (1), patch below, Itaru
> can you give it a go please on Mustang against arm64 for-next/core ?
>
> Thanks,
> Lorenzo
>
> -- >8 --
> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
> index 4b1e5a7..b56fc0d 100644
> --- a/arch/arm64/kernel/acpi_parking_protocol.c
> +++ b/arch/arm64/kernel/acpi_parking_protocol.c
> @@ -21,7 +21,14 @@
>   
>   #include <asm/cpu_ops.h>
>   
> +struct parking_protocol_mailbox {
> +	__le32 cpu_id;
> +	__le32 reserved;
> +	__le64 entry_point;
> +};
> +
>   struct cpu_mailbox_entry {
> +	struct parking_protocol_mailbox __iomem *mailbox;
>   	phys_addr_t mailbox_addr;
>   	u8 version;
>   	u8 gic_cpu_id;
> @@ -59,12 +66,6 @@ static int acpi_parking_protocol_cpu_prepare(unsigned int cpu)
>   	return 0;
>   }
>   
> -struct parking_protocol_mailbox {
> -	__le32 cpu_id;
> -	__le32 reserved;
> -	__le64 entry_point;
> -};
> -
>   static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>   {
>   	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> @@ -107,7 +108,11 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>   
>   	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
>   
> -	iounmap(mailbox);
> +	/*
> +	 * stash the mailbox address mapping to use it for checks
> +	 * in post boot method
> +	 */
> +	cpu_entry->mailbox = mailbox;
>   
>   	return 0;
>   }
> @@ -116,32 +121,15 @@ static void acpi_parking_protocol_cpu_postboot(void)
>   {
>   	int cpu = smp_processor_id();
>   	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
> -	struct parking_protocol_mailbox __iomem *mailbox;
> +	struct parking_protocol_mailbox __iomem *mailbox = cpu_entry->mailbox;
>   	__le64 entry_point;
>   
> -	/*
> -	 * Map mailbox memory with attribute device nGnRE (ie ioremap -
> -	 * this deviates from the parking protocol specifications since
> -	 * the mailboxes are required to be mapped nGnRnE; the attribute
> -	 * discrepancy is harmless insofar as the protocol specification
> -	 * is concerned).
> -	 * If the mailbox is mistakenly allocated in the linear mapping
> -	 * by FW ioremap will fail since the mapping will be prevented
> -	 * by the kernel (it clashes with the linear mapping attributes
> -	 * specifications).
> -	 */
> -	mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
> -	if (!mailbox)
> -		return;
> -
>   	entry_point = readl_relaxed(&mailbox->entry_point);
>   	/*
>   	 * Check if firmware has cleared the entry_point as expected
>   	 * by the protocol specification.
>   	 */
>   	WARN_ON(entry_point);
> -
> -	iounmap(mailbox);
>   }
>   
>   const struct cpu_operations acpi_parking_protocol_ops = {
