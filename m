From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Thu, 24 May 2018 10:14:46 +0100
Subject: [PATCH v10 05/18] KVM: arm64: Convert lazy FPSIMD context switch
 trap to C
In-Reply-To: <20180524085445.GP13470@e103592.cambridge.arm.com>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-6-git-send-email-Dave.Martin@arm.com>
 <87k1rutbbi.fsf@linaro.org> <20180524081220.GJ55598@C02W217FHV2R.local>
 <20180524085445.GP13470@e103592.cambridge.arm.com>
Message-ID: <87fu2htny1.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> On Thu, May 24, 2018 at 10:12:20AM +0200, Christoffer Dall wrote:
>> On Wed, May 23, 2018 at 08:35:13PM +0100, Alex Benn?e wrote:
>> >
>> > Dave Martin <Dave.Martin@arm.com> writes:
>> >
>> > > To make the lazy FPSIMD context switch trap code easier to hack on,
>> > > this patch converts it to C.
>> > >
>> > > This is not amazingly efficient, but the trap should typically only
>> > > be taken once per host context switch.
>> > >
>> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>> > > Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>> > > ---
>> > >  arch/arm64/kvm/hyp/entry.S  | 57 +++++++++++++++++----------------------------
>> > >  arch/arm64/kvm/hyp/switch.c | 24 +++++++++++++++++++
>> > >  2 files changed, 46 insertions(+), 35 deletions(-)
>
> [...]
>
>> > > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>> > > index d964523..c0796c4 100644
>> > > --- a/arch/arm64/kvm/hyp/switch.c
>> > > +++ b/arch/arm64/kvm/hyp/switch.c
>> > > @@ -318,6 +318,30 @@ static bool __hyp_text __skip_instr(struct kvm_vcpu *vcpu)
>> > >  	}
>> > >  }
>> > >
>> > > +void __hyp_text __hyp_switch_fpsimd(u64 esr __always_unused,
>> > > +				    struct kvm_vcpu *vcpu)
>> > > +{
>> > > +	kvm_cpu_context_t *host_ctxt;
>> > > +
>> > > +	if (has_vhe())
>> > > +		write_sysreg(read_sysreg(cpacr_el1) | CPACR_EL1_FPEN,
>> > > +			     cpacr_el1);
>> > > +	else
>> > > +		write_sysreg(read_sysreg(cptr_el2) & ~(u64)CPTR_EL2_TFP,
>> > > +			     cptr_el2);
>> >
>> > Is there no way to do alternative() in C or does it always come down to
>> > different inline asms?
>> >
>>
>> has_vhe() should resolve to a static key, and I prefer this over the
>> previous alternative construct we had for selecting function calls in C,
>> as that resultet in having to follow too many levels of indirection.
>
> I'll defer to Christoffer on that -- I was just following precedent :)
>
> The if (has_vhe()) approach has the benefit of being much more
> readable, and the static branch predictor in many CPUs will succeed in
> folding a short-range unconditional branch out entirely.  There will be
> a small increase in I-cache pressure due to the larger inline code
> size, but probably not much beyond that.

Fair enough - it was mostly a curiosity. It seems most of the use of
alternative() are mostly at the low level instruction level anyway.

--
Alex Benn?e
