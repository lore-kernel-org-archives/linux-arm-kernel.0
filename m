From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Dec 2015 13:42:02 +0000
Subject: [PATCH v5 11/21] KVM: ARM64: Add reset and access handlers for
 PMCNTENSET and PMCNTENCLR register
In-Reply-To: <1449123091-20252-12-git-send-email-zhaoshenglong@huawei.com>
References: <1449123091-20252-1-git-send-email-zhaoshenglong@huawei.com>
 <1449123091-20252-12-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <56658CAA.4010200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/15 06:11, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Since the reset value of PMCNTENSET and PMCNTENCLR is UNKNOWN, use
> reset_unknown for its reset handler. Add a new case to emulate writing
> PMCNTENSET or PMCNTENCLR register.
> 
> When writing to PMCNTENSET, call perf_event_enable to enable the perf
> event. When writing to PMCNTENCLR, call perf_event_disable to disable
> the perf event.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 52 +++++++++++++++++++++++++++++++++++++++++++----
>  include/kvm/arm_pmu.h     |  4 ++++
>  virt/kvm/arm/pmu.c        | 47 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 9e06fe8..e852e5d 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -526,6 +526,27 @@ static bool access_pmu_regs(struct kvm_vcpu *vcpu,
>  			vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + idx) = val;
>  			break;
>  		}
> +		case PMCNTENSET_EL0: {
> +			val = *vcpu_reg(vcpu, p->Rt);
> +			kvm_pmu_enable_counter(vcpu, val,
> +				   vcpu_sys_reg(vcpu, PMCR_EL0) & ARMV8_PMCR_E);
> +			/* Value 1 of PMCNTENSET_EL0 and PMCNTENCLR_EL0 means
> +			 * corresponding counter enabled.
> +			 */
> +			vcpu_sys_reg(vcpu, r->reg) |= val;
> +			vcpu_sys_reg(vcpu, PMCNTENCLR_EL0) |= val;
> +			break;
> +		}
> +		case PMCNTENCLR_EL0: {
> +			val = *vcpu_reg(vcpu, p->Rt);
> +			kvm_pmu_disable_counter(vcpu, val);
> +			/* Value 0 of PMCNTENSET_EL0 and PMCNTENCLR_EL0 means
> +			 * corresponding counter disabled.
> +			 */
> +			vcpu_sys_reg(vcpu, r->reg) &= ~val;
> +			vcpu_sys_reg(vcpu, PMCNTENSET_EL0) &= ~val;
> +			break;
> +		}

You have the exact same problem here. These registers are the two side
of the same coin. You should only have a single state describing the
state of the counters, and PMCNTEN{SET,CLR}_EL0 just being accessors for
that state.

Rule of thumb: if you have to write the same value twice, you're doing
the wrong thing.

Thanks,
	
	M.
-- 
Jazz is not dead. It just smells funny...
