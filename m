From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 3 Oct 2011 11:21:55 -0600 (MDT)
Subject: [PATCH v2] OMAP2PLUS: DSS: Ensure DSS works correctly if display
	is enabled in bootloader
In-Reply-To: <1317630070.2026.27.camel@deskari>
References: <1315811306-11001-1-git-send-email-archit@ti.com>
	<alpine.DEB.2.00.1110022237171.4611@utopia.booyaka.com>
	<1317630070.2026.27.camel@deskari>
Message-ID: <alpine.DEB.2.00.1110031055590.4611@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomi,

On Mon, 3 Oct 2011, Tomi Valkeinen wrote:

> On Sun, 2011-10-02 at 22:45 -0600, Paul Walmsley wrote:
> > On Mon, 12 Sep 2011, Archit Taneja wrote:
> > 
> > > Resetting DISPC when a DISPC output is enabled causes the DSS to go into an
> > > inconsistent state. Thus if the bootloader has enabled a display, the hwmod code
> > > cannot reset the DISPC module just like that, but the outputs need to be
> > > disabled first.
> > > 
> > > Add function dispc_disable_outputs() which disables all active overlay manager
> > > and ensure all frame transfers are completed.
> > > 
> > > Modify omap_dss_reset() to call this function and clear DSS_CONTROL,
> > > DSS_SDI_CONTROL and DSS_PLL_CONTROL so that DSS is in a clean state when the
> > > DSS2 driver starts.
> > > 
> > > This resolves the hang issue(caused by a L3 error during boot) seen on the
> > > beagle board C3, which has a factory bootloader that enables display. The issue
> > > is resolved with this patch.
> 
> <snip>
> 
> > +struct omap_dss_dispc_dev_attr {
> > +	u8	manager_count;
> > +	bool	has_framedonetv_irq;
> > +};
> > +
> > +#endif
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> > index 09d9395..8e32cb3 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> > @@ -945,6 +945,7 @@ static struct omap_hwmod omap2420_dss_dispc_hwmod = {
> >  	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_dispc_slaves),
> >  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
> >  	.flags		= HWMOD_NO_IDLEST,
> > +	.dev_attr	= &omap2_3_dss_dispc_dev_attr
> >  };
> 
> I didn't know you can add arbitrary data like that to hwmods. What kind
> of data is it meant for? 

It's intended for data that's specific to the integration of that IP block 
on a given SoC.

In an ideal world, Linux could just read some registers from the IP block 
to determine these.  Many of our IP blocks have a REVISION register.  But 
many types of integration-specific data are not identified in that 
register. And often when IP blocks are revised, the hardware people seem 
to forget to update the REVISION register :-(.  So we need some way to 
supply this information in software.

In terms of concrete uses, one use would be to identify IP block 
features that may be enabled on certain instances of the IP.  For example, 
on OMAPs, some DMTIMER blocks have 1ms tick adjustment support; others do 
not.  As far as I know, there's no way for the driver to determine this 
from the IP block.

The dev_attr data is intended to be fairly high-level functional data.

> Can the data be used by the driver, or is it meant just for arch stuff?

It can be used by both.  But if it's intended for use by the driver, then 
the dev_attr data needs to be copied into struct platform_data by the 
arch-specific code.  This is because the drivers themselves should have no 
direct dependencies on hwmod data or code, in case the IP block is used on 
a non-OMAP SoC.

For example, if you look at arch/arm/mach-omap2/hsmmc.c around line 471, 
you can see the arch-specific code copying dev_attr data into 
platform_data.

> I'm wondering this as we have a complex mechanism in the dss driver to
> find out about the differences of DSS hardware
> (drivers/video/omap2/dss/dss_features.[ch]). The dss_features system is
> currently part of the driver, but should be moved under arch/arm/*omap*
> at some point, and this hwmod dev_attr sounds like it could possibly be
> a right place to handle these.
> 
> I looked at how the dev_attrs are used, and all of them seemed to be
> very small, a few fields at max. The DSS features set is, on the other
> hand, quite big amount of data, and meant for the driver.

Just from a brief look, it looks like much of that data would be good 
candidates to pass via the dev_attr mechanism.  The reg_fields would be one 
exception: it would be better (in terms of dev_attr) to simply pass data 
like ".reg_field_layout = 1" or ".reg_field_layout = 2", and then select 
between those tables in the driver code.

Beno?t is right, though, that you might want to take the upcoming DT 
migration into account in your plans.


- Paul
