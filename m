From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 06 Aug 2013 09:43:25 +0100
Subject: [PATCH] ARM: KVM: Fix 64-bit coprocessor handling
In-Reply-To: <1375764086-1996-1-git-send-email-christoffer.dall@linaro.org>
References: <1375764086-1996-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <5200B72D.2080101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 06/08/13 05:41, Christoffer Dall wrote:
> The PAR was exported as CRn == 7 and CRm == 0, but in fact the primary
> coprocessor register number was determined by CRm for 64-bit coprocessor
> registers as the user space API was modelled after the coprocessor
> access instructions (see the ARM ARM rev. C - B3-1445).
> 
> However, just changing the CRn to CRm breaks the sorting check when
> booting the kernel, because the internal kernel logic always treats CRn
> as the primary register number, and it makes the table sorting
> impossible to understand for humans.
> 
> Alternatively we could change the logic to always have CRn == CRm, but
> that becomes unclear in the number of ways we do lookup of a coprocessor
> register.  We could also have a separate 64-bit table but that feels
> somewhat over-engineerd.  Instead, keep CRn the primary representation

over-engineered

> of the primary corproc. register number in-kernel and always export the

coproc.

> primary number as CRm as per the existing user space ABI.
> 
> Note: The TTBR registers just magically worked because they happened to
> follow the CRn(0) regs and were considered CRn(0) in the in-kernel
> representation.

Nice catch. This unfortunately shows how little of the userspace
interface we've been actually using so far. I suppose you found this by
playing with save/restore?

> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/kvm/coproc.c     |   23 +++++++++++++++++------
>  arch/arm/kvm/coproc.h     |    2 ++
>  arch/arm/kvm/coproc_a15.c |    5 ++++-
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
> index 4a51990..fc5fec2 100644
> --- a/arch/arm/kvm/coproc.c
> +++ b/arch/arm/kvm/coproc.c
> @@ -146,7 +146,10 @@ static bool pm_fake(struct kvm_vcpu *vcpu,
>  #define access_pmintenclr pm_fake
>  
>  /* Architected CP15 registers.
> - * Important: Must be sorted ascending by CRn, CRM, Op1, Op2
> + * CRn denotes the primary register number, but is copied to the CRm in the
> + * user space API in line with the terminology used in the ARM ARM.

Please consider adding something like "in the 64bit case only".

> + * Important: Must be sorted ascending by CRn, CRM, Op1, Op2 and with 64-bit
> + *            registers preceeding 32-bit ones.

preceding

>   */
>  static const struct coproc_reg cp15_regs[] = {
>  	/* CSSELR: swapped by interrupt.S. */
> @@ -154,8 +157,8 @@ static const struct coproc_reg cp15_regs[] = {
>  			NULL, reset_unknown, c0_CSSELR },
>  
>  	/* TTBR0/TTBR1: swapped by interrupt.S. */
> -	{ CRm( 2), Op1( 0), is64, NULL, reset_unknown64, c2_TTBR0 },
> -	{ CRm( 2), Op1( 1), is64, NULL, reset_unknown64, c2_TTBR1 },
> +	{ CRn( 2), Op1( 0), is64, NULL, reset_unknown64, c2_TTBR0 },
> +	{ CRn( 2), Op1( 1), is64, NULL, reset_unknown64, c2_TTBR1 },

How about this (untested) alternative possibility:

#define CRm64(_x)	.CRn = _x, .is64 = 1,
	{ CRm64( 2), Op1( 0), NULL, reset_unknown64, c2_TTBR0 },
	{ CRm64( 2), Op1( 1), NULL, reset_unknown64, c2_TTBR1 },

It has the benefit of still showing CRm as being the official field, and
hide the ugliness into the macro.

Still ugly though...

>  	/* TTBCR: swapped by interrupt.S. */
>  	{ CRn( 2), CRm( 0), Op1( 0), Op2( 2), is32,
> @@ -399,12 +402,13 @@ static bool index_to_params(u64 id, struct coproc_params *params)
>  			      | KVM_REG_ARM_OPC1_MASK))
>  			return false;
>  		params->is_64bit = true;
> -		params->CRm = ((id & KVM_REG_ARM_CRM_MASK)
> +		/* CRm to CRn: see cp15_to_index for details */
> +		params->CRn = ((id & KVM_REG_ARM_CRM_MASK)
>  			       >> KVM_REG_ARM_CRM_SHIFT);
>  		params->Op1 = ((id & KVM_REG_ARM_OPC1_MASK)
>  			       >> KVM_REG_ARM_OPC1_SHIFT);
>  		params->Op2 = 0;
> -		params->CRn = 0;
> +		params->CRm = 0;
>  		return true;
>  	default:
>  		return false;
> @@ -898,7 +902,14 @@ static u64 cp15_to_index(const struct coproc_reg *reg)
>  	if (reg->is_64) {
>  		val |= KVM_REG_SIZE_U64;
>  		val |= (reg->Op1 << KVM_REG_ARM_OPC1_SHIFT);
> -		val |= (reg->CRm << KVM_REG_ARM_CRM_SHIFT);
> +		/*
> +		 * CRn always denotes the primary coproc. reg. nr. for the
> +		 * in-kernel representation, but the user space API uses the
> +		 * CRm for the encoding, because it is modelled after the
> +		 * MRRC/MCRR instructions: see the ARM ARM rev. c page
> +		 * B3-1445
> +		 */
> +		val |= (reg->CRn << KVM_REG_ARM_CRM_SHIFT);
>  	} else {
>  		val |= KVM_REG_SIZE_U32;
>  		val |= (reg->Op1 << KVM_REG_ARM_OPC1_SHIFT);
> diff --git a/arch/arm/kvm/coproc.h b/arch/arm/kvm/coproc.h
> index b7301d3..dccb904 100644
> --- a/arch/arm/kvm/coproc.h
> +++ b/arch/arm/kvm/coproc.h
> @@ -135,6 +135,8 @@ static inline int cmp_reg(const struct coproc_reg *i1,
>  		return -1;
>  	if (i1->CRn != i2->CRn)
>  		return i1->CRn - i2->CRn;
> +	if (i1->is_64 != i2->is_64)
> +		return i2->is_64 - i1->is_64;
>  	if (i1->CRm != i2->CRm)
>  		return i1->CRm - i2->CRm;
>  	if (i1->Op1 != i2->Op1)
> diff --git a/arch/arm/kvm/coproc_a15.c b/arch/arm/kvm/coproc_a15.c
> index 685063a..3d8f61f 100644
> --- a/arch/arm/kvm/coproc_a15.c
> +++ b/arch/arm/kvm/coproc_a15.c
> @@ -114,7 +114,10 @@ static bool access_l2ectlr(struct kvm_vcpu *vcpu,
>  
>  /*
>   * A15-specific CP15 registers.
> - * Important: Must be sorted ascending by CRn, CRM, Op1, Op2
> + * CRn denotes the primary register number, but is copied to the CRm in the
> + * user space API in line with the terminology used in the ARM ARM.
> + * Important: Must be sorted ascending by CRn, CRM, Op1, Op2 and with 64-bit
> + *            registers preceeding 32-bit ones.
>   */
>  static const struct coproc_reg a15_regs[] = {
>  	/* MPIDR: we use VMPIDR for guest access. */
> 

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
