From: prakity@nvidia.com (Philip Rakity)
Date: Tue, 23 Oct 2012 15:21:58 +0200
Subject: [PATCH 2/2] mmc: sdhci: Defer probe if regulator_get fails
In-Reply-To: <1350976740-19284-3-git-send-email-pkunapuli@nvidia.com>
References: <1350976740-19284-1-git-send-email-pkunapuli@nvidia.com>
 <1350976740-19284-3-git-send-email-pkunapuli@nvidia.com>
Message-ID: <4F1DF342-A2C4-434A-B878-A11374089E6E@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 23 Oct 2012, at 09:19, Pavan Kunapuli <pkunapuli@nvidia.com> wrote:

> vmmc and vqmmc regulators control the voltage to
> the host and device. Defer the probe if either of
> them is not registered.
> 
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> ---
> drivers/mmc/host/sdhci.c |   25 ++++++++++++++++++++++---
> 1 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7922adb..925c403 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2844,11 +2844,17 @@ int sdhci_add_host(struct sdhci_host *host)
> 	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
> 		mmc->caps |= MMC_CAP_NEEDS_POLL;
> 
> -	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
> +	/*
> +	 * If vqmmc regulator and no 1.8V signalling, then there's no UHS.
> +	 * vqmmc regulator should be present. If it's not present,
> +	 * assume the regulator driver registration is not yet done and
> +	 * defer the probe.
> +	 */
> 	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
> 	if (IS_ERR(host->vqmmc)) {
> -		pr_info("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
> +		pr_err("%s: no vqmmc regulator found\n", mmc_hostname(mmc));
> 		host->vqmmc = NULL;
> +		return -EPROBE_DEFER;

Some systems exist where vmmc regulator exists and vqmmc regulator does not.  The vmmc regular is fixed at 3.3v.  
Deferring the probe will cause issues.

> 	}
> 	else if (regulator_is_supported_voltage(host->vqmmc, 1800000, 1800000))
> 		regulator_enable(host->vqmmc);
> @@ -2903,10 +2909,17 @@ int sdhci_add_host(struct sdhci_host *host)
> 
> 	ocr_avail = 0;
> 
> +	/*
> +	 * vmmc regulator should be present. If it's not present,
> +	 * assume the regulator driver registration is not yet done
> +	 * and defer the probe.
> +	 */
> 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
> 	if (IS_ERR(host->vmmc)) {
> -		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
> +		pr_err("%s: no vmmc regulator found\n", mmc_hostname(mmc));
> 		host->vmmc = NULL;
> +		ret = -EPROBE_DEFER;
> +		goto vmmc_err;
> 	} else
> 		regulator_enable(host->vmmc);
> 
> @@ -3121,7 +3134,13 @@ reset:
> untasklet:
> 	tasklet_kill(&host->card_tasklet);
> 	tasklet_kill(&host->finish_tasklet);
> +vmmc_err:
> +	if (host->vqmmc) {
> +		if (regulator_is_enabled(host->vqmmc))
> +			regulator_disable(host->vqmmc);
> 
> +		regulator_put(host->vqmmc);
> +	}
> 	return ret;
> }
> 
> -- 
> 1.7.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
