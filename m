From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Jul 2012 09:41:58 +0200
Subject: [PATCH 1/2] hw_random: mxc-rnga: Adapt clocks to new i.mx clock
 framework
In-Reply-To: <1341606020-26449-1-git-send-email-fabio.estevam@freescale.com>
References: <1341606020-26449-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120709074158.GS30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 05:20:19PM -0300, Fabio Estevam wrote:
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Herbert Xu <herbert@gondor.apana.org.au> 
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/char/hw_random/mxc-rnga.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/hw_random/mxc-rnga.c b/drivers/char/hw_random/mxc-rnga.c
> index 85074de..c49c0b8 100644
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

Uhh, that's a driver bug that should be fixed. Although right now there
is no reference counting for clocks, the driver should keep the clk
internally instead of simply calling clk_get whenever it needs access to
a clk.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
