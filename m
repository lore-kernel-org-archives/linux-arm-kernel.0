From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 29 Jan 2016 10:07:19 +0800
Subject: [PATCH v10 04/21] KVM: ARM64: Add access handler for PMCR register
In-Reply-To: <20160128204317.GJ16453@hawk.localdomain>
References: <1453866709-20324-1-git-send-email-zhaoshenglong@huawei.com>
 <1453866709-20324-5-git-send-email-zhaoshenglong@huawei.com>
 <20160128153635.GB3807@hawk.localdomain>
 <20160128204317.GJ16453@hawk.localdomain>
Message-ID: <56AAC957.5070601@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/29 4:43, Andrew Jones wrote:
> On Thu, Jan 28, 2016 at 04:36:35PM +0100, Andrew Jones wrote:
>> > On Wed, Jan 27, 2016 at 11:51:32AM +0800, Shannon Zhao wrote:
>>> > > From: Shannon Zhao <shannon.zhao@linaro.org>
>>> > > 
>>> > > Add reset handler which gets host value of PMCR_EL0 and make writable
>>> > > bits architecturally UNKNOWN except PMCR.E which is zero. Add an access
>>> > > handler for PMCR.
>>> > > 
>>> > > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>>> > > ---
>>> > >  arch/arm64/kvm/sys_regs.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>>> > >  include/kvm/arm_pmu.h     |  4 ++++
>>> > >  2 files changed, 44 insertions(+), 2 deletions(-)
>>> > > 
>>> > > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>> > > index eec3598..97fea84 100644
>>> > > --- a/arch/arm64/kvm/sys_regs.c
>>> > > +++ b/arch/arm64/kvm/sys_regs.c
>>> > > @@ -34,6 +34,7 @@
>>> > >  #include <asm/kvm_emulate.h>
>>> > >  #include <asm/kvm_host.h>
>>> > >  #include <asm/kvm_mmu.h>
>>> > > +#include <asm/pmu.h>
>>> > >  
>>> > >  #include <trace/events/kvm.h>
>>> > >  
>>> > > @@ -439,6 +440,43 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>>> > >  	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1ULL << 31) | mpidr;
>>> > >  }
>>> > >  
>>> > > +static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>>> > > +{
>>> > > +	u64 pmcr, val;
>>> > > +
>>> > > +	asm volatile("mrs %0, pmcr_el0\n" : "=r" (pmcr));
>>> > > +	/* Writable bits of PMCR_EL0 (ARMV8_PMCR_MASK) is reset to UNKNOWN
>>> > > +	 * except PMCR.E resetting to zero.
>>> > > +	 */
>>> > > +	val = ((pmcr & ~ARMV8_PMCR_MASK) | (ARMV8_PMCR_MASK & 0xdecafbad))
>>> > > +	      & (~ARMV8_PMCR_E);
>>> > > +	vcpu_sys_reg(vcpu, PMCR_EL0) = val;
>>> > > +}
>>> > > +
>>> > > +static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>>> > > +			const struct sys_reg_desc *r)
>>> > > +{
>>> > > +	u64 val;
>>> > > +
>>> > > +	if (!kvm_arm_pmu_v3_ready(vcpu))
>>> > > +		return trap_raz_wi(vcpu, p, r);
>>> > > +
>>> > > +	if (p->is_write) {
>>> > > +		/* Only update writeable bits of PMCR */
>>> > > +		val = vcpu_sys_reg(vcpu, PMCR_EL0);
>>> > > +		val &= ~ARMV8_PMCR_MASK;
>>> > > +		val |= p->regval & ARMV8_PMCR_MASK;
>>> > > +		vcpu_sys_reg(vcpu, PMCR_EL0) = val;
>>> > > +	} else {
>>> > > +		/* PMCR.P & PMCR.C are RAZ */
>>> > > +		val = vcpu_sys_reg(vcpu, PMCR_EL0)
>>> > > +		      & ~(ARMV8_PMCR_P | ARMV8_PMCR_C);
>>> > > +		p->regval = val;
>> > 
>> > Should we also be setting the IMP, IDCODE, and N fields here to the
>> > values of the host PE?
> Not sure how I skimmed over the reset_pmcr doing this when I first
> read it. I'm now wondering if we want to always expose the host's
> IMP, IDCODE, N though (migration concerns). Although we have a ton
> of invariant sys regs already... So I guess this is a bridge to burn
> another day.
> 
There is a discussion about this. For migrating across different CPU
types, the userspace will set the number of PMU counters and as
discussed it will add some codes in the reset_pmcr to check if the
userspace have set the number, if so set N as the value. But these will
be done after this patch set and by the cross-cpu type support patch
set[1](currently this patch set doesn't set the PMU counters but I
discussed this with Tushar before).

[1]https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg02375.html

Thanks,
-- 
Shannon
