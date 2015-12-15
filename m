From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Dec 2015 14:26:40 +0000
Subject: [PATCH v7 08/19] KVM: ARM64: Add access handler for event typer
 register
In-Reply-To: <1450169379-12336-9-git-send-email-zhaoshenglong@huawei.com>
References: <1450169379-12336-1-git-send-email-zhaoshenglong@huawei.com>
 <1450169379-12336-9-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <56702320.1030802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/15 08:49, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> These kind of registers include PMEVTYPERn, PMCCFILTR and PMXEVTYPER
> which is mapped to PMEVTYPERn or PMCCFILTR.
> 
> The access handler translates all aarch32 register offsets to aarch64
> ones and uses vcpu_sys_reg() to access their values to avoid taking care
> of big endian.
> 
> When writing to these registers, create a perf_event for the selected
> event type.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 154 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 152 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index e043224..c52ff15 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -504,6 +504,68 @@ static bool access_pmceid(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	return true;
>  }
>  
> +static inline bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
> +{
> +	u64 pmcr, val;
> +
> +	pmcr = vcpu_sys_reg(vcpu, PMCR_EL0);
> +	val = (pmcr >> ARMV8_PMCR_N_SHIFT) & ARMV8_PMCR_N_MASK;
> +	if (idx >= val && idx != ARMV8_CYCLE_IDX)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			       const struct sys_reg_desc *r)
> +{
> +	u64 idx, reg;
> +
> +	if (r->CRn == 9) {
> +		/* PMXEVTYPER_EL0 */
> +		reg = 0;
> +	} else {
> +		if (!p->is_aarch32) {
> +			/* PMEVTYPERn_EL0 or PMCCFILTR_EL0 */
> +			reg = r->reg;
> +		} else {
> +			if (r->CRn == 14 && r->CRm == 15 && r->Op2 == 7) {
> +				reg = PMCCFILTR_EL0;
> +			} else {
> +				reg = ((r->CRm & 3) << 3) & (r->Op2 & 7);
> +				reg += PMEVTYPER0_EL0;
> +			}
> +		}
> +	}
> +
> +	switch (reg) {
> +	case PMEVTYPER0_EL0 ... PMEVTYPER30_EL0:
> +		idx = reg - PMEVTYPER0_EL0;
> +		break;
> +	case PMCCFILTR_EL0:
> +		idx = ARMV8_CYCLE_IDX;
> +		break;
> +	default:
> +		/* PMXEVTYPER_EL0 */
> +		idx = vcpu_sys_reg(vcpu, PMSELR_EL0) & ARMV8_COUNTER_MASK;
> +		if (!pmu_counter_idx_valid(vcpu, idx))
> +			return true;

Shouldn't you check the validity of the index in the first case as well?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
