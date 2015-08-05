From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 5 Aug 2015 08:46:05 +0200
Subject: [PATCH v6 7/9] clk: mediatek: Add subsystem clocks of MT8173
In-Reply-To: <1438676218-11310-8-git-send-email-jamesjj.liao@mediatek.com>
References: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
 <1438676218-11310-8-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150805064605.GZ18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 04:16:56PM +0800, James Liao wrote:
> Most multimedia subsystem clocks will be accessed by multiple
> drivers, so it's a better way to manage these clocks in CCF.
> This patch adds clock support for MM, IMG, VDEC, VENC and VENC_LT
> subsystems.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt8173.c      | 267 +++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/mt8173-clk.h |  97 +++++++++++-
>  2 files changed, 361 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> index f37ace6..05335e5 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -25,6 +25,10 @@ static DEFINE_SPINLOCK(mt8173_clk_lock);
>  static const struct mtk_fixed_clk fixed_clks[] __initconst = {
>  	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", 400 * MHZ),
>  	FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
> +	FIXED_CLK(CLK_TOP_DSI0_DIG, "dsi0_dig", "clk26m", 130 * MHZ),
> +	FIXED_CLK(CLK_TOP_DSI1_DIG, "dsi1_dig", "clk26m", 130 * MHZ),
> +	FIXED_CLK(CLK_TOP_LVDS_PXL, "lvds_pxl", "lvdspll", 148.5 * MHZ),
> +	FIXED_CLK(CLK_TOP_LVDS_CTS, "lvds_cts", "lvdspll", 51.975 * MHZ),

I would expect 51975 * KHZ here to avoid fractional numbers. Probably
gcc calculates that during compile time so this will work as expected,
still I'm not sure this is good style to use fractional numbers here.

Anyway, on my system lvdspll is running at 150MHz. Are you sure there is
a clock derived from this running at 148.5MHz? Is it really correct to
use a fixed clock here or should it rather be lvdspll directly?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
