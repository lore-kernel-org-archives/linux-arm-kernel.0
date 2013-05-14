From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 14 May 2013 08:38:20 +0200 (CEST)
Subject: [PATCH V2 05/10] mmc: sdhi-pxav3: handle mmc_of_parse() errors
 during probe
In-Reply-To: <1368479941-10084-6-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <1368479941-10084-6-git-send-email-gmbnomis@gmail.com>
Message-ID: <Pine.LNX.4.64.1305140837540.32151@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a typo in the subject line - it's sdhci, not sdhi :)

Thanks
Guennadi

On Mon, 13 May 2013, Simon Baatz wrote:

> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pxav3.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 1ae358e..67ea388 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -252,7 +252,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  
>  	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
>  	if (match) {
> -		mmc_of_parse(host->mmc);
> +		ret = mmc_of_parse(host->mmc);
> +		if (ret)
> +			goto err_of_parse;
>  		sdhci_get_of_property(pdev);
>  		pdata = pxav3_get_mmc_pdata(dev);
>  	} else if (pdata) {
> @@ -313,10 +315,11 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_of_parse:
> +err_cd_req:
>  err_add_host:
>  	clk_disable_unprepare(clk);
>  	clk_put(clk);
> -err_cd_req:
>  err_clk_get:
>  	sdhci_pltfm_free(pdev);
>  	kfree(pxa);
> -- 
> 1.7.9.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
