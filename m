From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jan 2013 09:00:00 +0000
Subject: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
 the driver
In-Reply-To: <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130122090000.GH6857@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Lee Jones <lee.jones@linaro.org>
> 
> There are currently two instances of the ios_handler being used.
> Both of which mearly toy with some regulator settings. Now there
> is a GPIO regulator API, we can use that instead, and lessen the
> per platform burden. By doing this, we also become more Device
> Tree compatible.

Russell,

Why is this patch in your tree with Ulf as the Author?

> Cc: Chris Ball <cjb@laptop.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/host/mmci.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 9da5f24..e56655a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1097,6 +1097,11 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	case MMC_POWER_OFF:
>  		if (!IS_ERR(mmc->supply.vmmc))
>  			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +
> +		if (!IS_ERR(mmc->supply.vqmmc) &&
> +		    regulator_is_enabled(mmc->supply.vqmmc))
> +			regulator_disable(mmc->supply.vqmmc);
> +
>  		break;
>  	case MMC_POWER_UP:
>  		if (!IS_ERR(mmc->supply.vmmc))
> @@ -1111,6 +1116,10 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  		break;
>  	case MMC_POWER_ON:
> +		if (!IS_ERR(mmc->supply.vqmmc) &&
> +		    !regulator_is_enabled(mmc->supply.vqmmc))
> +			regulator_enable(mmc->supply.vqmmc);
> +
>  		pwr |= MCI_PWR_ON;
>  		break;
>  	}

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
