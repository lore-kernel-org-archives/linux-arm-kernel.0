From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 21 Nov 2018 16:49:59 +0000
Subject: [RFC PATCH v2 16/23] KVM: arm64: Enumerate SVE register indices
 for KVM_GET_REG_LIST
In-Reply-To: <20181121163201.GC3505@e103592.cambridge.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-17-git-send-email-Dave.Martin@arm.com>
 <87k1l6ifa8.fsf@linaro.org> <20181121163201.GC3505@e103592.cambridge.arm.com>
Message-ID: <87ftvuide0.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> On Wed, Nov 21, 2018 at 04:09:03PM +0000, Alex Benn?e wrote:
>>
>> Dave Martin <Dave.Martin@arm.com> writes:
>>
>> > This patch includes the SVE register IDs in the list returned by
>> > KVM_GET_REG_LIST, as appropriate.
>> >
>> > On a non-SVE-enabled vcpu, no extra IDs are added.
>> >
>> > On an SVE-enabled vcpu, the appropriate number of slice IDs are
>> > enumerated for each SVE register, depending on the maximum vector
>> > length for the vcpu.
>> >
>> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>> > ---
>> >
>> > Changes since RFCv1:
>> >
>> >  * Simplify enumerate_sve_regs() based on Andrew Jones' approach.
>> >
>> >  * Reg copying loops are inverted for brevity, since the order we
>> >    spit out the regs in doesn't really matter.
>> >
>> > (I tried to keep part of my approach to avoid the duplicate logic
>> > between num_sve_regs() and copy_sve_reg_indices(), but although
>> > it works in principle, gcc fails to fully collapse the num_regs()
>> > case... so I gave up.  The two functions need to be manually kept
>> > consistent, but hopefully that's fairly straightforward.)
>> > ---
>> >  arch/arm64/kvm/guest.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 45 insertions(+)
>> >
>> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> > index 320db0f..89eab68 100644
>> > --- a/arch/arm64/kvm/guest.c
>> > +++ b/arch/arm64/kvm/guest.c
>> > @@ -323,6 +323,46 @@ static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> >  	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)) ? -EFAULT : 0;
>> >  }
>> >
>> > +static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
>> > +{
>> > +	const unsigned int slices = DIV_ROUND_UP(
>> > +		vcpu->arch.sve_max_vl,
>> > +		KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0)));
>>
>> Having seen this formulation come up several times now I wonder if there
>> should be a kernel private define, KVM_SVE_ZREG/PREG_SIZE to avoid this
>> clumsiness.
>
> I agree it's a bit awkward.  Previous I spelled this "0x100", which
> was terse but more sensitive to typos and other screwups that Io
> liked.
>
>> You could still use the KVM_REG_SIZE to extract it as I guess this is to
>> make changes simpler if/when the SVE reg size gets bumped up.
>
> That might be more challenging to determine at compile time.
>
> I'm not sure how good GCC is at doing const-propagation between related
> (but different) expressions, so I preferred to go for something that
> is clearly compiletime constant rather than extracting it from the
> register ID that came from userspace.
>
> So, I'd prefer not to use KVM_REG_SIZE() for this, but I'm happy to add
> a private #define to hide this cumbersome construct.  That would
> certainly make the code more readable.
>
> (Of course, the actual runtime cost is trivial either way, but I felt
> it was easier to reason about correctness if this is really a constant.)
>
>
> Sound OK?

Yes.

I'd almost suggested by not just use KVM_REG_SIZE(KVM_REG_SIZE_U2048)
earlier until I realised this might be forward looking.

--
Alex Benn?e
