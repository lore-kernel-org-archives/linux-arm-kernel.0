From: balbi@ti.com (Felipe Balbi)
Date: Tue, 27 Jan 2015 10:01:43 -0600
Subject: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
In-Reply-To: <20150126194933.GG6660@saruman.tx.rr.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
 <1422054704-14915-2-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com>
 <20150126165640.GA10679@saruman.tx.rr.com>
 <20150126194933.GG6660@saruman.tx.rr.com>
Message-ID: <20150127160143.GH14623@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 01:49:33PM -0600, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Jan 26, 2015 at 10:56:40AM -0600, Felipe Balbi wrote:
> > > the references below are from SPRUHL7
> > > 
> > > On Fri, 23 Jan 2015, Felipe Balbi wrote:
> > > 
> > > > Without hwmod data for DebugSS, performance monitors
> > > > have no chance of running on AM43xx devices.
> > > > 
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > ---
> > > >  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 40 ++++++++++++++++++++++++++++++
> > > >  arch/arm/mach-omap2/prcm43xx.h             |  1 +
> > > >  2 files changed, 41 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> > > > index 5c6c8410160e..6709704dd5b5 100644
> > > > --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> > > > +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> > > > @@ -19,6 +19,7 @@
> > > >  #include "omap_hwmod.h"
> > > >  #include "omap_hwmod_33xx_43xx_common_data.h"
> > > >  #include "prcm43xx.h"
> > > > +#include "prm44xx.h"
> > > >  #include "omap_hwmod_common_data.h"
> > > >  
> > > >  
> > > > @@ -60,6 +61,44 @@ static struct omap_hwmod am43xx_wkup_m3_hwmod = {
> > > >  	.rst_lines_cnt	= ARRAY_SIZE(am33xx_wkup_m3_resets),
> > > >  };
> > > >  
> > > > +/*
> > > > + * 'debugss' class
> > > > + * debug and emulation sub system
> > > > + */
> > > > +static struct omap_hwmod_opt_clk am43xx_debugss_opt_clks[] = {
> > > > +	{ .role = "dbg_sysclk", .clk = "dbg_sysclk_ck" },
> > > > +	{ .role = "dbg_clka", .clk = "dbg_clka_ck", },
> > > > +	{ .role = "dbg_clkb", .clk = "dbg_clkb_ck", },
> > > > +	{ .role = "dbg_clkc", .clk = "dbg_clkc_ck", },
> > > > +};
> > > > +
> > > > +static struct omap_hwmod_class am43xx_debugss_hwmod_class = {
> > > > +	.name	= "debugss",
> > > > +};
> > > > +
> > > > +/* debugss */
> > > > +static struct omap_hwmod am43xx_debugss_hwmod = {
> > > > +	.name		= "debugss",
> > > > +	.class		= &am43xx_debugss_hwmod_class,
> > > > +	.clkdm_name	= "l3_aon_clkdm",
> > > > +	.main_clk	= "trace_clk_div_ck",
> > > > +	.prcm = {
> > > > +		.omap4 = {
> > > > +			.clkctrl_offs = AM43XX_CM_WKUP_DBGSS_CLKCTRL_OFFSET,
> > > 
> > > According to Table 6-275 "PRCM_CM_WKUP_DBGSS_CLKCTRL Register Field 
> > > Descriptions" this should have a 
> > > 
> > > 			.modulemode   = MODULEMODE_SWCTRL,
> > 
> > hm... modulemode SWCTRL causes wait_target_ready to fail. Any hints ?
> 
> gets stuck in transition state. PRCM_CM_WKUP_DBGSS_CLKCTRL is always
> read as 0x 12510f00 which would translate into:
> 
> - module disabled
> - all opt clocks are on
> - module is transitioning
> - module in standby
> - clkA as TPIU and STM trace clock
> - all dividers set to 2

just fyi, checking with HW folks, this might be a new bug, unless
debugss needs something special.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/5ff81c46/attachment.sig>
