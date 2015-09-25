From: hillf.zj@alibaba-inc.com (Hillf Danton)
Date: Fri, 25 Sep 2015 17:22:50 +0800
Subject: [PATCH v3 11/20] KVM: ARM64: Add reset and access handlers for
 PMCNTENSET and PMCNTENCLR register
In-Reply-To: <028b01d0f773$2418d010$6c4a7030$@alibaba-inc.com>
References: <028b01d0f773$2418d010$6c4a7030$@alibaba-inc.com>
Message-ID: <028c01d0f773$c025d930$40718b90$@alibaba-inc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + * kvm_pmu_enable_counter - enable selected PMU counter
> + * @vcpu: The vcpu pointer
> + * @val: the value guest writes to PMCNTENSET register
> + *
> + * Call perf_event_enable to start counting the perf event
> + */
> +void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u32 val)
> +{
> +	int i;
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc;
> +
> +	for (i = 0; i < 32; i++) {

Replace 32 with defined macro please.

> +		if ((val >> i) & 0x1) {
> +			pmc = &pmu->pmc[i];
> +			if (pmc->perf_event) {
> +				perf_event_enable(pmc->perf_event);
> +				if (pmc->perf_event->state
> +				    != PERF_EVENT_STATE_ACTIVE)
> +					kvm_debug("fail to enable event\n");
> +			}
> +		}
> +	}
> +}
> +
> +/**
> + * kvm_pmu_disable_counter - disable selected PMU counter
> + * @vcpu: The vcpu pointer
> + * @val: the value guest writes to PMCNTENCLR register
> + *
> + * Call perf_event_disable to stop counting the perf event
> + */
> +void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u32 val)
> +{
> +	int i;
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc;
> +
> +	for (i = 0; i < 32; i++) {

ditto
> +		if ((val >> i) & 0x1) {
> +			pmc = &pmu->pmc[i];
> +			if (pmc->perf_event)
> +				perf_event_disable(pmc->perf_event);
> +		}
> +	}
> +}
