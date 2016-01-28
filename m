From: drjones@redhat.com (Andrew Jones)
Date: Thu, 28 Jan 2016 19:18:23 +0100
Subject: [PATCH v10 11/21] KVM: ARM64: Add access handler for PMINTENSET
 and PMINTENCLR register
In-Reply-To: <1453866709-20324-12-git-send-email-zhaoshenglong@huawei.com>
References: <1453866709-20324-1-git-send-email-zhaoshenglong@huawei.com>
 <1453866709-20324-12-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160128181823.GC16453@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 11:51:39AM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Since the reset value of PMINTENSET and PMINTENCLR is UNKNOWN, use
> reset_unknown for its reset handler. Add a handler to emulate writing
> PMINTENSET or PMINTENCLR register.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index d43a9a4..41d4bcd 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -630,6 +630,30 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	return true;
>  }
>  
> +static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			   const struct sys_reg_desc *r)
> +{
> +	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
> +
> +	if (!kvm_arm_pmu_v3_ready(vcpu))
> +		return trap_raz_wi(vcpu, p, r);
> +
> +	if (p->is_write) {

The two '& mask' line wrappings are kinda gross. How about doing

                u64 val = p->regval & mask;

here, and then not needing to wrap?

> +		if (r->Op2 & 0x1)
> +			/* accessing PMINTENSET_EL1 */
> +			vcpu_sys_reg(vcpu, PMINTENSET_EL1) |= (p->regval
> +							       & mask);
> +		else
> +			/* accessing PMINTENCLR_EL1 */
> +			vcpu_sys_reg(vcpu, PMINTENSET_EL1) &= ~(p->regval
> +								& mask);
> +	} else {
> +		p->regval = vcpu_sys_reg(vcpu, PMINTENSET_EL1) & mask;
> +	}
> +
> +	return true;
> +}
> +
>  /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
>  #define DBG_BCR_BVR_WCR_WVR_EL1(n)					\
>  	/* DBGBVRn_EL1 */						\
> @@ -788,10 +812,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  
>  	/* PMINTENSET_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b001),
> -	  trap_raz_wi },
> +	  access_pminten, reset_unknown, PMINTENSET_EL1 },
>  	/* PMINTENCLR_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b010),
> -	  trap_raz_wi },
> +	  access_pminten, NULL, PMINTENSET_EL1 },
>  
>  	/* MAIR_EL1 */
>  	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
> @@ -1186,8 +1210,8 @@ static const struct sys_reg_desc cp15_regs[] = {
>  	{ Op1( 0), CRn( 9), CRm(13), Op2( 1), access_pmu_evtyper },
>  	{ Op1( 0), CRn( 9), CRm(13), Op2( 2), access_pmu_evcntr },
>  	{ Op1( 0), CRn( 9), CRm(14), Op2( 0), trap_raz_wi },
> -	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), trap_raz_wi },
> -	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), trap_raz_wi },
> +	{ Op1( 0), CRn( 9), CRm(14), Op2( 1), access_pminten },
> +	{ Op1( 0), CRn( 9), CRm(14), Op2( 2), access_pminten },
>  
>  	{ Op1( 0), CRn(10), CRm( 2), Op2( 0), access_vm_reg, NULL, c10_PRRR },
>  	{ Op1( 0), CRn(10), CRm( 2), Op2( 1), access_vm_reg, NULL, c10_NMRR },
> -- 
> 2.0.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
