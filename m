From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 07 Jan 2016 11:13:10 +0000
Subject: [PATCH v8 11/20] KVM: ARM64: Add access handler for PMINTENSET
 and PMINTENCLR register
In-Reply-To: <1450771695-11948-12-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-12-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <568E4846.2040304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/15 08:08, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Since the reset value of PMINTENSET and PMINTENCLR is UNKNOWN, use
> reset_unknown for its reset handler. Add a handler to emulate writing
> PMINTENSET or PMINTENCLR register.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 3416881..24ce4fe 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -644,6 +644,25 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	return true;
>  }
>  
> +static bool access_pminten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			   const struct sys_reg_desc *r)
> +{
> +	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
> +
> +	if (p->is_write) {
> +		if (r->Op2 & 0x1)
> +			/* accessing PMINTENSET_EL1 */
> +			vcpu_sys_reg(vcpu, r->reg) |= (p->regval & mask);
> +		else
> +			/* accessing PMINTENCLR_EL1 */
> +			vcpu_sys_reg(vcpu, r->reg) &= ~(p->regval & mask);
> +	} else {
> +		p->regval = vcpu_sys_reg(vcpu, r->reg) & mask;
> +	}
> +
> +	return true;
> +}
> +

Same bug again.

	M.
-- 
Jazz is not dead. It just smells funny...
