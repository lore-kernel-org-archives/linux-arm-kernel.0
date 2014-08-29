From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 29 Aug 2014 11:06:51 +0100
Subject: [PATCH v5] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <53FCD369.4000907@amd.com> (Joel Schopp's message of "Tue, 26 Aug
 2014 19:35:21 +0100")
References: <20140818203604.4654.99905.stgit@joelaarch64.amd.com>
 <8738cjqj4x.fsf@approximate.cambridge.arm.com>
 <53FCD369.4000907@amd.com>
Message-ID: <87bnr3pq2s.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26 2014 at  7:35:21 pm BST, Joel Schopp <joel.schopp@amd.com> wrote:
>>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>>> index 5c7aa3c..73f6ff6 100644
>>> --- a/arch/arm/include/asm/kvm_mmu.h
>>> +++ b/arch/arm/include/asm/kvm_mmu.h
>>> @@ -166,6 +166,18 @@ static inline void
>>> coherent_cache_guest_page(struct kvm_vcpu *vcpu, hva_t hva,
>>>
>>>  void stage2_flush_vm(struct kvm *kvm);
>>>
>>> +static inline int kvm_get_phys_addr_shift(void)
>>> +{
>>> +       return KVM_PHYS_SHIFT;
>>> +}
>>> +
>>> +static inline int set_vttbr_baddr_mask(void)
>>> +{
>>> +       vttbr_baddr_mask = VTTBR_BADDR_MASK;
>> Have you tried compiling this?
>>
>> Apart from the obvious missing definition of the variable, I'm not fond
>> of functions with side-effects hidden in an include file. What is wrong
>> with just returning the mask and letting the common code setting it?
> I like that change, will do in v6.
>
>>> +#ifdef CONFIG_ARM64_64K_PAGES
>>> +static inline int t0sz_to_vttbr_x(int t0sz)
>>> +{
>>> +       if (t0sz < 16 || t0sz > 34) {
>>> +               kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
>>> +               return 0;
>> 0 is definitely a bad value for something that is an error
>> case. Consider -EINVAL instead.
> OK.
>>
>> Also, what if we're in a range that only deals with more levels of page
>> tables than the kernel can deal with (remember we use the kernel page
>> table accessors)? See the new ARM64_VA_BITS and ARM64_PGTABLE_LEVELS
>> symbols that are now available, and use them to validate the range you
>> have.  
> With the simple current tests I can look at them and see they are
> correct, even if I can't make a scenario to test that they would fail. 
> However, if I add in more complicated checks I'd really like to test
> them catching the failure cases.  Can you describe a case where we can
> boot a kernel and then have the checks still fail in kvm? 

You're looking at T0SZ values that are outside of what a given
configuration of the kernel can handle (T0SZ == 16, for example, is only
valid with 3 levels of page tables, and the current implementation only
deals with 2). This is a case where things may explode, as you allow
input addresses that we simply cannot support, and in this case you want
to cap T0SZ to something sensible that is compatible with what the
kernel (and thus KVM) can express in terms of translations.

Testing is another thing, and I don't expect you to be able to test
every possible combinaison. Nonetheless, I do expect some reasonable
effort in the code to avoid deadly situations.

>>
>>> +       }
>>> +       return 37 - t0sz;
>>> +}
>>> +#endif
>>> +static inline int kvm_get_phys_addr_shift(void)
>>> +{
>>> +       int pa_range = read_cpuid(ID_AA64MMFR0_EL1) & 0xf;
>>> +
>>> +       switch (pa_range) {
>>> +       case 0: return 32;
>>> +       case 1: return 36;
>>> +       case 2: return 40;
>>> +       case 3: return 42;
>>> +       case 4: return 44;
>>> +       case 5: return 48;
>>> +       default:
>>> +               BUG();
>>> +               return 0;
>>> +       }
>>> +}
>>> +
>>> +static u64 vttbr_baddr_mask;
>> Now every compilation unit that includes kvm_mmu.h has an instance of
>> this variable. I doubt that it is the intended effect.
> The change for the comment farther above to just return the mask and
> have the common code set it should resolve this as well.
>
>>
>>> +
>>> +/**
>>> + * set_vttbr_baddr_mask - set mask value for vttbr base address
>>> + *
>>> + * In ARMv8, vttbr_baddr_mask cannot be determined in compile time since the
>>> + * stage2 input address size depends on hardware capability. Thus, we first
>>> + * need to read ID_AA64MMFR0_EL1.PARange and then set vttbr_baddr_mask with
>>> + * consideration of both the granule size and the level of
>>> translation tables.
>>> + */
>>> +static inline int set_vttbr_baddr_mask(void)
>>> +{
>>> +       int t0sz, vttbr_x;
>>> +
>>> +       t0sz = VTCR_EL2_T0SZ(kvm_get_phys_addr_shift());
>>> +       vttbr_x = t0sz_to_vttbr_x(t0sz);
>>> +       if (!vttbr_x)
>>> +               return -EINVAL;
>>> +       vttbr_baddr_mask = (((1LLU << (48 - vttbr_x)) - 1) << (vttbr_x - 1));
>> I think this can now be written as GENMASK_ULL(48, (vttbr_x - 1)).
> That does improve readability, I like it.
>
>>
>>> +       return 0;
>>> +}
>>> +
>>>  #endif /* __ASSEMBLY__ */
>>>  #endif /* __ARM64_KVM_MMU_H__ */
>>> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
>>> index d968796..c0f7634 100644
>>> --- a/arch/arm64/kvm/hyp-init.S
>>> +++ b/arch/arm64/kvm/hyp-init.S
>>> @@ -63,17 +63,21 @@ __do_hyp_init:
>>>         mrs     x4, tcr_el1
>>>         ldr     x5, =TCR_EL2_MASK
>>>         and     x4, x4, x5
>>> -       ldr     x5, =TCR_EL2_FLAGS
>>> -       orr     x4, x4, x5
>>> -       msr     tcr_el2, x4
>>> -
>>> -       ldr     x4, =VTCR_EL2_FLAGS
>>>         /*
>>>          * Read the PARange bits from ID_AA64MMFR0_EL1 and set the PS bits in
>>> -        * VTCR_EL2.
>>> +        * TCR_EL2 and both PS bits and T0SZ bits in VTCR_EL2.
>>>          */
>>>         mrs     x5, ID_AA64MMFR0_EL1
>>>         bfi     x4, x5, #16, #3
>>> +       msr     tcr_el2, x4
>>> +
>>> +       ldr     x4, =VTCR_EL2_FLAGS
>>> +       bfi     x4, x5, #16, #3
>>> +       and     x5, x5, #0xf
>>> +       adr     x6, t0sz
>>> +       add     x6, x6, x5, lsl #2
>>> +       ldr     w5, [x6]
>>> +       orr     x4, x4, x5
>> You'll need to validate the T0SZ value, and possibly adjust it so that
>> it is compatible with the addressing capability of the kernel. That
>> probably require a slight change of the hyp-init API.
> In order to do that I really should test that path, can you think of a
> way to generate a t0sz value that is incompatible with the kernel, but
> the kernel still boots so I can load kvm and test it?
>
>>
>>>         msr     vtcr_el2, x4
>>>
>>>         mrs     x4, mair_el1
>>> @@ -109,6 +113,10 @@ target: /* We're now in the trampoline code, switch page tables */
>>>
>>>         /* Hello, World! */
>>>         eret
>>> +
>>> +t0sz:
>>> +       .word   VTCR_EL2_T0SZ(32), VTCR_EL2_T0SZ(36), VTCR_EL2_T0SZ(40)
>>> +       .word   VTCR_EL2_T0SZ(42), VTCR_EL2_T0SZ(44), VTCR_EL2_T0SZ(48)
>>>  ENDPROC(__kvm_hyp_init)
>>>
>>>         .ltorg
>>>
>> Another element that doesn't appear in this patch is that we need a way
>> for the kernel to expose the maximum input address to userspace (and
>> validate that noone puts memory outside of that range). This should be a
>> separate patch, but it is conceptually tied to the same problem.
> I do think that separate patch would be a nice addition and probably
> dependent on this, but I do think this patch is useful on its own. 
> Especially since the current VTTBR_BADDR_MASK is broken.

This patch is indeed useful on its own, but I want to see a complete
solution, not a set of point fixes.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
