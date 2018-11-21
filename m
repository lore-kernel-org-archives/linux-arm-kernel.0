From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Nov 2018 18:05:02 +0000
Subject: [RFC PATCH v2 15/23] KVM: arm64/sve: Add SVE support to register
 access ioctl interface
In-Reply-To: <87lg5mihjk.fsf@linaro.org>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-16-git-send-email-Dave.Martin@arm.com>
 <87lg5mihjk.fsf@linaro.org>
Message-ID: <20181121180502.GF3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 03:20:15PM +0000, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > This patch adds the following registers for access via the
> > KVM_{GET,SET}_ONE_REG interface:
> >
> >  * KVM_REG_ARM64_SVE_ZREG(n, i) (n = 0..31) (in 2048-bit slices)
> >  * KVM_REG_ARM64_SVE_PREG(n, i) (n = 0..15) (in 256-bit slices)
> >  * KVM_REG_ARM64_SVE_FFR(i) (in 256-bit slices)
> >
> > In order to adapt gracefully to future architectural extensions,
> > the registers are divided up into slices as noted above:  the i
> > parameter denotes the slice index.
> >
> > For simplicity, bits or slices that exceed the maximum vector
> > length supported for the vcpu are ignored for KVM_SET_ONE_REG, and
> > read as zero for KVM_GET_ONE_REG.
> >
> > For the current architecture, only slice i = 0 is significant.  The
> > interface design allows i to increase to up to 31 in the future if
> > required by future architectural amendments.
> >
> > The registers are only visible for vcpus that have SVE enabled.
> > They are not enumerated by KVM_GET_REG_LIST on vcpus that do not
> > have SVE.  In all cases, surplus slices are not enumerated by
> > KVM_GET_REG_LIST.
> >
> > Accesses to the FPSIMD registers via KVM_REG_ARM_CORE is not
> > allowed for SVE-enabled vcpus: SVE-aware userspace can use the
> > KVM_REG_ARM64_SVE_ZREG() interface instead to access the same
> > register state.  This avoids some complex and pointless emluation
> > in the kernel.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >
> > Changes since RFCv1:
> >
> >  * Refactored to remove emulation of FPSIMD registers with the SVE
> >    register view and vice-versa.  This simplifies the code a fair bit.
> >
> >  * Fixed a couple of range errors.
> >
> >  * Inlined various trivial helpers that now have only one call site.
> >
> >  * Use KVM_REG_SIZE() as a symbolic way of getting SVE register slice
> >    sizes.
> > ---
> >  arch/arm64/include/uapi/asm/kvm.h |  10 +++
> >  arch/arm64/kvm/guest.c            | 147 ++++++++++++++++++++++++++++++++++----
> >  2 files changed, 145 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> > index 97c3478..1ff68fa 100644
> > --- a/arch/arm64/include/uapi/asm/kvm.h
> > +++ b/arch/arm64/include/uapi/asm/kvm.h
> > @@ -226,6 +226,16 @@ struct kvm_vcpu_events {
> >  					 KVM_REG_ARM_FW | ((r) & 0xffff))
> >  #define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
> >
> > +/* SVE registers */
> > +#define KVM_REG_ARM64_SVE		(0x15 << KVM_REG_ARM_COPROC_SHIFT)
> > +#define KVM_REG_ARM64_SVE_ZREG(n, i)	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
> > +					 KVM_REG_SIZE_U2048 |		\
> > +					 ((n) << 5) | (i))
> > +#define KVM_REG_ARM64_SVE_PREG(n, i)	(KVM_REG_ARM64 | KVM_REG_ARM64_SVE | \
> > +					 KVM_REG_SIZE_U256 |		\
> > +					 ((n) << 5) | (i) | 0x400)
> 
> What's the 0x400 for? Aren't PREG's already unique by being 256 bit vs
> the Z regs 2048 bit size?

I was treating the reg size field as metadata rather than being part
of the ID, so the IDs remain unique even with the size field masked
out.

For the core regs, we explicitly allow access to the same underlying
regs using a mix of access sizes (whether or not that is a good idea is
another question).

For the rest of the regs perhaps we can rely on the size field to
disambiguate different regs in practice, but I didn't reel comfortable
making that assumption...

> 
> > +#define KVM_REG_ARM64_SVE_FFR(i)	KVM_REG_ARM64_SVE_PREG(16, i)
> > +
> >  /* Device Control API: ARM VGIC */
> >  #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
> >  #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > index 953a5c9..320db0f 100644
> <snip>
> >
> > @@ -130,6 +154,107 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  	return err;
> >  }
> >
> > +struct kreg_region {
> > +	char *kptr;
> > +	size_t size;
> > +	size_t zeropad;
> > +};
> > +
> > +#define SVE_REG_SLICE_SHIFT	0
> > +#define SVE_REG_SLICE_BITS	5
> > +#define SVE_REG_ID_SHIFT	(SVE_REG_SLICE_SHIFT + SVE_REG_SLICE_BITS)
> > +#define SVE_REG_ID_BITS		5
> > +
> > +#define SVE_REG_SLICE_MASK \
> > +	(GENMASK(SVE_REG_SLICE_BITS - 1, 0) << SVE_REG_SLICE_SHIFT)
> > +#define SVE_REG_ID_MASK	\
> > +	(GENMASK(SVE_REG_ID_BITS - 1, 0) << SVE_REG_ID_SHIFT)
> > +
> 
> I guess this all comes out in the wash once the constants are folded but
> GENMASK does seem to be designed for arbitrary bit positions:
> 
>   #define SVE_REG_SLICE_MASK \
>      GEN_MASK(SVE_REG_SLICE_BITS + SVE_REG_SLICE_SHIFT - 1, SVE_REG_SLICE_SHIFT)
> 
> Hmm I guess that might be even harder to follow...

Swings and roundabouts...

I'm not sure I prefer your version, but I agree it's a more natural use
of GENMASK() than my version.  I'm happy to change it.

> 
> > +#define SVE_NUM_SLICES (1 << SVE_REG_SLICE_BITS)
> > +
> > +static int sve_reg_region(struct kreg_region *b,
> > +			  const struct kvm_vcpu *vcpu,
> > +			  const struct kvm_one_reg *reg)
> > +{
> > +	const unsigned int vl = vcpu->arch.sve_max_vl;
> > +	const unsigned int vq = sve_vq_from_vl(vl);
> > +
> > +	const unsigned int reg_num =
> > +		(reg->id & SVE_REG_ID_MASK) >> SVE_REG_ID_SHIFT;
> > +	const unsigned int slice_num =
> > +		(reg->id & SVE_REG_SLICE_MASK) >> SVE_REG_SLICE_SHIFT;
> > +
> > +	unsigned int slice_size, offset, limit;
> > +
> > +	if (reg->id >= KVM_REG_ARM64_SVE_ZREG(0, 0) &&
> > +	    reg->id <= KVM_REG_ARM64_SVE_ZREG(SVE_NUM_ZREGS - 1,
> > +					      SVE_NUM_SLICES - 1)) {
> > +		slice_size = KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0));
> > +
> > +		/* Compute start and end of the register: */
> > +		offset = SVE_SIG_ZREG_OFFSET(vq, reg_num) - SVE_SIG_REGS_OFFSET;
> > +		limit = offset + SVE_SIG_ZREG_SIZE(vq);
> > +
> > +		offset += slice_size * slice_num; /* start of requested slice */
> > +
> > +	} else if (reg->id >= KVM_REG_ARM64_SVE_PREG(0, 0) &&
> > +		   reg->id <= KVM_REG_ARM64_SVE_FFR(SVE_NUM_SLICES - 1)) {
> > +		/* (FFR is P16 for our purposes) */
> > +
> > +		slice_size = KVM_REG_SIZE(KVM_REG_ARM64_SVE_PREG(0, 0));
> > +
> > +		/* Compute start and end of the register: */
> > +		offset = SVE_SIG_PREG_OFFSET(vq, reg_num) - SVE_SIG_REGS_OFFSET;
> > +		limit = offset + SVE_SIG_PREG_SIZE(vq);
> > +
> > +		offset += slice_size * slice_num; /* start of requested slice */
> > +
> > +	} else {
> > +		return -ENOENT;
> > +	}
> > +
> > +	b->kptr = (char *)vcpu->arch.sve_state + offset;
> > +
> > +	/*
> > +	 * If the slice starts after the end of the reg, just pad.
> > +	 * Otherwise, copy as much as possible up to slice_size and pad
> > +	 * the remainder:
> > +	 */
> > +	b->size = offset >= limit ? 0 : min(limit - offset, slice_size);
> > +	b->zeropad = slice_size - b->size;
> > +
> > +	return 0;
> > +}
> > +
> > +static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> > +{
> > +	struct kreg_region kreg;
> > +	char __user *uptr = (char __user *)reg->addr;
> > +
> > +	if (!vcpu_has_sve(vcpu) || sve_reg_region(&kreg, vcpu, reg))
> > +		return -ENOENT;
> > +
> > +	if (copy_to_user(uptr, kreg.kptr, kreg.size) ||
> > +	    clear_user(uptr + kreg.size, kreg.zeropad))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> > +{
> > +	struct kreg_region kreg;
> > +	char __user *uptr = (char __user *)reg->addr;
> > +
> > +	if (!vcpu_has_sve(vcpu) || sve_reg_region(&kreg, vcpu, reg))
> > +		return -ENOENT;
> > +
> > +	if (copy_from_user(kreg.kptr, uptr, kreg.size))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> >  int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> >  {
> >  	return -EINVAL;
> > @@ -251,12 +376,11 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
> >  		return -EINVAL;
> >
> > -	/* Register group 16 means we want a core register. */
> > -	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
> > -		return get_core_reg(vcpu, reg);
> > -
> > -	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
> > -		return kvm_arm_get_fw_reg(vcpu, reg);
> > +	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
> > +	case KVM_REG_ARM_CORE:	return get_core_reg(vcpu, reg);
> > +	case KVM_REG_ARM_FW:	return kvm_arm_get_fw_reg(vcpu, reg);
> > +	case KVM_REG_ARM64_SVE:	return get_sve_reg(vcpu, reg);
> > +	}
> >
> >  	if (is_timer_reg(reg->id))
> >  		return get_timer_reg(vcpu, reg);
> > @@ -270,12 +394,11 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  	if ((reg->id & ~KVM_REG_SIZE_MASK) >> 32 != KVM_REG_ARM64 >> 32)
> >  		return -EINVAL;
> >
> > -	/* Register group 16 means we set a core register. */
> > -	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
> > -		return set_core_reg(vcpu, reg);
> > -
> > -	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
> > -		return kvm_arm_set_fw_reg(vcpu, reg);
> > +	switch (reg->id & KVM_REG_ARM_COPROC_MASK) {
> > +	case KVM_REG_ARM_CORE:	return set_core_reg(vcpu, reg);
> > +	case KVM_REG_ARM_FW:	return kvm_arm_set_fw_reg(vcpu, reg);
> > +	case KVM_REG_ARM64_SVE:	return set_sve_reg(vcpu, reg);
> > +	}
> >
> >  	if (is_timer_reg(reg->id))
> >  		return set_timer_reg(vcpu, reg);
> 
> The kernel coding-style.rst seems mute on the subject of default
> handling in switch but it's probably worth having a:
> 
>   default: break; /* falls through */
> 
> to be explicit.

I can add that.  I thought it was reasonably clear given the pattern
being followed here but it may still be a trap for the future.
There's no harm in being explicit, so I will follow your suggestion in
the respin.  

> It's out of scope for this review but I did get a bit confused as the
> KVM_REG_ARM_COPROC_SHIFT registers seems to be fairly spread out across
> the files. We have demux_c15_get/set in sys_regs but doesn't look as
> though it touches the rest of the emulation logic and we have
> kvm_arm_get/set_fw_reg which are "special" PCSI registers. I guess this
> is because COPROC_SHIFT has been used for a bunch of disparate core and
> non-core and special registers.

Not sure I quite get your point, except that yes, handling of different
registers is somewhat spread around the place.  I tried not to make
things worse here than they already are, at least.

Cheers
---Dave
