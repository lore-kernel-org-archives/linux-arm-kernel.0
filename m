From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 1 Dec 2015 10:42:30 +0800
Subject: [PATCH v4 08/21] KVM: ARM64: Add reset and access handlers for
 PMXEVTYPER register
In-Reply-To: <20151130181247.55649fc7@arm.com>
References: <1446186123-11548-1-git-send-email-zhaoshenglong@huawei.com>	<1446186123-11548-9-git-send-email-zhaoshenglong@huawei.com>
 <20151130181247.55649fc7@arm.com>
Message-ID: <565D0916.5030300@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/1 2:12, Marc Zyngier wrote:
> On Fri, 30 Oct 2015 14:21:50 +0800
> Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> 
>> > From: Shannon Zhao <shannon.zhao@linaro.org>
>> > 
>> > Since the reset value of PMXEVTYPER is UNKNOWN, use reset_unknown or
>> > reset_unknown_cp15 for its reset handler. Add access handler which
>> > emulates writing and reading PMXEVTYPER register. When writing to
>> > PMXEVTYPER, call kvm_pmu_set_counter_event_type to create a perf_event
>> > for the selected event type.
>> > 
>> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> > ---
>> >  arch/arm64/kvm/sys_regs.c | 26 ++++++++++++++++++++++++--
>> >  1 file changed, 24 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> > index cb82b15..4e606ea 100644
>> > --- a/arch/arm64/kvm/sys_regs.c
>> > +++ b/arch/arm64/kvm/sys_regs.c
>> > @@ -491,6 +491,17 @@ static bool access_pmu_regs(struct kvm_vcpu *vcpu,
>> >  
>> >  	if (p->is_write) {
>> >  		switch (r->reg) {
>> > +		case PMXEVTYPER_EL0: {
>> > +			val = vcpu_sys_reg(vcpu, PMSELR_EL0);
>> > +			kvm_pmu_set_counter_event_type(vcpu,
>> > +						       *vcpu_reg(vcpu, p->Rt),
>> > +						       val);
> You are blindingly truncating 64bit values to u32. Is that intentional?
> 
Yeah, the register PMXEVTYPER_EL0 and PMSELR_EL0 are all 32bit.

-- 
Shannon
