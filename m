From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Feb 2012 11:05:31 -0800
Subject: [PATCH 1/8] ARM: OMAP2+: Move DISPC L3 firewall to happen in
 omap_display_init()
In-Reply-To: <1329898191.2070.6.camel@deskari>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234035.18709.40664.stgit@kaulin.local>
 <1329898191.2070.6.camel@deskari>
Message-ID: <20120222190531.GK18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120221 23:38]:
> Hi,
> 
> On Tue, 2012-02-21 at 15:40 -0800, Tony Lindgren wrote:
> > Otherwise we cannot move most of plat/io.h to be a local
> > iomap.h for mach-omap2.
> > 
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: linux-fbdev at vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/display.c   |    3 +++
> >  drivers/video/omap2/dss/dispc.c |    5 -----
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> > index 3677b1f..5a7f12f 100644
> > --- a/arch/arm/mach-omap2/display.c
> > +++ b/arch/arm/mach-omap2/display.c
> > @@ -191,6 +191,9 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
> >  	memset(&pdata, 0, sizeof(pdata));
> >  
> >  	if (cpu_is_omap24xx()) {
> > +		/* L3 firewall setting: enable access to OCM RAM */
> > +		__raw_writel(0x402000b0, OMAP2_L3_IO_ADDRESS(0x680050a0));
> > +
> >  		curr_dss_hwmod = omap2_dss_hwmod_data;
> >  		oh_count = ARRAY_SIZE(omap2_dss_hwmod_data);
> >  	} else if (cpu_is_omap34xx()) {
> > diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> > index e1626a1..cce0820 100644
> > --- a/drivers/video/omap2/dss/dispc.c
> > +++ b/drivers/video/omap2/dss/dispc.c
> > @@ -3272,11 +3272,6 @@ static void _omap_dispc_initial_config(void)
> >  	if (dss_has_feature(FEAT_FUNCGATED))
> >  		REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
> >  
> > -	/* L3 firewall setting: enable access to OCM RAM */
> > -	/* XXX this should be somewhere in plat-omap */
> > -	if (cpu_is_omap24xx())
> > -		__raw_writel(0x402000b0, OMAP2_L3_IO_ADDRESS(0x680050a0));
> > -
> >  	_dispc_setup_color_conv_coef();
> >  
> >  	dispc_set_loadmode(OMAP_DSS_LOAD_FRAME_ONLY);
> > 
> 
> I think the whole raw_writel line can be removed. It's been copied from
> the old omapfb, and my understanding is that it's about using SRAM for
> framebuffer. Using SRAM for fb is no longer supported, and I have a
> patch set that removes the remaining SRAM code from omapfb/omapdss.

OK, I'll remove those from drivers/video/omap2/dss/dispc.c so this
series keeps building.

Tony
