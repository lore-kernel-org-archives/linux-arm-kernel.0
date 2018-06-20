From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 21 Jun 2018 00:33:21 +0800
Subject: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <20180620162845.GD27776@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com> <20180620162845.GD27776@arm.com>
Message-ID: <5B2A81D1.6070507@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 2018/6/21 0:28, Will Deacon wrote:
> On Thu, Jun 21, 2018 at 12:25:05AM +0800, Wei Xu wrote:
>> Hi James,
>>
>> On 2018/6/20 23:54, James Morse wrote:
>>> Hi Wei,
>>>
>>> On 20/06/18 16:52, Wei Xu wrote:
>>>> On 2018/6/20 22:42, Will Deacon wrote:
>>>>> Hmm, I wonder if this is at all related to RAS, since we've just enabled
>>>>> that and if we take a fault whilst rewriting swapper then we're going to
>>>>> get stuck. What happens if you set CONFIG_ARM64_RAS_EXTN=n in the guest?
>>>> I will try it now.
>>> It's not just the Kconfig symbol, could you also revert:
>>>
>>> f751daa4f9d3 ("arm64: Unconditionally enable IESB on exception entry/return for
>>> firmware-first")
>>>
>>>
>>> (reverts and build cleanly on 4.17)
>> Thanks to point out this!
>> I have disabled CONFIG_ARM64_RAS_EXTN and reverted that commit.
>> But I still got the stack overflow issue sometimes.
>> Do you have more hint?
> [...]
>
>>      [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>>      [    0.081727] pc : el1_sync+0x0/0xb0
>>      [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214
> Please run:
>
> $ ./scripts/faddr2line vmlinux kpti_install_ng_mappings+0x120/0x214

Thanks for your kindly guide :)
The output is as below:

     joyx at Turing-Arch-b:~/plinth-kernel-v200$ ./scripts/faddr2line 
../kernel-dev.build/vmlinux kpti_install_ng_mappings+0x120/0x214
     kpti_install_ng_mappings+0x120/0x214:
     cpu_set_reserved_ttbr0 at arch/arm64/include/asm/mmu_context.h:52
     47      /*
     48       * Set TTBR0 to empty_zero_page. No translations will be 
possible via TTBR0.
     49       */
     50      static inline void cpu_set_reserved_ttbr0(void)
     51      {
     52              unsigned long ttbr = 
phys_to_ttbr(__pa_symbol(empty_zero_page));
     53
     54              write_sysreg(ttbr, ttbr0_el1);
     55              isb();
     56      }
     57
     (inlined by) cpu_uninstall_idmap at 
arch/arm64/include/asm/mmu_context.h:123
     118      */
     119     static inline void cpu_uninstall_idmap(void)
     120     {
     121             struct mm_struct *mm = current->active_mm;
     122
     123             cpu_set_reserved_ttbr0();
     124             local_flush_tlb_all();
     125             cpu_set_default_tcr_t0sz();
     126
     127             if (mm != &init_mm && !system_uses_ttbr0_pan())
     128                     cpu_switch_mm(mm->pgd, mm);
     (inlined by) kpti_install_ng_mappings at 
arch/arm64/kernel/cpufeature.c:922
     917
     918             remap_fn = (void 
*)__pa_symbol(idmap_kpti_install_ng_mappings);
     919
     920             cpu_install_idmap();
     921             remap_fn(cpu, num_online_cpus(), 
__pa_symbol(swapper_pg_dir));
     922             cpu_uninstall_idmap();
     923
     924             if (!cpu)
     925                     kpti_applied = true;
     926
     927             return;

Thanks!

Best Regards,
Wei

> as the GDB output wasn't helpful (it only showed local variable
> declarations?!).
>
> Will
>
> .
>
