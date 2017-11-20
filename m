From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 20 Nov 2017 12:15:13 +0530
Subject: [PATCH 4/6 v3] mmc: sdhci-spear: Handle return value of
 platform_get_irq
In-Reply-To: <23382b551ade00543aadc588aa74b0648958b907.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
 <23382b551ade00543aadc588aa74b0648958b907.1511066652.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171120064513.GE6125@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-11-17, 10:22, Arvind Yadav wrote:
> platform_get_irq() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
> changes in v3 :
>               return -EINVAL instead of host->irq.
> 
>  drivers/mmc/host/sdhci-spear.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index 8c0f884..e04485e 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -82,6 +82,10 @@ static int sdhci_probe(struct platform_device *pdev)
>  	host->hw_name = "sdhci";
>  	host->ops = &sdhci_pltfm_ops;
>  	host->irq = platform_get_irq(pdev, 0);
> +	if (host->irq <= 0) {
> +		ret = -EINVAL;
> +		goto err_host;
> +	}
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
>  
>  	sdhci = sdhci_priv(host);

Hope this is the last one to Ack :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
