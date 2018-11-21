From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Nov 2018 17:46:59 +0000
Subject: [RFC PATCH v2 16/23] KVM: arm64: Enumerate SVE register indices
 for KVM_GET_REG_LIST
In-Reply-To: <87ftvuide0.fsf@linaro.org>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-17-git-send-email-Dave.Martin@arm.com>
 <87k1l6ifa8.fsf@linaro.org>
 <20181121163201.GC3505@e103592.cambridge.arm.com>
 <87ftvuide0.fsf@linaro.org>
Message-ID: <20181121174658.GE3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 04:49:59PM +0000, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > On Wed, Nov 21, 2018 at 04:09:03PM +0000, Alex Benn?e wrote:
> >>
> >> Dave Martin <Dave.Martin@arm.com> writes:

[...]

> >> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> >> > index 320db0f..89eab68 100644
> >> > --- a/arch/arm64/kvm/guest.c
> >> > +++ b/arch/arm64/kvm/guest.c
> >> > @@ -323,6 +323,46 @@ static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >> >  	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)) ? -EFAULT : 0;
> >> >  }
> >> >
> >> > +static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
> >> > +{
> >> > +	const unsigned int slices = DIV_ROUND_UP(
> >> > +		vcpu->arch.sve_max_vl,
> >> > +		KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0)));
> >>
> >> Having seen this formulation come up several times now I wonder if there
> >> should be a kernel private define, KVM_SVE_ZREG/PREG_SIZE to avoid this
> >> clumsiness.
> >
> > I agree it's a bit awkward.  Previous I spelled this "0x100", which
> > was terse but more sensitive to typos and other screwups that Io
> > liked.
> >
> >> You could still use the KVM_REG_SIZE to extract it as I guess this is to
> >> make changes simpler if/when the SVE reg size gets bumped up.
> >
> > That might be more challenging to determine at compile time.
> >
> > I'm not sure how good GCC is at doing const-propagation between related
> > (but different) expressions, so I preferred to go for something that
> > is clearly compiletime constant rather than extracting it from the
> > register ID that came from userspace.
> >
> > So, I'd prefer not to use KVM_REG_SIZE() for this, but I'm happy to add
> > a private #define to hide this cumbersome construct.  That would
> > certainly make the code more readable.
> >
> > (Of course, the actual runtime cost is trivial either way, but I felt
> > it was easier to reason about correctness if this is really a constant.)
> >
> >
> > Sound OK?
> 
> Yes.
> 
> I'd almost suggested by not just use KVM_REG_SIZE(KVM_REG_SIZE_U2048)
> earlier until I realised this might be forward looking.

Having the slice size as 2048 bits is a property of the ABI and isn't
intended to change in the future.

So, I guess we could write the above, but I prefer to have the size
determined in the fewest number of places possible.


Cheers
---Dave
