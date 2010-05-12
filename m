From: mpm@selenic.com (Matt Mackall)
Date: Wed, 12 May 2010 15:47:54 -0500
Subject: [PATCH 1/2] nomadik hwrng: Add clock support
In-Reply-To: <1273560944-13243-1-git-send-email-srinidhi.kasagar@stericsson.com>
References: <1273560944-13243-1-git-send-email-srinidhi.kasagar@stericsson.com>
Message-ID: <1273697274.15067.1136.camel@calx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-05-11 at 12:25 +0530, srinidhi kasagar wrote:
> This adds the clock support to the Nomadik RNG driver
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Looks good to me. Herbert, please queue this.

Acked-by: Matt Mackall <mpm@selenic.com>

> ---
>  drivers/char/hw_random/nomadik-rng.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
> index a8b4c40..ae094c1 100644
> --- a/drivers/char/hw_random/nomadik-rng.c
> +++ b/drivers/char/hw_random/nomadik-rng.c
> @@ -15,6 +15,10 @@
>  #include <linux/amba/bus.h>
>  #include <linux/hw_random.h>
>  #include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +
> +struct clk *rng_clk;
>  
>  static int nmk_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  {
> @@ -40,6 +44,15 @@ static int nmk_rng_probe(struct amba_device *dev, struct amba_id *id)
>  	void __iomem *base;
>  	int ret;
>  
> +	rng_clk = clk_get(&dev->dev, NULL);
> +	if (IS_ERR(rng_clk)) {
> +		dev_err(&dev->dev, "could not get rng clock\n");
> +		ret = PTR_ERR(rng_clk);
> +		return ret;
> +	}
> +
> +	clk_enable(rng_clk);
> +
>  	ret = amba_request_regions(dev, dev->dev.init_name);
>  	if (ret)
>  		return ret;
> @@ -57,6 +70,8 @@ out_unmap:
>  	iounmap(base);
>  out_release:
>  	amba_release_regions(dev);
> +	clk_disable(rng_clk);
> +	clk_put(rng_clk);
>  	return ret;
>  }
>  
> @@ -66,6 +81,8 @@ static int nmk_rng_remove(struct amba_device *dev)
>  	hwrng_unregister(&nmk_rng);
>  	iounmap(base);
>  	amba_release_regions(dev);
> +	clk_disable(rng_clk);
> +	clk_put(rng_clk);
>  	return 0;
>  }
>  



-- 
Mathematics is the supreme nostalgia of our time.
