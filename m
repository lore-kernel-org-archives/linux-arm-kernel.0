From: horms@verge.net.au (Simon Horman)
Date: Tue, 29 May 2018 17:13:32 +0100
Subject: [PATCH v2 2/5] crypto: ccree: better clock handling
In-Reply-To: <1527171551-21979-3-git-send-email-gilad@benyossef.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-3-git-send-email-gilad@benyossef.com>
Message-ID: <20180529161332.vqdtcbj54mel2tdk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 03:19:07PM +0100, Gilad Ben-Yossef wrote:
> Use managed clock handling, differentiate between no clock (possibly OK)
> and clock init failure (never OK) and correctly handle clock detection
> being deferred.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/crypto/ccree/cc_driver.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
> index 6f93ce7..b266657 100644
> --- a/drivers/crypto/ccree/cc_driver.c
> +++ b/drivers/crypto/ccree/cc_driver.c
> @@ -190,6 +190,7 @@ static int init_cc_resources(struct platform_device *plat_dev)
>  	u64 dma_mask;
>  	const struct cc_hw_data *hw_rev;
>  	const struct of_device_id *dev_id;
> +	struct clk *clk;
>  	int rc = 0;
>  
>  	new_drvdata = devm_kzalloc(dev, sizeof(*new_drvdata), GFP_KERNEL);
> @@ -219,7 +220,24 @@ static int init_cc_resources(struct platform_device *plat_dev)
>  	platform_set_drvdata(plat_dev, new_drvdata);
>  	new_drvdata->plat_dev = plat_dev;
>  
> -	new_drvdata->clk = of_clk_get(np, 0);
> +	clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk))
> +		switch (PTR_ERR(clk)) {
> +		/* Clock is optional so this might be fine */
> +		case -ENOENT:
> +			break;
> +
> +		/* Clock not available, let's try again soon */
> +		case -EPROBE_DEFER:
> +			return -EPROBE_DEFER;
> +
> +		default:
> +			dev_err(dev, "Error getting clock: %ld\n",
> +				PTR_ERR(clk));
> +			return PTR_ERR(clk);
> +		}
> +	new_drvdata->clk = clk;
> +
>  	new_drvdata->coherent = of_dma_is_coherent(np);
>  
>  	/* Get device resources */
> -- 
> 2.7.4
> 
