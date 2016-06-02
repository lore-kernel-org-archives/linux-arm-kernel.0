From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 03 Jun 2016 01:01:48 +0300
Subject: [PATCH/RFC v3 14/22] clk: renesas: r8a7795: Obtain mode pin
 values from R-Car RST driver
In-Reply-To: <1464808880-343-15-git-send-email-geert+renesas@glider.be>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <1464808880-343-15-git-send-email-geert+renesas@glider.be>
Message-ID: <4553060.NE6q0PIF0B@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Wednesday 01 Jun 2016 21:21:12 Geert Uytterhoeven wrote:
> Obtain the values of the mode pins from the R-Car RST driver, which
> relies on the presence in DT of a device node for the RST module.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3:
>   - New.
> ---
>  drivers/clk/renesas/r8a7795-cpg-mssr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c
> b/drivers/clk/renesas/r8a7795-cpg-mssr.c index
> e53aff5b23ad4967..e1f2359a59feee7e 100644
> --- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
> @@ -15,6 +15,7 @@
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/soc/renesas/rcar-rst.h>
> 
>  #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
> 
> @@ -294,7 +295,12 @@ static const struct rcar_gen3_cpg_pll_config
> cpg_pll_configs[16] __initconst = { static int __init
> r8a7795_cpg_mssr_init(struct device *dev)
>  {
>  	const struct rcar_gen3_cpg_pll_config *cpg_pll_config;
> -	u32 cpg_mode = rcar_gen3_read_mode_pins();
> +	u32 cpg_mode;
> +	int error;
> +
> +	error = rcar_rst_read_mode_pins(&cpg_mode);
> +	if (error)
> +		return error;
> 
>  	cpg_pll_config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
>  	if (!cpg_pll_config->extal_div) {

-- 
Regards,

Laurent Pinchart
