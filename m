From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 Dec 2015 08:56:45 +0000
Subject: [PATCH v6 12/21] KVM: ARM64: Add reset and access handlers for
 PMCNTENSET and PMCNTENCLR register
In-Reply-To: <5667E7EE.90908@huawei.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
 <1449578860-15808-13-git-send-email-zhaoshenglong@huawei.com>
 <56670865.2050705@arm.com> <5667E7EE.90908@huawei.com>
Message-ID: <20151209085645.29fd224c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Dec 2015 16:35:58 +0800
Shannon Zhao <zhaoshenglong@huawei.com> wrote:

> 
> 
> On 2015/12/9 0:42, Marc Zyngier wrote:
> >> +void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u32 val, bool all_enable)
> >> > +{
> >> > +	int i;
> >> > +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> >> > +	struct kvm_pmc *pmc;
> >> > +
> >> > +	if (!all_enable)
> >> > +		return;
> > You have the vcpu. Can you move the check for PMCR_EL0.E here instead of
> > having it in both of the callers?
> > 
> But it still needs to check PMCR_EL0.E in kvm_pmu_handle_pmcr(). When
> PMCR_EL0.E == 1, it calls kvm_pmu_enable_counter(), otherwise it calls
> kvm_pmu_disable_counter(). So as it checks already, just pass the result
> as a parameter.

I've seen that, but it makes the code look ugly. At any rate, you might
as well not call enable_counter if PMCR.E==0. But splitting the lookup
of the bit and the test like you do is not nice at all. Making it
self-contained looks a lot better, and you don't have to think about
the caller.

> >> > +
> >> > +	for_each_set_bit(i, (const unsigned long *)&val, ARMV8_MAX_COUNTERS) {
> > Nonononono... If you must have to use a long, use a long. Don't cast it
> > to a different type (hint: big endian).
> > 
> >> > +		pmc = &pmu->pmc[i];
> >> > +		if (pmc->perf_event) {
> >> > +			perf_event_enable(pmc->perf_event);
> >> > +			if (pmc->perf_event->state != PERF_EVENT_STATE_ACTIVE)
> >> > +				kvm_debug("fail to enable perf event\n");
> >> > +		}
> >> > +	}
> >> > +}
> >> > +
> >> > +/**
> >> > + * kvm_pmu_disable_counter - disable selected PMU counter
> >> > + * @vcpu: The vcpu pointer
> >> > + * @val: the value guest writes to PMCNTENCLR register
> >> > + *
> >> > + * Call perf_event_disable to stop counting the perf event
> >> > + */
> >> > +void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u32 val)
> >> > +{
> >> > +	int i;
> >> > +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> >> > +	struct kvm_pmc *pmc;
> >> > +
> > Why are enable and disable asymmetric (handling of PMCR.E)?
> > 
> To enable a counter, it needs both the PMCR_EL0.E and the corresponding
> bit of PMCNTENSET_EL0 set to 1. But to disable a counter, it only needs
> one of them and when PMCR_EL0.E == 0? it disables all the counters.

OK.

	M.
-- 
Jazz is not dead. It just smells funny.
