From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 02 Nov 2015 16:20:40 -0500
Subject: [PATCH v4 17/21] KVM: ARM64: Add helper to handle PMCR
 register bits
In-Reply-To: <1446186123-11548-18-git-send-email-zhaoshenglong@huawei.com>
References: <1446186123-11548-1-git-send-email-zhaoshenglong@huawei.com>
 <1446186123-11548-18-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <5637D3A8.1040500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2015 02:21 AM, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> According to ARMv8 spec, when writing 1 to PMCR.E, all counters are
> enabled by PMCNTENSET, while writing 0 to PMCR.E, all counters are
> disabled. When writing 1 to PMCR.P, reset all event counters, not
> including PMCCNTR, to zero. When writing 1 to PMCR.C, reset PMCCNTR to
> zero.

> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index ae21089..11d1bfb 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -121,6 +121,56 @@ void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u32 val)
>  }
>  
>  /**
> + * kvm_pmu_handle_pmcr - handle PMCR register
> + * @vcpu: The vcpu pointer
> + * @val: the value guest writes to PMCR register
> + */
> +void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u32 val)
> +{
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc;
> +	u32 enable;
> +	int i;
> +
> +	if (val & ARMV8_PMCR_E) {
> +		if (!vcpu_mode_is_32bit(vcpu))
> +			enable = vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
> +		else
> +			enable = vcpu_cp15(vcpu, c9_PMCNTENSET);
> +
> +		kvm_pmu_enable_counter(vcpu, enable, true);
> +	} else
> +		kvm_pmu_disable_counter(vcpu, 0xffffffffUL);

Nit: If using braces on one side of if-else, please use them on the other.
(Search for "braces in both branches" in Documentation/CodingStyle.)

> +
> +	if (val & ARMV8_PMCR_C) {
> +		pmc = &pmu->pmc[ARMV8_MAX_COUNTERS - 1];
> +		if (pmc->perf_event)
> +			local64_set(&pmc->perf_event->count, 0);
> +		if (!vcpu_mode_is_32bit(vcpu))
> +			vcpu_sys_reg(vcpu, PMCCNTR_EL0) = 0;
> +		else
> +			vcpu_cp15(vcpu, c9_PMCCNTR) = 0;
> +	}
> +
> +	if (val & ARMV8_PMCR_P) {
> +		for (i = 0; i < ARMV8_MAX_COUNTERS - 1; i++) {
> +			pmc = &pmu->pmc[i];
> +			if (pmc->perf_event)
> +				local64_set(&pmc->perf_event->count, 0);
> +			if (!vcpu_mode_is_32bit(vcpu))
> +				vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) = 0;
> +			else
> +				vcpu_cp15(vcpu, c14_PMEVCNTR0 + i) = 0;
> +		}
> +	}
> +
> +	if (val & ARMV8_PMCR_LC) {
> +		pmc = &pmu->pmc[ARMV8_MAX_COUNTERS - 1];
> +		pmc->bitmask = 0xffffffffffffffffUL;
> +	}
> +}
> +
> +/**
>   * kvm_pmu_overflow_clear - clear PMU overflow interrupt
>   * @vcpu: The vcpu pointer
>   * @val: the value guest writes to PMOVSCLR register
> 


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
