From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jun 2014 10:38:09 +0100
Subject: [PATCH 02/13] uio: uio_pruss: use devm_kzalloc()
In-Reply-To: <1404058907-21112-3-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-3-git-send-email-a.heider@gmail.com>
Message-ID: <20140630093809.GW7262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 05:21:36PM +0100, Andre Heider wrote:
> Replace kzalloc() by devm_kzalloc() and remove the kfree() calls.
> 
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  drivers/uio/uio_pruss.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
> index c28d6e2..f07545b 100644
> --- a/drivers/uio/uio_pruss.c
> +++ b/drivers/uio/uio_pruss.c
> @@ -109,9 +109,7 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
>  		gen_pool_free(gdev->sram_pool,
>  			      gdev->sram_vaddr,
>  			      sram_pool_sz);
> -	kfree(gdev->info);
>  	clk_put(gdev->pruss_clk);
> -	kfree(gdev);
>  }
>  
>  static int pruss_probe(struct platform_device *pdev)
> @@ -123,24 +121,19 @@ static int pruss_probe(struct platform_device *pdev)
>  	int ret = -ENODEV, cnt = 0, len;
>  	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
>  
> -	gdev = kzalloc(sizeof(struct uio_pruss_dev), GFP_KERNEL);
> +	gdev = devm_kzalloc(dev, sizeof(struct uio_pruss_dev), GFP_KERNEL);

If this is changing anyway, how about:

	gdev = devm_kzalloc(dev, sizeof(*gdev), GFP_KERNEL);

Cheers,
Mark.
