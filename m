From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 07 Jan 2016 10:43:46 +0000
Subject: [PATCH v8 05/20] KVM: ARM64: Add access handler for PMSELR
 register
In-Reply-To: <1450771695-11948-6-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-6-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <568E4162.8030508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/12/15 08:08, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Since the reset value of PMSELR_EL0 is UNKNOWN, use reset_unknown for
> its reset handler. When reading PMSELR, return the PMSELR.SEL field to
> guest.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index c60047e..f9985fc 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -474,6 +474,18 @@ static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	return true;
>  }
>  
> +static bool access_pmselr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			  const struct sys_reg_desc *r)
> +{
> +	if (p->is_write)
> +		vcpu_sys_reg(vcpu, r->reg) = p->regval;
> +	else
> +		/* return PMSELR.SEL field */
> +		p->regval = vcpu_sys_reg(vcpu, r->reg) & ARMV8_COUNTER_MASK;

Same 32bit bug again.

	M.
-- 
Jazz is not dead. It just smells funny...
