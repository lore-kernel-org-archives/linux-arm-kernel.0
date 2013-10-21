From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 21 Oct 2013 11:42:33 +0200
Subject: [PATCH] spi/s3c64xx: Fix doubled clock disable on suspend
In-Reply-To: <1382348117-6666-1-git-send-email-k.kozlowski@samsung.com>
References: <1382348117-6666-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5264F709.2000409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/13 11:35, Krzysztof Kozlowski wrote:
> Fix doubled clock disable and unprepare during PM suspend which triggered
> the warnings:
[...]
> The clocks are already disabled before suspending.
> 
> Additionally add PM runtime get() and put() during resume so device
> won't sleep for the time of s3c64xx_spi_hwinit().
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c |   15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index a80376d..374be7d 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1482,10 +1482,6 @@ static int s3c64xx_spi_suspend(struct device *dev)
>  
>  	spi_master_suspend(master);
>  
> -	/* Disable the clock */
> -	clk_disable_unprepare(sdd->src_clk);
> -	clk_disable_unprepare(sdd->clk);
> -
>  	sdd->cur_speed = 0; /* Output Clock is stopped */
>  
>  	return 0;
> @@ -1496,16 +1492,19 @@ static int s3c64xx_spi_resume(struct device *dev)
>  	struct spi_master *master = dev_get_drvdata(dev);
>  	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
>  	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
> +	int ret;
>  
> +	ret = pm_runtime_get_sync(dev);

pm_runtime_{get,put}* must not be called from drivers's system suspend/resume
callbacks. Please use pm_runtime_suspended() to check device runtime PM status
in s3c64xx_spi_{suspend,resume} callbacks and handle the clocks appropriately.

Thanks,
Sylwester
