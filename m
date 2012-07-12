From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 10:06:48 +0800
Subject: [PATCH v6 3/7] ARM: imx6q: disable usb charger detector
In-Reply-To: <1342006425-21008-4-git-send-email-richard.zhao@freescale.com>
References: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
 <1342006425-21008-4-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120712020646.GG6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 07:33:41PM +0800, Richard Zhao wrote:
> The external charger detector needs to be disabled,
> or the signal at DP will be poor
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c |   41 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 1c18d3c..63fe5d6 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -25,6 +25,7 @@
>  #include <linux/pinctrl/machine.h>
>  #include <linux/phy.h>
>  #include <linux/micrel_phy.h>
> +#include <linux/mfd/anatop.h>
>  #include <asm/cpuidle.h>
>  #include <asm/smp_twd.h>
>  #include <asm/hardware/cache-l2x0.h>
> @@ -117,6 +118,45 @@ static void __init imx6q_sabrelite_init(void)
>  	imx6q_sabrelite_cko1_setup();
>  }
>  
> +static void __init imx6q_usb_init(void)
> +{
> +	struct device_node *np;
> +	struct platform_device *pdev = NULL;
> +	struct anatop *adata = NULL;
> +
> +	np = of_find_node_by_path("/soc/aips-bus at 02000000/anatop at 020c8000");

I would suggest use of_find_compatible_node to save the open-coding of
such path.

Regards,
Shawn

> +	if (np)
> +		pdev = of_find_device_by_node(np);
> +	if (pdev)
> +		adata = platform_get_drvdata(pdev);
> +	if (!adata) {
> +		if (np)
> +			of_node_put(np);
> +		return;
> +	}
> +
> +#define HW_ANADIG_USB1_CHRG_DETECT		0x000001b0
> +#define HW_ANADIG_USB2_CHRG_DETECT		0x00000210
> +
> +#define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x00100000
> +#define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x00080000
> +
> +	/*
> +	 * The external charger detector needs to be disabled,
> +	 * or the signal at DP will be poor
> +	 */
> +	anatop_write_reg(adata, HW_ANADIG_USB1_CHRG_DETECT,
> +			BM_ANADIG_USB_CHRG_DETECT_EN_B
> +			| BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
> +			~0);
> +	anatop_write_reg(adata, HW_ANADIG_USB2_CHRG_DETECT,
> +			BM_ANADIG_USB_CHRG_DETECT_EN_B |
> +			BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
> +			~0);
> +
> +	of_node_put(np);
> +}
> +
>  static void __init imx6q_init_machine(void)
>  {
>  	/*
> @@ -131,6 +171,7 @@ static void __init imx6q_init_machine(void)
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  
>  	imx6q_pm_init();
> +	imx6q_usb_init();
>  }
>  
>  static struct cpuidle_driver imx6q_cpuidle_driver = {
> -- 
> 1.7.9.5
> 
> 
