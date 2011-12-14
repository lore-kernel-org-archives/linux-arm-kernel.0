From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 14 Dec 2011 22:11:52 +0100
Subject: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux subsystem
In-Reply-To: <1323878622-26602-5-git-send-email-b29396@freescale.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-5-git-send-email-b29396@freescale.com>
Message-ID: <20111214211152.GM27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 12:03:42AM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 4b976f0..4504136 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -24,6 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
> +#include <linux/pinctrl/pinmux.h>
>  #include <mach/esdhc.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
> @@ -68,6 +69,7 @@ struct pltfm_imx_data {
>  	int flags;
>  	u32 scratchpad;
>  	enum imx_esdhc_type devtype;
> +	struct pinmux *pmx;
>  	struct esdhc_platform_data boarddata;
>  };
>  
> @@ -439,6 +441,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	int err;
>  	struct pltfm_imx_data *imx_data;
> +	struct pinmux *pmx;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_imx_pdata);
>  	if (IS_ERR(host))
> @@ -466,6 +469,16 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	clk_enable(clk);
>  	pltfm_host->clk = clk;
>  
> +	pmx = pinmux_get(&pdev->dev, NULL);
> +	if (IS_ERR(pmx)) {
> +		err = PTR_ERR(pmx);
> +		goto err_pmx_get;
> +	}
> +	err = pinmux_enable(pmx);
> +	if (err)
> +		goto err_pmx_enable;
> +	imx_data->pmx = pmx;
> +

Won't this break every i.MX except i.MX6?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
