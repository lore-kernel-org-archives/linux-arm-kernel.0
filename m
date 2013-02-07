From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Feb 2013 13:56:08 -0500 (EST)
Subject: [PATCH v4 08/15] ARM: vexpress: introduce DCSCB support
In-Reply-To: <20130207181404.GC14528@arm.com>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-9-git-send-email-nicolas.pitre@linaro.org>
 <20130207181404.GC14528@arm.com>
Message-ID: <alpine.LFD.2.02.1302071355010.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Feb 2013, Catalin Marinas wrote:

> Hi Nico,
> 
> On Tue, Feb 05, 2013 at 05:22:05AM +0000, Nicolas Pitre wrote:
> > +static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
> > +{
> > +	unsigned int rst_hold, cpumask = (1 << cpu);
> > +
> > +	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
> > +	if (cpu >= 4 || cluster >= 2)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
> > +	 * variant exists, we need to disable IRQs manually here.
> > +	 */
> > +	local_irq_disable();
> > +	arch_spin_lock(&dcscb_lock);
> > +
> > +	rst_hold = readl_relaxed(dcscb_base + RST_HOLD0 + cluster * 4);
> > +	if (rst_hold & (1 << 8)) {
> > +		/* remove cluster reset and add individual CPU's reset */
> > +		rst_hold &= ~(1 << 8);
> > +		rst_hold |= 0xf;
> > +	}
> > +	rst_hold &= ~(cpumask | (cpumask << 4));
> > +	writel(rst_hold, dcscb_base + RST_HOLD0 + cluster * 4);
> 
> Why do you mix relaxed and non-relaxed I/O accessors here? Do you need
> the barriers implied by writel()?

Most likely not.  I'll change that.

For the record, this patch is not part of the pull request I sent 
recently.


Nicolas
