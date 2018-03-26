From: s-anna@ti.com (Suman Anna)
Date: Mon, 26 Mar 2018 16:19:33 -0500
Subject: [PATCH v4 6/8] remoteproc: da8xx: prepare and unprepare the clock
 where needed
In-Reply-To: <20180323130455.11470-7-brgl@bgdev.pl>
References: <20180323130455.11470-1-brgl@bgdev.pl>
 <20180323130455.11470-7-brgl@bgdev.pl>
Message-ID: <07c2258c-b4ca-5dd6-0a9b-47c5a3fac826@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2018 08:04 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We're currently switching the platform to using the common clock
> framework. We need to explicitly prepare and unprepare the rproc
> clock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

FWIW, I have been able to use this patch even without the CCF adaptation
as clk_prepare()/clk_unprepare() are stubs returning 0, and the
effective code would be same as before. Prefer "remoteproc/davinci: ..."
on the patch subject as was being done previously.

With that,
Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index 2b24291337b7..f134192922e0 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -149,9 +149,9 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  
>  	writel(rproc->bootaddr, drproc->bootreg);
>  
> -	ret = clk_enable(dsp_clk);
> +	ret = clk_prepare_enable(dsp_clk);
>  	if (ret) {
> -		dev_err(dev, "clk_enable() failed: %d\n", ret);
> +		dev_err(dev, "clk_prepare_enable() failed: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -165,7 +165,7 @@ static int da8xx_rproc_stop(struct rproc *rproc)
>  	struct da8xx_rproc *drproc = rproc->priv;
>  
>  	davinci_clk_reset_assert(drproc->dsp_clk);
> -	clk_disable(drproc->dsp_clk);
> +	clk_disable_unprepare(drproc->dsp_clk);
>  
>  	return 0;
>  }
> 
