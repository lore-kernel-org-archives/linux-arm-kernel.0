From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 14 May 2012 10:22:01 +0200
Subject: [PATCH 3/5] ARM: imx: add audio codec clk lookup for imx53-qsb
In-Reply-To: <1336718568-26810-4-git-send-email-shawn.guo@linaro.org>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120514082201.GF21318@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 02:42:46PM +0800, Shawn Guo wrote:
> On imx53-qsb board, the clk ssi_ext.0 is used as the clock input
> to audio codec sgtl5000.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/imx53-dt.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
> index 574eca4..139ec4e 100644
> --- a/arch/arm/mach-imx/imx53-dt.c
> +++ b/arch/arm/mach-imx/imx53-dt.c
> @@ -10,6 +10,9 @@
>   * http://www.gnu.org/copyleft/gpl.html
>   */
>  
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> @@ -81,6 +84,19 @@ static const struct of_device_id imx53_iomuxc_of_match[] __initconst = {
>  	{ /* sentinel */ }
>  };
>  
> +static void __init imx53_qsb_init(void)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_get_sys("ssi_ext.0", NULL);
> +	if (IS_ERR(clk)) {
> +		pr_err("failed to get clk ssi_ext.0\n");
> +		return;
> +	}
> +
> +	clk_register_clkdev(clk, NULL, "0-000a");
> +}
> +
>  static void __init imx53_dt_init(void)
>  {
>  	struct device_node *node;
> @@ -99,6 +115,9 @@ static void __init imx53_dt_init(void)
>  		of_node_put(node);
>  	}
>  
> +	if (of_machine_is_compatible("fsl,imx53-qsb"))
> +		imx53_qsb_init();
> +

I wonder if we really want to open this can of worms here. Adding board
specific hacks (or fixups) in this file can become very messy once we
have more than only a few oftree based boards.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
