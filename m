From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 10 Oct 2017 13:50:26 +0100
Subject: [PATCH 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <59DBA864.9030108@arm.com>
References: <1507553734-27854-1-git-send-email-vladimir.murzin@arm.com>
 <1507553734-27854-2-git-send-email-vladimir.murzin@arm.com>
 <20171009152300.yrjdhnwna5r2enae@armageddon.cambridge.arm.com>
 <59DBA864.9030108@arm.com>
Message-ID: <ace7be76-c6fa-e217-f3c0-5e6dd42f5255@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 09/10/17 17:48, James Morse wrote:
> Hi Catalin, Vladimir,
> 
> On 09/10/17 16:23, Catalin Marinas wrote:
>> On Mon, Oct 09, 2017 at 01:55:32PM +0100, Vladimir Murzin wrote:
>>> This patch adds support for Common Not Private translations on
>>> different exceptions levels:
> 
>>> (2) For EL1 we postpone setting CNP till all cpus are up and rely on
>>>     cpufeature framework to 1) patch the code which is sensitive to
>>>     CNP and 2) update TTBR1_EL1 with CNP bit set. The only case where
>>>     TTBR1_EL1 can be reprogrammed is hibirnation, so the code there is
>>>     changed to save raw TTBR1_EL1 and blindly restore it on resume.
> 
>> Even if you do this when all the CPUs are up, that's not always true.
>> Starting with maxcpus=1 allows something like systemd to bring up new
>> CPUs once user space starts.
> 
> For secondary CPUs cpu_enable_cnp() will be called to set CNP on TTBR1_EL1. But
> what about cpuidle? This also resets the TTBR1_EL1 value.

Good point! I've missed it because reset happens via __enable_mmu, which has 
no idea about CnP.

Would something like below be sufficient?


diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 1e3be90..03a02c4 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -46,6 +46,10 @@ void notrace __cpu_suspend_exit(void)
 	 */
 	cpu_uninstall_idmap();
 
+#ifdef CONFIG_ARM64_CNP
+	/* Restore CnP bit in TTBR1_EL1 */
+	cpu_replace_ttbr1(swapper_pg_dir);
+#endif
 	/*
 	 * PSTATE was not saved over suspend/resume, re-enable any detected
 	 * features that might not have been set correctly.

> 
> 
>> The problem we have is that we don't know
>> what the firmware is doing, whether it's setting CnP or not. Maybe we
>> should add some statement in Documentation/arm64/booting.txt that
>> firmware must not use CnP at all.
> 
> 
>>> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
>>> index 095d3c1..1d056f3 100644
>>> --- a/arch/arm64/kernel/hibernate.c
>>> +++ b/arch/arm64/kernel/hibernate.c
>>> @@ -124,7 +124,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>>>  		return -EOVERFLOW;
>>>  
>>>  	arch_hdr_invariants(&hdr->invariants);
>>> -	hdr->ttbr1_el1		= __pa_symbol(swapper_pg_dir);
>>> +	hdr->ttbr1_el1		= read_sysreg(ttbr1_el1);
>>>  	hdr->reenter_kernel	= _cpu_resume;
>>>  
>>>  	/* We can't use __hyp_get_vectors() because kvm may still be loaded */
> 
>> Are all the CPUs up when coming out of hibernation and restoring
>> ttbr1_el1?
> 
> 'nonboot' CPUs are powered off around hibernate, so this only runs on one CPU.
> 
> Restoring with the CNP set like this will share all the TTBR1 mappings using the
> reserved ASID out of TTBR0. Hibernate then calls cpu_uninstall_idmap() via
> __cpu_suspend_exit(), which will restore the original ttbr0 value and CNP bit.
> 

Thanks for explanation!

Vladimir

> 
> Thanks,
> 
> James
> 
