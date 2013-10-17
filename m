From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Oct 2013 15:13:09 +0100
Subject: [RESEND PATCH v2 6/6] mmc: sdhci-bcm-kona: Add basic use of clocks
In-Reply-To: <1381960030-1640-7-git-send-email-tim.kryger@linaro.org>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
 <1381960030-1640-7-git-send-email-tim.kryger@linaro.org>
Message-ID: <20131017141309.GG24056@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 10:47:10PM +0100, Tim Kryger wrote:
> Enable the external clock needed by the host controller during the
> probe and disable it during the remove.

This requires a biding document update.

I note that the binding is already incomplete (it does not describe the
interrupts or reg).

> 
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  drivers/mmc/host/sdhci-bcm-kona.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 85472d3..91db099 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -54,6 +54,7 @@
>  
>  struct sdhci_bcm_kona_dev {
>  	struct mutex	write_lock; /* protect back to back writes */
> +	struct clk	*external_clk;

Is this the only clock input the unit has?

Are there any other external resources the device needs (e.g. gpios,
regulators)?

>  };
>  
>  
> @@ -252,11 +253,29 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>  	mmc_of_parse(host->mmc);
>  
>  	if (!host->mmc->f_max) {
> -		dev_err(&pdev->dev, "Missing max-freq for SDHCI cfg\n");
> +		dev_err(dev, "Missing max-freq for SDHCI cfg\n");

This seems like an unrelated change.

>  		ret = -ENXIO;
>  		goto err_pltfm_free;
>  	}
>  
> +	/* Get and enable the external clock */
> +	kona_dev->external_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(kona_dev->external_clk)) {
> +		dev_err(dev, "Failed to get external clock\n");
> +		ret = PTR_ERR(kona_dev->external_clk);
> +		goto err_pltfm_free;

This seems like a pretty clear breakage of existing DTBs.

Why?

Thanks,
Mark.
