From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 31 Jul 2012 08:40:53 +0200
Subject: [PATCH v2 1/2] hw_random: mxc-rnga: Adapt clocks to new i.mx
 clock framework
In-Reply-To: <1343407672-27185-1-git-send-email-fabio.estevam@freescale.com>
References: <1343407672-27185-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120731064053.GW30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 01:47:51PM -0300, Fabio Estevam wrote:
> Adapt clocks to the new i.mx clock framework and fix the following warning:
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Herbert Xu <herbert@gondor.apana.org.au> 
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Both:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> Changes since v1:
> - Converted a missing 'clk_disable' to 'clk_disable_unprepare'
> 
>  drivers/char/hw_random/mxc-rnga.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/hw_random/mxc-rnga.c b/drivers/char/hw_random/mxc-rnga.c
> index 85074de..62c7efe 100644
> --- a/drivers/char/hw_random/mxc-rnga.c
> +++ b/drivers/char/hw_random/mxc-rnga.c
> @@ -152,14 +152,14 @@ static int __init mxc_rnga_probe(struct platform_device *pdev)
>  	if (rng_dev)
>  		return -EBUSY;
>  
> -	clk = clk_get(&pdev->dev, "rng");
> +	clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "Could not get rng_clk!\n");
>  		err = PTR_ERR(clk);
>  		goto out;
>  	}
>  
> -	clk_enable(clk);
> +	clk_prepare_enable(clk);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
> @@ -201,7 +201,7 @@ err_ioremap:
>  	release_mem_region(res->start, resource_size(res));
>  
>  err_region:
> -	clk_disable(clk);
> +	clk_disable_unprepare(clk);
>  	clk_put(clk);
>  
>  out:
> @@ -212,7 +212,7 @@ static int __exit mxc_rnga_remove(struct platform_device *pdev)
>  {
>  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	void __iomem *rng_base = (void __iomem *)mxc_rnga.priv;
> -	struct clk *clk = clk_get(&pdev->dev, "rng");
> +	struct clk *clk = clk_get(&pdev->dev, NULL);
>  
>  	hwrng_unregister(&mxc_rnga);
>  
> @@ -220,7 +220,7 @@ static int __exit mxc_rnga_remove(struct platform_device *pdev)
>  
>  	release_mem_region(res->start, resource_size(res));
>  
> -	clk_disable(clk);
> +	clk_disable_unprepare(clk);
>  	clk_put(clk);
>  
>  	return 0;
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
