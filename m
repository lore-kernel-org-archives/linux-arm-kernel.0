From: david@lechnology.com (David Lechner)
Date: Wed, 21 Mar 2018 11:21:04 -0500
Subject: [PATCH 5/8] remoteproc: da8xx: add the missing checke for
 clk_enable()
In-Reply-To: <20180321120807.18032-6-brgl@bgdev.pl>
References: <20180321120807.18032-1-brgl@bgdev.pl>
 <20180321120807.18032-6-brgl@bgdev.pl>
Message-ID: <f528a120-d6e8-ff6f-243a-256ce4c392a9@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2018 07:08 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The davinci platform is being switched to using the common clock
> framework, where clk_enable() can fail. Add the return value check.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/remoteproc/da8xx_remoteproc.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index bf3b9034c319..592bf0fc52e8 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
>   	struct device *dev = rproc->dev.parent;
>   	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>   	struct clk *dsp_clk = drproc->dsp_clk;
> +	int rv;

For style points, you could use ret instead of rv to be consistent with
the rest of this driver.

>   
>   	/* hw requires the start (boot) address be on 1KB boundary */
>   	if (rproc->bootaddr & 0x3ff) {
> @@ -148,7 +149,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
>   
>   	writel(rproc->bootaddr, drproc->bootreg);
>   
> -	clk_enable(dsp_clk);
> +	rv = clk_enable(dsp_clk);
> +	if (rv) {
> +		dev_err(dev, "clk_enable() failed: %d\n", rv);
> +		return rv;
> +	}
> +
>   	davinci_clk_reset_deassert(dsp_clk);
>   
>   	return 0;
> 
