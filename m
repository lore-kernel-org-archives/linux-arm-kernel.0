From: agraf@suse.de (Alexander Graf)
Date: Thu, 23 Aug 2018 14:24:56 +0200
Subject: [PATCH v3 7/9] KVM: arm/arm64: Only clean the dcache on
 translation fault
In-Reply-To: <1f59ea80-a88e-e09d-bb55-cd1a514bc957@arm.com>
References: <20171023161122.15291-1-marc.zyngier@arm.com>
 <20171023161122.15291-8-marc.zyngier@arm.com>
 <bfeee11e-f8bf-78f2-ab61-27e43781e2e3@suse.de>
 <9fa7efdf-1c21-7b07-edb9-0c7d0d91eaed@arm.com>
 <2686ddfc-935a-18e0-46bd-0cb608ae44e1@suse.de>
 <4d1c7d3b-4abe-fa8d-31ac-7a98ec349db1@arm.com>
 <a92a365f-3ad1-587e-4919-3814aebe85b0@suse.de>
 <1f59ea80-a88e-e09d-bb55-cd1a514bc957@arm.com>
Message-ID: <51b376d9-6339-66e3-bda2-06f8bbff8888@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2018 01:16 PM, Marc Zyngier wrote:
> On 21/08/18 17:54, Alexander Graf wrote:
>> On 08/21/2018 05:08 PM, Marc Zyngier wrote:
>>> On 21/08/18 15:08, Alexander Graf wrote:
>>>> On 08/21/2018 03:57 PM, Marc Zyngier wrote:
>>>>> On 21/08/18 14:35, Alexander Graf wrote:
>>>>>> On 10/23/2017 06:11 PM, Marc Zyngier wrote:
>>>>>>> The only case where we actually need to perform a dcache maintenance
>>>>>>> is when we map the page for the first time, and subsequent permission
>>>>>>> faults do not require cache maintenance. Let's make it conditional
>>>>>>> on not being a permission fault (and thus a translation fault).
>>>>>>>
>>>>>>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>>>>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>>> This patch unfortunately breaks something on Hi1616 SoCs when running
>>>>>> 32bit guests. With this patch applied (and thus with 4.18) I get random
>>>>>> illegal instruction warnings from 32bit code inside VMs. I do not know
>>>>>> at this point whether this affects other CPUs as well.
>>>>> Can you please give a few more details?
>>>>>
>>>>> - what are the CPUs on this Hi1616? At least a /proc/cpuinfo would help
>>>> These are A72s:
>>>>
>>>> processor??? : 0
>>>> BogoMIPS??? : 100.00
>>>> Features??? : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
>>>> CPU implementer??? : 0x41
>>>> CPU architecture: 8
>>>> CPU variant??? : 0x0
>>>> CPU part??? : 0xd08
>>>> CPU revision??? : 2
>>>>
>>>>> - an example of the crash? Is it within the decompressor? After? This
>>>>> things do matter, given the number of crazy things the 32bit kernel does
>>>> They are always in user space. My current reproducer is this:
>>>>
>>>>    ? $ while rpm -qa > /dev/null; do :; done
>>>>
>>>> If I run this in parallel with something that just populates RAM (dd
>>>> if=/dev/nvme0n1 of=/dev/null bs=10G) I get an illegal instruction fault
>>>> within seconds:
>>>>
>>>> sh-4.4# while rpm -qa > /dev/null; do true; done
>>>> Illegal instruction (core dumped)
>>>>
>>>>
>>>>> - a host kernel configuration?
>>>> Host kernel configuration is just the normal openSUSE one:
>>>>
>>>> https://kernel.opensuse.org/cgit/kernel-source/plain/config/arm64/default?h=stable
>>>>
>>>>>> If anyone is interested in a reproducer, I have something handy. But for
>>>>>> now I believe we should just revert this patch.
>>>>> Before we revert anything, I'd like to understand what is happening.
>>>> Yeah, I didn't realize the commit is already in since 4.16, so I agree.
>>>> I'll bisect a bit, but it may take a while.
>>> Do you mind giving this a try?
>>>
>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>> index 1d90d79706bd..df8f3d5eaa22 100644
>>> --- a/virt/kvm/arm/mmu.c
>>> +++ b/virt/kvm/arm/mmu.c
>>> @@ -1531,7 +1536,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>    			kvm_set_pfn_dirty(pfn);
>>>    		}
>>>    
>>> -		if (fault_status != FSC_PERM)
>>> +		if (fault_status != FSC_PERM || write_fault)
>>>    			clean_dcache_guest_page(pfn, PMD_SIZE);
>>>    
>>>    		if (exec_fault) {
>>> @@ -1553,7 +1558,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>    			mark_page_dirty(kvm, gfn);
>>>    		}
>>>    
>>> -		if (fault_status != FSC_PERM)
>>> +		if (fault_status != FSC_PERM || write_fault)
>>>    			clean_dcache_guest_page(pfn, PAGE_SIZE);
>>>    
>>>    		if (exec_fault) {
>>>
>>>
>>> The missing logic is that a write from the guest could have triggered
>>> a CoW, meaning we definitely need to flush it in that case too. It
>>> fixes a kvm-unit-test regression here.
>> This patch unfortunately does not fix the issue. I still see illegal
>> instructions.
> [+Dave]
>
> That's because what you're observing has nothing to do with caching, but
> with FP/SIMD trapping instead. Thanks to the guest image you've provided,
> I've been able to extract the following:
>
> [    3.944273] systemd-udevd (266): undefined instruction: pc=(ptrval)
> [    3.945396] CPU: 0 PID: 266 Comm: systemd-udevd Not tainted 4.17.14-2-lpae #1 openSUSE Tumbleweed (unreleased)
> [    3.947130] Hardware name: Generic DT based system
> [    3.947976] PC is at 0xb6b9397a
> [    3.948547] LR is at 0xb6e9a1b0
> [    3.958291] pc : [<b6b9397a>]    lr : [<b6e9a1b0>]    psr: 20070030
> [    3.959664] sp : bebe36a0  ip : b6f6ad50  fp : 005e8784
> [    3.960601] r10: bebe3814  r9 : bebe36c0  r8 : bebe36bc
> [    3.961522] r7 : bebe3814  r6 : 00000074  r5 : 00000000  r4 : 00000000
> [    3.962661] r3 : 005f2b60  r2 : 00000074  r1 : 00000000  r0 : bebe3814
> [    3.963801] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA Thumb  Segment user
> [    4.000606] Control: 30c5383d  Table: 6a8e7400  DAC: fffffffd
> [    4.001659] Code: d1f9 f1a0 0001 4770 (eee0) 1b10
>
> maz at flakes:~/armv7-build-fail$ (echo .thumb; echo .inst.w 0xeee01b10) > x.S &&  arm-linux-gnueabihf-gcc -c x.S && arm-linux-gnueabihf-objdump -d x.o
>
> x.o:     file format elf32-littlearm
>
>
> Disassembly of section .text:
>
> 00000000 <.text>:
>     0:	eee0 1b10 	vdup.8	q0, r1
>
> A VFP instruction. Given that you've reported that things worked in
> 4.17 and broke in 4.18, I strongly suspect the new lazy FPSIMD code.
> Upon inspection, the way we setup trapping for 32bit is a tiny bit
> suspect.
>
> Could you please give this patch a go? My Seattle has been running
> with it for 30 minutes now, and it is still running (instead of
> failing with seconds).
>
> Thanks,
>
> 	M.
>
>  From f2d1d43e2429f9269ab6c565440e095ab3a9be89 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <marc.zyngier@arm.com>
> Date: Thu, 23 Aug 2018 11:51:43 +0100
> Subject: [PATCH] arm64: KVM: Only force FPEXC32_EL2.EN if trapping FPSIMD
>
> If trapping FPSIMD in the context of an AArch32 guest, it is critical
> to set FPEXC32_EL2.EN to 1 so that the trapping is taken to EL2 and
> not EL1.
>
> Conversely, it is just as critical *not* to set FPEXC32_EL2.EN to 1
> if we're not going to trap FPSIMD, as we then corrupt the existing
> VFP state.
>
> Moving the call to __activate_traps_fpsimd32 to the point where we
> know for sure that we are going to trap ensures that we don't set that
> bit spuriously.
>
> Fixes: e6b673b741ea ("KVM: arm64: Optimise FPSIMD handling to reduce guest/host thrashing")
> Cc: Dave Martin <dave.martin@arm.com>
> Reported-by: Alexander Graf <agraf@suse.de>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Very good catch. This patch does indeed fix it. I'm still puzzled why 
reverting the dcache patch actually had any positive effect, but oh well 
... :)

Tested-by: Alexander Graf <agraf@suse.de>


Alex

> ---
>   arch/arm64/kvm/hyp/switch.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index d496ef579859..ca46153d7915 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -98,8 +98,10 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
>   	val = read_sysreg(cpacr_el1);
>   	val |= CPACR_EL1_TTA;
>   	val &= ~CPACR_EL1_ZEN;
> -	if (!update_fp_enabled(vcpu))
> +	if (!update_fp_enabled(vcpu)) {
>   		val &= ~CPACR_EL1_FPEN;
> +		__activate_traps_fpsimd32(vcpu);
> +	}
>   
>   	write_sysreg(val, cpacr_el1);
>   
> @@ -114,8 +116,10 @@ static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
>   
>   	val = CPTR_EL2_DEFAULT;
>   	val |= CPTR_EL2_TTA | CPTR_EL2_TZ;
> -	if (!update_fp_enabled(vcpu))
> +	if (!update_fp_enabled(vcpu)) {
>   		val |= CPTR_EL2_TFP;
> +		__activate_traps_fpsimd32(vcpu);
> +	}
>   
>   	write_sysreg(val, cptr_el2);
>   }
> @@ -129,7 +133,6 @@ static void __hyp_text __activate_traps(struct kvm_vcpu *vcpu)
>   	if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN) && (hcr & HCR_VSE))
>   		write_sysreg_s(vcpu->arch.vsesr_el2, SYS_VSESR_EL2);
>   
> -	__activate_traps_fpsimd32(vcpu);
>   	if (has_vhe())
>   		activate_traps_vhe(vcpu);
>   	else
