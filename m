From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 24 Oct 2011 14:03:42 +0200
Subject: [PATCH] spi/pl022: Enable clock in probe an use runtime_idle
In-Reply-To: <1319206124-17549-1-git-send-email-ulf.hansson@stericsson.com>
References: <1319206124-17549-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20111024120342.GQ8708@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2011 at 04:08:44PM +0200, Ulf Hansson wrote:
> Since we are always runtime resumed when leaving probe
> the clock must be enabled. To accomplish that we are able
> to be runtime suspended after probe in the case when no
> request is going to be recieved, a runtime_idle function
> has been implemented.
> 
> Change-Id: I6cb86f2cad30ecaab16f512daf4674b039b18213
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Reviewed-on: http://gerrit.lud.stericsson.com/gerrit/34447

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Since it depends on Russell's tree, I'm okay with it going in that way.

g.

> ---
>  drivers/spi/spi-pl022.c |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index f103e47..ad48fba 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2184,6 +2184,12 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  		goto  err_clk_prep;
>  	}
>  
> +	status = clk_enable(pl022->clk);
> +	if (status) {
> +		dev_err(&adev->dev, "could not enable SSP/SPI bus clock\n");
> +		goto err_no_clk_en;
> +	}
> +
>  	/* Disable SSP */
>  	writew((readw(SSP_CR1(pl022->virtbase)) & (~SSP_CR1_MASK_SSE)),
>  	       SSP_CR1(pl022->virtbase));
> @@ -2237,6 +2243,8 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	free_irq(adev->irq[0], pl022);
>   err_no_irq:
> +	clk_disable(pl022->clk);
> + err_no_clk_en:
>  	clk_unprepare(pl022->clk);
>   err_clk_prep:
>  	clk_put(pl022->clk);
> @@ -2342,11 +2350,19 @@ static int pl022_runtime_resume(struct device *dev)
>  
>  	return 0;
>  }
> +
> +static int pl022_runtime_idle(struct device *dev)
> +{
> +	pm_runtime_suspend(dev);
> +	return 0;
> +}
>  #endif
>  
>  static const struct dev_pm_ops pl022_dev_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(pl022_suspend, pl022_resume)
> -	SET_RUNTIME_PM_OPS(pl022_runtime_suspend, pl022_runtime_resume, NULL)
> +	SET_RUNTIME_PM_OPS(pl022_runtime_suspend,
> +			   pl022_runtime_resume,
> +			   pl022_runtime_idle)
>  };
>  
>  static struct vendor_data vendor_arm = {
> -- 
> 1.7.5.4
> 
