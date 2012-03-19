From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 15:55:24 -0600
Subject: [PATCH 5/5] mmc: sdhci-s3c: setup pins using pinctrl interface
In-Reply-To: <1331469965-28846-6-git-send-email-thomas.abraham@linaro.org>
References: <1331469965-28846-1-git-send-email-thomas.abraham@linaro.org>
 <1331469965-28846-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F67AB4C.9040801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2012 06:46 AM, Thomas Abraham wrote:
> The platform specific callback to setup the sdhci pin mux and pin config
> is removed and the pinctrl subsystem interface is used to setup the
> mux and config.

> @@ -643,8 +649,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Ensure we have minimal gpio selected CMD/CLK/Detect */
> -	if (pdata->cfg_gpio)
> -		pdata->cfg_gpio(pdev, pdata->max_width);
> +	pstate = pdata->max_width ? "sdhci-pcfg8" : "sdhci-pcfg4";

If the driver is going to select a single state ("sdhci-pcfg8" or
"sdhci-pcfg4" above) at probe() time and never change it (which seems
quite reasonable for an SDHCI controller), then the driver should always
use state PINCTRL_STATE_DEFAULT, and it should be up to the board to set
up the mapping table such that PINCTRL_STATE_DEFAULT sets up the pins
for either 4-bit or 8-bit as appropriate for the board.
