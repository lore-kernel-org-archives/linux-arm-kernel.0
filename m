From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Mar 2012 11:09:29 -0700
Subject: [PATCH v2 7/7] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
 related functions as __init
In-Reply-To: <1332152442.2144.27.camel@deskari>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
 <1329997247-27342-8-git-send-email-rnayak@ti.com>
 <1332148116.2144.1.camel@deskari>
 <1332152442.2144.27.camel@deskari>
Message-ID: <20120319180928.GA9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120319 03:23]:
> On Mon, 2012-03-19 at 11:08 +0200, Tomi Valkeinen wrote:
> > Hi,
> > 
> > On Thu, 2012-02-23 at 17:10 +0530, Rajendra Nayak wrote:
> > > From: Tony Lindgren <tony@atomide.com>
> > > 
> > > Now that omap hsmmc init is split into two functions, it's safe
> > > to mark omap_hsmmc_init and omap_mux related functions to __init.
> > > 
> > > This basically reverts the following fixes for the case where
> > > TWL was compiled as a module:
> > > 
> > > a98f77b (ARM: omap: fix section mismatch warning for sdp3430_twl_gpio_setup())
> > > 8930b4e (ARM: omap: fix section mismatch warnings in mux.c caused by hsmmc.c)
> > > 
> > > Additionally it fixes up the remaining section warnings for
> > > all callers of omap_mux functions.
> > 
> > I only now noticed this patch. This breaks DSI, as the DSI muxing
> > functions are used during runtime and cannot be marked as __init.
> > 
> > Shall I make a new patch for dss tree that fixes this?
> 
> (too little coffee)
> 
> Obviously I can't make a fix in my tree for that, as the problematic
> patch is not present there... So here's a patch to fix it, based on
> arm-soc/for-next

Thanks yeah those are not even using omap_mux_init* functions, so I
must have accidentally converted blindly those while fixing up the
omap_mux_init* calling functions, sorry.

Looks like only omap4_hdmi_mux_pads needs to be __init as it's
calling omap_mux_init_signal.

It gets called from omap_hdmi_init, and omap_hdmi_init and it's callers
are already marked __init. The reason it's not producing a section
warning is probably because it gets inlined.

I've updated your patch a bit for the comments a bit and marked
omap4_hdmi_mux_pads as __init, will apply to fixes. Updated patch
below.

Regards,

Tony


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 19 Mar 2012 11:08:54 +0200
Subject: [PATCH] ARM: OMAP2+: Remove __init from DSI mux functions

Commit d1589f0912533e6cb2ac8fd6f1feb3d5989fe8cb (ARM: OMAP2+: Mark
omap_hsmmc_init and omap_mux related functions as __init) changed DSI
muxing functions to __init. This doesn't work, as the muxing functions
are used every time a DSI display is enabled or disabled.

This patch removes the __inits from DSI mux functions that were
accidentally marked as __init, and makes omap4_hdmi_mux_pads __init
like it should be.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
[tony at atomide.com: update comments, mark omap4_hdmi_mux_pads __init]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -99,7 +99,7 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
-static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
+static void __init omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
 {
 	u32 reg;
 	u16 control_i2c_1;
@@ -125,7 +125,7 @@ static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
 	}
 }
 
-static int __init omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
+static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 {
 	u32 enable_mask, enable_shift;
 	u32 pipd_mask, pipd_shift;
@@ -166,7 +166,7 @@ int __init omap_hdmi_init(enum omap_hdmi_flags flags)
 	return 0;
 }
 
-static int __init omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
+static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
 	if (cpu_is_omap44xx())
 		return omap4_dsi_mux_pads(dsi_id, lane_mask);
@@ -174,7 +174,7 @@ static int __init omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 	return 0;
 }
 
-static void __init omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
+static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 {
 	if (cpu_is_omap44xx())
 		omap4_dsi_mux_pads(dsi_id, 0);
