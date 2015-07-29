From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 29 Jul 2015 15:09:09 +0300
Subject: [PATCH 01/17] mmc: host: omap_hsmmc: use
 devm_regulator_get_optional() for vmmc
In-Reply-To: <1438168187-1614-2-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
 <1438168187-1614-2-git-send-email-kishon@ti.com>
Message-ID: <55B8C265.1050801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2015 02:09 PM, Kishon Vijay Abraham I wrote:
> Since vmmc can be optional for some platforms, use
> devm_regulator_get_optional() for vmmc. Now return error only
> in the case of -EPROBE_DEFER and for all other cases set
> host->vcc to NULL.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   drivers/mmc/host/omap_hsmmc.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4d12032..b673e59 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -344,11 +344,13 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>   	struct regulator *reg;
>   	int ocr_value = 0;
>   
> -	reg = devm_regulator_get(host->dev, "vmmc");
> +	reg = devm_regulator_get_optional(host->dev, "vmmc");
>   	if (IS_ERR(reg)) {
> -		dev_err(host->dev, "unable to get vmmc regulator %ld\n",
> +		if (PTR_ERR(reg) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		host->vcc = NULL;
> +		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
>   			PTR_ERR(reg));
> -		return PTR_ERR(reg);

I think, It could be unsafe to just drop this return.
regulator_get_optional may return:
1 valid pointer on regulator : success;
2 ERR_PTR(-ENODEV)           : regulator is not assigned, can proceed.
3 ERR_PTR(-EPROBE_DEFER)     : regulator is assigned, but not ready yet, retry.
4 ERR_PTR(<other error codes>: regulator is assigned, but can't be retrieved, failure, can't proceed

So, It's allowed to continue with host->vcc = NULL; only in case [2], while
in case [4] probe should fail.

>   	} else {
>   		host->vcc = reg;
>   		ocr_value = mmc_regulator_get_ocrmask(reg);
> 


-- 
regards,
-grygorii
