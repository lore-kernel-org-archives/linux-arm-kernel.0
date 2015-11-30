From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 Nov 2015 13:19:22 +0000
Subject: [PATCH v4 06/21] KVM: ARM64: Add reset and access handlers for
 PMCEID0 and PMCEID1 register
In-Reply-To: <565C3A39.5020600@huawei.com>
References: <1446186123-11548-1-git-send-email-zhaoshenglong@huawei.com>
 <1446186123-11548-7-git-send-email-zhaoshenglong@huawei.com>
 <20151130114230.136abc6f@arm.com> <565C3A39.5020600@huawei.com>
Message-ID: <20151130131922.0e8789b7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Nov 2015 19:59:53 +0800
Shannon Zhao <zhaoshenglong@huawei.com> wrote:

> Hi Marc,
> 
> On 2015/11/30 19:42, Marc Zyngier wrote:
> >> +static void reset_pmceid(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> >> > +{
> >> > +	u64 pmceid;
> >> > +
> >> > +	if (r->reg == PMCEID0_EL0 || r->reg == c9_PMCEID0)
> > That feels wrong. We should only reset the 64bit view of the sysregs,
> > as the 32bit view is directly mapped to it.
> > 
> Just to confirm, if guest access c9_PMCEID0, KVM will trap this register
> with the register index as PMCEID0_EL0? Or still as c9_PMCEID0?

The traps are per execution mode (you'll get c9_PMCEID0 with a 32bit
guest). But the reset function is only concerned with the 64bit view.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
