From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Mar 2015 12:29:44 +0000
Subject: [PATCH 5/9] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <89767639.F6rHWX5yIj@wuerfel>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YW7t5-0003mI-Sk@rmk-PC.arm.linux.org.uk>
 <89767639.F6rHWX5yIj@wuerfel>
Message-ID: <20150313122944.GF8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 01:07:06PM +0100, Arnd Bergmann wrote:
> On Thursday 12 March 2015 18:31:15 Russell King wrote:
> > +int __init dove_init_pmu(void)
> > +{
> > +       struct device_node *np_pmu, *np;
> > +       struct pmu_data *pmu;
> > +       int ret, parent_irq;
> > +
> > +       /* Lookup the PMU node */
> > +       np_pmu = of_find_compatible_node(NULL, NULL, "marvell,dove-pmu");
> > +       if (!np_pmu)
> > +               return 0;
> 
> What is the reason that this is not a platform_driver? I think you
> should try to make it one, or explain in the changelog the reason
> for not making it one. This obviously ties in with the question I
> asked about who calls dove_init_pmu().

It's because I need for the PM domain support to be available early
right now, and much of this code pre-dates the integration of OF with
PM domains.  Even booting with DT, I still need some platform devices
manually declared and bound to these PM domains in order to (a) properly
test this code, (b) test other parts of the system effectively, and
(c) have a working system.

However, I do agree that in the longer term this should probably be
converted to a platform device driver, assuming that everything that
makes use of it copes with it.

However, one thing that is a concern with that is the PM domain code
does not yet support the removal of PM domains.  I guess we should
ensure that PM domain providers set driver.suppress_bind_attrs so
that at least userspace can't unbind these drivers.

> > +               ret = of_parse_phandle_with_args(np, "resets", "#reset-cells",
> > +                                                0, &args);
> > +               if (ret == 0) {
> > +                       if (args.np == pmu->of_node)
> > +                               domain->rst_mask = BIT(args.args[0]);
> > +                       of_node_put(args.np);
> > +               }
> 
> In particular, manually parsing the "resets" property is something
> we should try to avoid. With a platform driver, this could become
> devm_reset_control_get(), otherwise I think of_reset_control_get()
> would also do the right thing here.

The hardware requires a specific sequence of register writes for the
PM domain code, which includes the reset register.

The problem is that if we were to use the reset API directly from the
PM domain code, we would have to separate the locks for the reset code
from the PM domain code.  That then leads to there being a race between
the reset code potentially being able to write to the reset register in
the middle of a PM domain sequence.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
