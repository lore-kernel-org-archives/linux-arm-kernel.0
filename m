From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 28 Mar 2017 14:44:55 +0200
Subject: [PATCH v2 2/9] arm64: KVM: PMU: Inject UNDEF exception on
 illegal register access
In-Reply-To: <20170327160345.12402-3-marc.zyngier@arm.com>
References: <20170327160345.12402-1-marc.zyngier@arm.com>
 <20170327160345.12402-3-marc.zyngier@arm.com>
Message-ID: <20170328124455.GB31156@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 05:03:38PM +0100, Marc Zyngier wrote:
> Both pmu_*_el0_disabled() and pmu_counter_idx_valid() perform checks
> on the validity of an access, but only return a boolean indicating
> if the access is valid or not.
> 
> Let's allow these functions to also inject an UNDEF exception if
> the access was illegal.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>

> ---
>  arch/arm64/kvm/sys_regs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 7e1d673304d5..d98ce9a52291 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -465,6 +465,9 @@ static bool check_disabled(struct kvm_vcpu *vcpu, u64 flags)
>  	u64 reg = vcpu_sys_reg(vcpu, PMUSERENR_EL0);
>  	bool cond = (reg & flags) || vcpu_mode_priv(vcpu);
>  
> +	if (!cond)
> +		kvm_inject_undefined(vcpu);
> +
>  	return !cond;
>  }
>  
> @@ -564,8 +567,10 @@ static bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
>  
>  	pmcr = vcpu_sys_reg(vcpu, PMCR_EL0);
>  	val = (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
> -	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX)
> +	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
> +		kvm_inject_undefined(vcpu);
>  		return false;
> +	}
>  
>  	return true;
>  }
> -- 
> 2.11.0
> 
