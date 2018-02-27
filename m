From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 27 Feb 2018 09:10:34 +0800
Subject: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
In-Reply-To: <20180226134741.neqkpge33zo3pfzt@earth.universe>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
Message-ID: <20180227011033.GV3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 02:47:41PM +0100, Sebastian Reichel wrote:
> Hi Shawn,
> 
> On Sat, Feb 24, 2018 at 03:45:44PM +0800, Shawn Guo wrote:
> > On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
> > > On i.MX53 it is necessary to set the DBG_EN bit in the
> > > platform GPC register to enable access to PMU counters
> > > other than the cycle counter.
> > > 
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > ---
> > >  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> > > index 07c2e8dca494..658e28604dca 100644
> > > --- a/arch/arm/mach-imx/mach-imx53.c
> > > +++ b/arch/arm/mach-imx/mach-imx53.c
> > > @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
> > >  	mxc_set_cpu_type(MXC_CPU_MX53);
> > >  }
> > >  
> > > +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
> > 
> > The base address should be retrieved from device tree.
> 
> DT has no entry for 0x63fa0000-0x63fa3fff. iMX53 TRM lists it as "ARM Platform"
> with 8 platform specific 32 bit registers. Do you think it's worth the trouble
> adding a new binding? Do you have a suggestion for a compatible value?

Looking at it more closely, I feel that patching every single platform
which needs to set up additional register for secure-reg-access support
doesn't really scale.  Can we have pmu driver do it with a phandle in
DT pointing to the register and bit that need to be configured?

Shawn

> > > +#define GPC_DBG_EN BIT(16)
> > > +
> > > +/*
> > > + * This enables the DBGEN bit in ARM_GPC register, which is
> > > + * required for accessing some performance counter features.
> > > + * Technically it is only required while perf is used, but to
> > > + * keep the source code simple we just enable it all the time
> > > + * when the kernel configuration allows using the feature.
> > > + */
> > > +static void imx53_pmu_init(void)
> > > +{
> > > +	void __iomem *gpc_reg;
> > > +	struct device_node *node;
> > > +	u32 gpc;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_ARM_PMU))
> > > +		return;
> > > +
> > > +	node = of_find_compatible_node(NULL, NULL, "arm,cortex-a8-pmu");
> > > +	if (!node)
> > > +		return;
> > > +
> > > +	if (!of_property_read_bool(node, "secure-reg-access"))
> > > +		return;
> > > +
> > > +	gpc_reg = ioremap(MXC_CORTEXA8_PLAT_GPC, 4);
> > > +	if (!gpc_reg) {
> > > +		pr_warning("unable to map GPC to enable perf\n");
> > > +		return;
> > > +	}
> > > +
> > > +	gpc = readl_relaxed(gpc_reg);
> > > +	gpc |= GPC_DBG_EN;
> > > +	writel_relaxed(gpc, gpc_reg);
> > > +}
> > > +
> > >  static void __init imx53_dt_init(void)
> > >  {
> > >  	imx_src_init();
> > > -
> > > +	imx53_pmu_init();
> > >  	imx_aips_allow_unprivileged_access("fsl,imx53-aipstz");
> > >  }
> > >  
> > > -- 
> > > 2.15.1
> > > 
