From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Aug 2012 16:11:08 +0200
Subject: [PATCH 1/2] ARM: imx: enable emi_slow_gate clock for imx5
In-Reply-To: <1343919712-6240-1-git-send-email-shawn.guo@linaro.org>
References: <1343919712-6240-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120803141108.GV1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 11:01:51PM +0800, Shawn Guo wrote:
> The imx5 common clock migration causes a regression with smsc911x
> driver on imx53-ard board, where a smsc lan9220 controller gets
> connected on imx53 with EIM interface.  EIM needs clock emi_slow_gate
> to be functional.  In the new imx5 clock driver, there is no use count
> incremented for the clock by enabling it, so the framework closes the
> clock at late init time and makes EIM stop working then.
> 
> Enable emi_slow_gate in clock driver initialization to fix the
> regression.

Can we add a comment that emi_slow_gate is needed for the EIM interface?
It's not obvious from the datasheet and this information might help
people who want to clean up the now unconditionally enabled clocks.

Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index f608669..6eee32a 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -303,6 +303,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk_prepare_enable(clk[aips_tz2]); /* fec */
>  	clk_prepare_enable(clk[spba]);
>  	clk_prepare_enable(clk[emi_fast_gate]); /* fec */
> +	clk_prepare_enable(clk[emi_slow_gate]);
>  	clk_prepare_enable(clk[tmax1]);
>  	clk_prepare_enable(clk[tmax2]); /* esdhc2, fec */
>  	clk_prepare_enable(clk[tmax3]); /* esdhc1, esdhc4 */
> -- 
> 1.7.5.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
