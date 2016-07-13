From: andi.shyti@samsung.com (Andi Shyti)
Date: Wed, 13 Jul 2016 18:17:56 +0900
Subject: [PATCH -next] spi: s3c64xx: fix reference leak to master in
 s3c64xx_spi_remove()
In-Reply-To: <1468321722-16568-1-git-send-email-weiyj_lk@163.com>
References: <CGME20160712110926epcas1p13bbc88f5867d41d09d9b8c1172a7150b@epcas1p1.samsung.com>
 <1468321722-16568-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20160713091756.GL18237@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 11:08:42AM +0000, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Once a spi_master_get() call succeeds, we need an additional
> spi_master_put() call to free the memory, otherwise we will
> leak a reference to master. Fix by removing the unnecessary
> spi_master_get() call.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

After our discussion, I checked it again and feel free to add

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Thanks,
Andi

> ---
>  drivers/spi/spi-s3c64xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index df88fa1..001c9eb 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1211,7 +1211,7 @@ err0:
>  
>  static int s3c64xx_spi_remove(struct platform_device *pdev)
>  {
> -	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
> +	struct spi_master *master = platform_get_drvdata(pdev);
>  	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
>  
>  	pm_runtime_get_sync(&pdev->dev);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
