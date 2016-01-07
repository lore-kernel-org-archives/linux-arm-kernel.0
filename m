From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 7 Jan 2016 22:00:11 +0800
Subject: [PATCH v8 07/20] KVM: ARM64: PMU: Add perf event map and introduce
 perf event creating function
In-Reply-To: <20160107134857.2c18d752@arm.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>	<1450771695-11948-8-git-send-email-zhaoshenglong@huawei.com>
 <20160107134857.2c18d752@arm.com>
Message-ID: <568E6F6B.3060500@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/7 21:48, Marc Zyngier wrote:
>> +	if (pmc->perf_event) {
>> > +		counter = kvm_pmu_get_counter_value(vcpu, pmc->idx);
>> > +		reg = (pmc->idx == ARMV8_CYCLE_IDX)
>> > +		       ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + pmc->idx;
>> > +		vcpu_sys_reg(vcpu, reg) = counter;
>> > +		perf_event_release_kernel(pmc->perf_event);
> I'm having second thoughts about this one. Don't you need to first
> disable the event? You seem to be doing it on the destroy path, and it
> worries me that we're not doing the same thing on both paths.

I didn't find the limitation to use perf_event_release_kernel, but it's
better to disable it before release. Will add.

Thanks,
-- 
Shannon
