From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 Feb 2015 16:26:26 +0000
Subject: [PATCH 4/8] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <20150214170939.GG3213@lunn.ch>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
 <E1YMedG-00054d-0d@rmk-PC.arm.linux.org.uk>
 <20150214170939.GG3213@lunn.ch>
Message-ID: <20150215162626.GJ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 14, 2015 at 06:09:39PM +0100, Andrew Lunn wrote:
> Hi Russell
> 
> > +static struct reset_control_ops pmu_reset_ops = {
> > +	.reset = pmu_reset_reset,
> > +	.assert = pmu_reset_assert,
> > +	.deassert = pmu_reset_deassert,
> > +};
> > +
> > +static struct reset_controller_dev pmu_reset __initdata = {
> > +	.ops = &pmu_reset_ops,
> > +	.owner = THIS_MODULE,
> 
> Dumb question: Is this still needed? There have been a lot of patches
> from Wolfram Sang removing similar THIS_MODULE statements.

If this is not set, then .owner remains NULL; reset_controller_register()
is not wrapped to hide the initialisation of this member.  (IMHO, that's
exactly why hiding it is bad - it has created inconsistencies because
some APIs need an explicit initialisation, others don't.)

> > + * pmu {
> > + *	compatible = "marvell,pmu";
> 
> Is this maybe too generic? I'm sure Marvell has more than one pmu.
> Maybe "marvell,dove-pmu"

Changed.

> > +int __init dove_init_pmu(void)
> > +{
> > +	struct device_node *np_pmu, *np;
> > +	struct pmu_data *pmu;
> > +	int ret, parent_irq;
> > +
> > +	/* Lookup the PMU node */
> > +	np_pmu = of_find_compatible_node(NULL, NULL, "marvell,pmu");
> > +	if (!np_pmu)
> > +		return 0;
> > +
> > +	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
> > +	if (!pmu)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&pmu->lock);
> > +	pmu->of_node = np_pmu;
> > +	pmu->pmc_base = of_iomap(pmu->of_node, 0);
> > +	pmu->pmu_base = of_iomap(pmu->of_node, 1);
> > +	if (!pmu->pmc_base || !pmu->pmu_base) {
> > +		pr_err("%s: failed to map PMU\n", np_pmu->name);
> > +		iounmap(pmu->pmu_base);
> > +		iounmap(pmu->pmc_base);
> > +		kfree(pmu);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	parent_irq = irq_of_parse_and_map(pmu->of_node, 0);
> > +	if (!parent_irq)
> > +		pr_err("%s: no interrupt specified\n", np_pmu->name);
> > +
> 
> Is it not fatal to be missing the interrupt? Seems like return -EINVAL
> would be a good idea?

I don't think so.  The lack of parent interrupt shouldn't stop the
rest of the PMU code initialising - least of all only because the
only user of this right now is the RTC.

It may make sense to avoid initialising the PMU's IRQ support in
that case though.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
