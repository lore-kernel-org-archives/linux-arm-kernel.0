From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 5 Aug 2015 08:53:41 +0200
Subject: [PATCH v6 5/9] clk: mediatek: Fix rate and dependency of MT8173
 clocks
In-Reply-To: <1438676218-11310-6-git-send-email-jamesjj.liao@mediatek.com>
References: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
 <1438676218-11310-6-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150805065341.GA18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 04:16:54PM +0800, James Liao wrote:
> Remove the dependency from clk_null, and give all root clocks a
> typical rate, include clkph_mck_o, usb_syspll_125m and hdmitx_dig_cts.
> 
> dpi_ck was removed due to no clock reference to it.
> 
> Replace parent clock of infra_cpum with cpum_ck, which is an external
> clock and can be defined in the device tree.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt8173.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
> index 361fe32..f37ace6 100644
> --- a/drivers/clk/mediatek/clk-mt8173.c
> +++ b/drivers/clk/mediatek/clk-mt8173.c
> @@ -22,10 +22,9 @@
>  
>  static DEFINE_SPINLOCK(mt8173_clk_lock);
>  
> -static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
> -	FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
> -	FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
> -	FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
> +static const struct mtk_fixed_clk fixed_clks[] __initconst = {
> +	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", 400 * MHZ),
> +	FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),

Hm, it seems you hide PLLs in fixed factor clock. Are you sure that
there is a PLL in the system generating 125MHz from 26MHz which is in no
way configurable? Or is this really some clock derived from the syspll
as the clock name suggests?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
