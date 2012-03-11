From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 11 Mar 2012 14:25:23 -0700
Subject: [PATCH 5/5] mmc: sdhci-s3c: setup pins using pinctrl interface
In-Reply-To: <1331469965-28846-6-git-send-email-thomas.abraham@linaro.org>
References: <1331469965-28846-1-git-send-email-thomas.abraham@linaro.org>
 <1331469965-28846-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F5D1843.1010608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> The platform specific callback to setup the sdhci pin mux and pin config
> is removed and the pinctrl subsystem interface is used to setup the
> mux and config.
> 
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
>   drivers/mmc/host/sdhci-s3c.c |   15 +++++++++++++--
>   1 files changed, 13 insertions(+), 2 deletions(-)
> 
[...]

> 
> +#include<plat/map-s5p.h>
> +#include<plat/map-base.h>

You can add <mach/map.h> instead of above.

> +
>   static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>   {
>   	struct s3c_sdhci_platdata *pdata;
> @@ -538,6 +543,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>   	struct sdhci_s3c *sc;
>   	struct resource *res;
>   	int ret, irq, ptr, clks;
> +	char *pstate;
> 
>   	if (!pdev->dev.platform_data&&  !pdev->dev.of_node) {
>   		dev_err(dev, "no device data specified\n");
> @@ -643,8 +649,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>   	}
> 
>   	/* Ensure we have minimal gpio selected CMD/CLK/Detect */
> -	if (pdata->cfg_gpio)
> -		pdata->cfg_gpio(pdev, pdata->max_width);

I'm not sure we can remove above now for all of Samsung stuff?

> +	pstate = pdata->max_width ? "sdhci-pcfg8" : "sdhci-pcfg4";

Is this right? Current max_width can be 4 or 8 in each board file now.

> +	sc->pinctrl = pinctrl_get_select(&pdev->dev, pstate);
> +	if (IS_ERR(sc->pinctrl)) {
> +		dev_err(dev, "failed to setup pin configuration\n");
> +		ret = -ENXIO;
> +		goto err_req_regs;
> +	}
> 
>   	host->hw_name = "samsung-hsmmc";
>   	host->ops =&sdhci_s3c_ops;

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
