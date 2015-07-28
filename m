From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 28 Jul 2015 13:19:42 +0800
Subject: [PATCH v4 2/7] clk: mediatek: Fix rate and dependency of MT8173
 clocks
In-Reply-To: <18677675.jZ2GEqS3sy@diego>
References: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
 <20150727055232.GW18700@pengutronix.de>
 <CAGS+omDjr6d9=+d-uphrENu3Kenr8QUc3VgbaWTd45wqWzi7tg@mail.gmail.com>
 <18677675.jZ2GEqS3sy@diego>
Message-ID: <1438060782.17770.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2015-07-27 at 09:52 +0200, Heiko St?bner wrote:
> Am Montag, 27. Juli 2015, 14:19:41 schrieb Daniel Kurtz:
> > On Jul 27, 2015 12:52, "Sascha Hauer" <s.hauer@pengutronix.de> wrote:
> > > On Fri, Jul 24, 2015 at 07:10:14PM +0800, Daniel Kurtz wrote:

> > > > >  /* TOPCKGEN */
> > > > >  
> > > > >  #define CLK_TOP_CLKPH_MCK_O            1
> > > > > 
> > > > > -#define CLK_TOP_DPI                    2
> > > > > 
> > > > >  #define CLK_TOP_USB_SYSPLL_125M                3
> > > > 
> > > > I think we should renumber the rest of the CLK_TOP_*
> > > 
> > > They shouldn't be renumbered at all as this makes all binary device
> > > trees out there useless. That may not be a big issue with the MT8173
> > > at the moment as there are hardly any binary device trees with the
> > > mainline device trees shipped, but still we should get used to not
> > > break existing device trees without need.
> > 
> > As you mention, there are no devices shipped with mainline binary device
> > trees.  So, let's just correct the numbering now while we still can do it
> > painlessly.  It seems a bit unnecessary to preserve backwards compatibility
> > when we are still landing basic device support, like the clock tree.
> 
> in general I'm with Sascha on this regarding breaking the dt, and I guess
> the empty number does not hurt this much. Another argument against
> renumbering would be that the clock is there, it's just not used in the
> code anymore, but the clock is acutally still there.
> 
> 
> But on the other hand, the clock hasn't been part of an official kernel
> release yet (not in 4.1), and if we want to follow protocol to the letter,
> the removal of the clock id itself is already breakage, because the
> binding-header is considered part of the dt and removing a constant
> could already cause breakage in some universe far far away :-)
> 
> So you could try to convince the clock maintainers, that this might still
> be 4.2 material. Or do a smaller patch for 4.2 like the following, to at
> least follow the dt-protocol.
> 
> Please also take a look at the mt8135 clock tree, to maybe fix this
> already too, before it becomes part of a release.

There is no non-existed clock in current MT8135 clock implementation. So
we just need to remove dpi_ck from MT8173 clocks.

I'll send a new patchset to remove dpi_ck in a small separated patch.


Best regards,
James


> --------------- 8< -----------------
> From: Heiko Stuebner <heiko@sntech.de>
> Date: Mon, 27 Jul 2015 09:41:56 +0200
> Subject: [PATCH] clk: mediatek: mt8173: remove unused dpi_ck clock
> 
> The dpi_ck clock is not actually used and its source isn't 100% clear too.
> So remove it for the time being.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/mediatek/clk-mt8173.c      | 1 -
>  include/dt-bindings/clock/mt8173-clk.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> index 8b6523d..80871e2 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -26,7 +26,6 @@ static DEFINE_SPINLOCK(mt8173_clk_lock);
>  
>  static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
>  	FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
> -	FACTOR(CLK_TOP_DPI, "dpi_ck", "clk_null", 1, 1),
>  	FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
>  	FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
>  };
> diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
> index 4ad76ed..7230c38 100644
> --- a/include/dt-bindings/clock/mt8173-clk.h
> +++ b/include/dt-bindings/clock/mt8173-clk.h
> @@ -18,7 +18,6 @@
>  /* TOPCKGEN */
>  
>  #define CLK_TOP_CLKPH_MCK_O		1
> -#define CLK_TOP_DPI			2
>  #define CLK_TOP_USB_SYSPLL_125M		3
>  #define CLK_TOP_HDMITX_DIG_CTS		4
>  #define CLK_TOP_ARMCA7PLL_754M		5
