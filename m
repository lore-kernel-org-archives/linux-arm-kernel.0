From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 30 Aug 2012 19:42:13 +0300
Subject: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
In-Reply-To: <503F5517.4010100@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
 <1346230576-20004-3-git-send-email-rnayak@ti.com>
 <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
 <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com>
Message-ID: <1346344933.2327.43.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-08-30 at 13:57 +0200, Benoit Cousson wrote:
> On 08/30/2012 10:39 AM, Rajendra Nayak wrote:
> > On Thursday 30 August 2012 05:45 AM, Turquette, Mike wrote:
> >> On Wed, Aug 29, 2012 at 1:56 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
> >>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c
> >>> b/arch/arm/mach-omap2/clock44xx_data.c
> >>> index d7f55e4..a3831a2 100644
> >>> --- a/arch/arm/mach-omap2/clock44xx_data.c
> >>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> >>> @@ -3156,6 +3156,7 @@ static struct omap_clk omap44xx_clks[] = {
> >>>          CLK(NULL,       "dss_tv_clk",&dss_tv_clk,    CK_443X),
> >>>          CLK(NULL,       "dss_48mhz_clk",&dss_48mhz_clk, CK_443X),
> >>>          CLK(NULL,       "dss_dss_clk",&dss_dss_clk,   CK_443X),
> >>> +       CLK(NULL,       "dss_fck",&dss_fck,       CK_443X),
> >>>          CLK("omapdss_dss",      "ick",&dss_fck,       CK_443X),
> >>
> >> Is it right to re-use dss_fck for the "ick" here?  I think it is due
> >> to omap4 modulemode stuff but I don't have DM in front of me and
> >> wanted a double-check...
> > 
> > yes, its because of the wierdness of DSS clocks where a so-called
> > optional clock is actually a function clock.
> 
> Not only, it is a hack to allow the DSS to be enabled whenever a DSS
> submodule has to be enabled. Since they are sharing the ick, it will
> enable the modulemode when the DISPC will be enabled.
> 
> That hack should disappear as soon as the DSS will be able to handle the
> PM dependency between DSS submodules and the DSS itself using pm_runtime
> parent/child link.
> And then we will have to remove this fake ick modulemode clock node and
> let hwmod handle that properly.
> 
> Tomi already cleaned the DSS part, I guess it should be upstreamed soon,
> if this is not already the case.

This is in 3.5. omapdss_dss is now the parent for the rest of the dss
submodules, and runtime PM is being used.

I think we should now revisit this dss clock handling to see if there
are any other changes required in the omapdss side, but I hope they are
already according to our discussions and correct.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120830/1a379099/attachment.sig>
