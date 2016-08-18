From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 18 Aug 2016 10:52:43 +0100
Subject: [PATCH] arm: l2x0: add PMU support
In-Reply-To: <20160818091058.GS1041@n2100.armlinux.org.uk>
References: <1471451191-18090-1-git-send-email-mark.rutland@arm.com>
 <20160818091058.GS1041@n2100.armlinux.org.uk>
Message-ID: <20160818095243.GA27045@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Aug 18, 2016 at 10:10:58AM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 17, 2016 at 05:26:31PM +0100, Mark Rutland wrote:
> > +static void l2x0_pmu_counter_config_write(int idx, u32 val)
> > +{
> > +	writel(val, l2x0_base + L2X0_EVENT_CNT0_CFG - 4 * idx);
> > +}
> > +
> > +static u32 l2x0_pmu_counter_read(int idx)
> > +{
> > +	return readl(l2x0_base + L2X0_EVENT_CNT0_VAL - 4 * idx);
> > +}
> > +
> > +static void l2x0_pmu_counter_write(int idx, u32 val)
> > +{
> > +	writel(val, l2x0_base + L2X0_EVENT_CNT0_VAL - 4 * idx);
> > +}
> > +
> > +static void __l2x0_pmu_enable(void)
> > +{
> > +	u32 val = readl(l2x0_base + L2X0_EVENT_CNT_CTRL);
> > +	val |= L2X0_EVENT_CNT_CTRL_ENABLE;
> > +	writel(val, l2x0_base + L2X0_EVENT_CNT_CTRL);
> > +}
> > +
> > +static void __l2x0_pmu_disable(void)
> > +{
> > +	u32 val = readl(l2x0_base + L2X0_EVENT_CNT_CTRL);
> > +	val &= ~L2X0_EVENT_CNT_CTRL_ENABLE;
> > +	writel(val, l2x0_base + L2X0_EVENT_CNT_CTRL);
> > +}
> 
> Are you sure you want to be using the barriered IOs here, which will
> come back in and run a sync on the L2C?

That is a very good point. I should not be using those here.

> Isn't that going to affect the performance measurements?

Yes. It will directly add to some counts, and will result in more lost
events than is necessary (as any L2C syncs performed while the PMU is
disabled delay enabling it again).

Thanks for pointing this out; I will fix this in v2.

Thanks,
Mark.
