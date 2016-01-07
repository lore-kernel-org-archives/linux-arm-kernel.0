From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 7 Jan 2016 19:16:34 +0800
Subject: [PATCH v8 04/20] KVM: ARM64: Add access handler for PMCR register
In-Reply-To: <568E413D.8010701@arm.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-5-git-send-email-zhaoshenglong@huawei.com>
 <568E413D.8010701@arm.com>
Message-ID: <568E4912.80706@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/7 18:43, Marc Zyngier wrote:
> On 22/12/15 08:07, Shannon Zhao wrote:
>> > From: Shannon Zhao <shannon.zhao@linaro.org>
>> > 
>> > Add reset handler which gets host value of PMCR_EL0 and make writable
>> > bits architecturally UNKNOWN except PMCR.E which is zero. Add an access
>> > handler for PMCR.
>> > 
>> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> > ---
>> >  arch/arm64/kvm/sys_regs.c | 39 +++++++++++++++++++++++++++++++++++++--
>> >  1 file changed, 37 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> > index e8bf374..c60047e 100644
>> > --- a/arch/arm64/kvm/sys_regs.c
>> > +++ b/arch/arm64/kvm/sys_regs.c
>> > @@ -34,6 +34,7 @@
>> >  #include <asm/kvm_emulate.h>
>> >  #include <asm/kvm_host.h>
>> >  #include <asm/kvm_mmu.h>
>> > +#include <asm/pmu.h>
>> >  
>> >  #include <trace/events/kvm.h>
>> >  
>> > @@ -439,6 +440,40 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>> >  	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1ULL << 31) | mpidr;
>> >  }
>> >  
>> > +static void reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>> > +{
>> > +	u64 pmcr, val;
>> > +
>> > +	asm volatile("mrs %0, pmcr_el0\n" : "=r" (pmcr));
>> > +	/* Writable bits of PMCR_EL0 (ARMV8_PMCR_MASK) is reset to UNKNOWN
>> > +	 * except PMCR.E resetting to zero.
>> > +	 */
>> > +	val = ((pmcr & ~ARMV8_PMCR_MASK) | (ARMV8_PMCR_MASK & 0xdecafbad))
>> > +	      & (~ARMV8_PMCR_E);
>> > +	vcpu_sys_reg(vcpu, r->reg) = val;
>> > +}
>> > +
>> > +static bool access_pmcr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>> > +			const struct sys_reg_desc *r)
>> > +{
>> > +	u64 val;
>> > +
>> > +	if (p->is_write) {
>> > +		/* Only update writeable bits of PMCR */
>> > +		val = vcpu_sys_reg(vcpu, r->reg);
>> > +		val &= ~ARMV8_PMCR_MASK;
>> > +		val |= p->regval & ARMV8_PMCR_MASK;
>> > +		vcpu_sys_reg(vcpu, r->reg) = val;
>> > +	} else {
>> > +		/* PMCR.P & PMCR.C are RAZ */
>> > +		val = vcpu_sys_reg(vcpu, r->reg)
>> > +		      & ~(ARMV8_PMCR_P | ARMV8_PMCR_C);
>> > +		p->regval = val;
>> > +	}
> How can that work for 32bit, where r->reg is not populated from the trap
> table? You *know* that you are accessing PMCR, so just use PMCR_EL0 as
> an index into vcpu_sys_reg() in all cases. You can then drop PMCR_EL0
> from the 64bit trap table entry.
> 
Oh, sorry for this bug. Will fix this and those in other places.

Thanks,
-- 
Shannon
