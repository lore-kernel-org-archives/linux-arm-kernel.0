From: s-anna@ti.com (Suman Anna)
Date: Mon, 26 Mar 2018 16:15:57 -0500
Subject: [PATCH v4 5/8] remoteproc: da8xx: add the missing retval check
 for clk_enable()
In-Reply-To: <20180323130455.11470-6-brgl@bgdev.pl>
References: <20180323130455.11470-1-brgl@bgdev.pl>
 <20180323130455.11470-6-brgl@bgdev.pl>
Message-ID: <ceca8cdd-055a-58ef-80fa-988a6ab5fcdf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2018 08:04 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The davinci platform is being switched to using the common clock
> framework, where clk_enable() can fail. Add the return value check.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This patch can be applied agnostic of the CCF change as well.
I had been using "remoteproc/davinci: ..." on the patch subject for all
davinci remoteproc patches. So prefer to maintain the same.

With that,
Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index bf3b9034c319..2b24291337b7 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  	struct device *dev = rproc->dev.parent;
>  	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>  	struct clk *dsp_clk = drproc->dsp_clk;
> +	int ret;
>  
>  	/* hw requires the start (boot) address be on 1KB boundary */
>  	if (rproc->bootaddr & 0x3ff) {
> @@ -148,7 +149,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  
>  	writel(rproc->bootaddr, drproc->bootreg);
>  
> -	clk_enable(dsp_clk);
> +	ret = clk_enable(dsp_clk);
> +	if (ret) {
> +		dev_err(dev, "clk_enable() failed: %d\n", ret);
> +		return ret;
> +	}
> +
>  	davinci_clk_reset_deassert(dsp_clk);
>  
>  	return 0;
> 
