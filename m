From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Tue, 20 Nov 2018 15:30:29 +0000
Subject: [RFC PATCH v2 13/23] KVM: arm64/sve: Context switch the SVE
 registers
In-Reply-To: <20181120141659.GZ3505@e103592.cambridge.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-14-git-send-email-Dave.Martin@arm.com>
 <87sgzxhvny.fsf@linaro.org> <20181119170303.GX3505@e103592.cambridge.arm.com>
 <87o9akhr6f.fsf@linaro.org> <20181120141659.GZ3505@e103592.cambridge.arm.com>
Message-ID: <87muq3ix62.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

<snip>
>> >> > @@ -404,10 +444,11 @@ static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
>> >> >  	 * and restore the guest context lazily.
>> >> >  	 * If FP/SIMD is not implemented, handle the trap and inject an
>> >> >  	 * undefined instruction exception to the guest.
>> >> > +	 * Similarly for trapped SVE accesses.
>> >> >  	 */
>> >> > -	if (system_supports_fpsimd() &&
>> >> > -	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_FP_ASIMD)
>> >> > -		return __hyp_switch_fpsimd(vcpu);
>> >> > +	guest_has_sve = vcpu_has_sve(vcpu);
>> >>
>> >> I'm not sure if it's worth fishing this out here given you are already
>> >> passing vcpu down the chain.
>> >
>> > I wanted to discourage GCC from recomputing this.  If you're in a
>> > position to do so, can you look at the disassembly with/without this
>> > factored out and see whether it makes a difference?
>>
>> Hmm it is hard to tell. There is code motion but for some reason I'm
>> seeing the static jump code unrolled, for example (original on left):
>>
>> __hyp_switch_fpsimd():                                                                  __hyp_switch_fpsimd():
>> /home/alex/lsrc/kvm/linux.git/arch/arm64/kvm/hyp/switch.----:382                      | /home/alex/lsrc/kvm/linux.git/arch/arm64/kvm/hyp/switch.----:381
>>                                                                                       >  ----:  tst     w0, #0x400000
>>                                                                                       >  ----:  b.eq    22c <fixup_guest_exit+0x1a4>  // b.none
>>                                                                                       > arch_static_branch_jump():
>>                                                                                       > /home/alex/lsrc/kvm/linux.git/arch/arm64/include/asm/jump_label.h:45
>>                                                                                       >  ----:  b       38c <fixup_guest_exit+0x304>
>>                                                                                       > arch_static_branch():
>>                                                                                       > /home/alex/lsrc/kvm/linux.git/arch/arm64/include/asm/jump_label.h:31
>>                                                                                       >  ----:  nop
>>                                                                                       >  ----:  b       22c <fixup_guest_exit+0x1a4>
>>                                                                                       > test_bit():
>>                                                                                       > /home/alex/lsrc/kvm/linux.git/include/asm-generic/bitops/non-atomic.h:106
>>                                                                                       >  ----:  adrp    x0, 0 <cpu_hwcaps>
>>                                                                                       >  ----:  ldr     x0, [x0]
>>                                                                                       > __hyp_switch_fpsimd():
>>                                                                                       > /home/alex/lsrc/kvm/linux.git/arch/arm64/kvm/hyp/switch.----:381
>>  ----:  tst     w0, #0x400000                                                            ----:  tst     w0, #0x400000
>>  ----:  b.eq    238 <fixup_guest_exit+0x1b0>  // b.none                               |  ----:  b.eq    22c <fixup_guest_exit+0x1a4>  // b.none
>>  ----:  cbz     w21, 238 <fixup_guest_exit+0x1b0>                                     |  ----:  tbz     w2, #5, 22c <fixup_guest_exit+0x1a4>
>> /home/alex/lsrc/kvm/linux.git/arch/arm64/kvm/hyp/switch.----:383                      | /home/alex/lsrc/kvm/linux.git/arch/arm64/kvm/hyp/switch.----:382
>>  ----:  ldr     w2, [x19, #2040]                                                      |  ----:  ldr     w2, [x20, #2040]
>>  ----:  add     x1, x19, #0x4b0                                                       |  ----:  add     x1, x20, #0x4b0
>>  ----:  ldr     x0, [x19, #2032]                                                      |  ----:  ldr     x0, [x20, #2032]
>> sve_ffr_offset():                                                                       sve_ffr_offset():
>>
>> Put calculating guest_has_sve at the top of __hyp_switch_fpsimd make
>> most of that go away and just moves things around a little bit. So I
>> guess it could makes sense for the fast(ish) path although I'd be
>> interested in knowing if it made any real difference to the numbers.
>> After all the first read should be well cached and moving it through the
>> stack is just additional memory and register pressure.
>
> Hmmm, I will have a think about this when I respin.
>
> Explicitly caching guest_has_sve() does reduce the compiler's freedom to
> optimise.
>
> We might be able to mark it as __pure or __attribute_const__ to enable
> the compiler to decide whether to cache the result, but this may not be
> 100% safe.
>
> Part of me would prefer to leave things as they are to avoid the risk of
> breaking the code again...

Given that the only place you call __hyp_switch_fpsimd is here you could
just roll in into __hyp_trap_is_fpsimd and have:

	if (__hyp_trap_is_fpsimd(vcpu))
		return true;

--
Alex Benn?e
