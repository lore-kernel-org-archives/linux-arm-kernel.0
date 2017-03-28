From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 28 Mar 2017 14:45:20 +0200
Subject: [PATCH v2 5/9] arm64: KVM: PMU: Inject UNDEF on read access to
 PMSWINC_EL0
In-Reply-To: <20170327160345.12402-6-marc.zyngier@arm.com>
References: <20170327160345.12402-1-marc.zyngier@arm.com>
 <20170327160345.12402-6-marc.zyngier@arm.com>
Message-ID: <20170328124520.GE31156@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 05:03:41PM +0100, Marc Zyngier wrote:
> PMSWINC_EL0 is a WO register, so let's UNDEF when reading from it
> (in the highly hypothetical case where this doesn't UNDEF at EL1).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>

> ---
>  arch/arm64/kvm/sys_regs.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 19a036b4f6ac..f80a61af5e88 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -772,16 +772,15 @@ static bool access_pmswinc(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	if (!kvm_arm_pmu_v3_ready(vcpu))
>  		return trap_raz_wi(vcpu, p, r);
>  
> +	if (!p->is_write)
> +		return read_from_write_only(vcpu, p);
> +
>  	if (pmu_write_swinc_el0_disabled(vcpu))
>  		return false;
>  
> -	if (p->is_write) {
> -		mask = kvm_pmu_valid_counter_mask(vcpu);
> -		kvm_pmu_software_increment(vcpu, p->regval & mask);
> -		return true;
> -	}
> -
> -	return false;
> +	mask = kvm_pmu_valid_counter_mask(vcpu);
> +	kvm_pmu_software_increment(vcpu, p->regval & mask);
> +	return true;
>  }
>  
>  static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> -- 
> 2.11.0
> 
