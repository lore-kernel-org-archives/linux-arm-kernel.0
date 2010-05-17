From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 08:41:31 +0100
Subject: [PATCH v3 10/10] Input: s3c24xx_ts - Changes TYPEs for Samsung
	touchscreen driver
In-Reply-To: <1274076757-26550-1-git-send-email-kgene.kim@samsung.com>
References: <1274076757-26550-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100517074131.GV26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 03:12:37PM +0900, Kukjin Kim wrote:
> From: Naveen Krishna <ch.naveen@samsung.com>
> 
> The Touchscreen driver now uses only 2 TYPEs based on the variations
> of TSADC module in the respective SoCs.
> 
> TYPE_S3C24XX supports for S3C2410, S3C2440
> TYPE_S3C64XX supports for S3C6410, S5P6440, S5PVV210/S5PC110

I'd much rather we change from having the TYPE_ ebnum and move th
a bitfield specificying the capabilities of the hardware, so that if
in the future we don't have an S3C64XX_ADCCLRINTPNDNUP we don't need to
go and change the if () around it for the new driver.

I used feat and FEAT_ as a reasonable contraction for feature and features
to avoid typing whilst still conveying the meaning of the flags.
 
> Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> This patch is as per comments from Ben Dooks about following.
> 
> [PATCH v2 10/11] ARM: SAMSUNG: Remove the TYPE and replace it with a Feature
> [PATCH v2 11/11] Input: s3c24xx_ts - Uses Feature field instead TYPE for Samsung SoCs
> 
> 
>  drivers/input/touchscreen/s3c2410_ts.c |   14 ++++++--------
>  1 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index 8a970ea..f2c8328 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -86,10 +86,8 @@ struct s3c2410ts {
>  static struct s3c2410ts ts;
>  
>  enum s3c_cpu_type {
> -	TYPE_S3C2410,
> -	TYPE_S3C2440,
> -	TYPE_S3C64XX,	/* S3C64XX, S5P64XX Series */
> -	TYPE_S5PV210,	/* S5PV210 */
> +	TYPE_S3C24XX,	/* S3C2410, S3C2440 Series */
> +	TYPE_S3C64XX,	/* S3C64XX, S5P64XX, S5PV210 Series */
>  };
>  
>  /**
> @@ -179,7 +177,7 @@ static irqreturn_t stylus_irq(int irq, void *dev_id)
>  	else
>  		dev_info(ts.dev, "%s: count=%d\n", __func__, ts.count);
>  
> -	if (platform_get_device_id(pdev)->driver_data >= TYPE_S3C64XX) {
> +	if (platform_get_device_id(pdev)->driver_data != TYPE_S3C24XX) {
>  		/* Clear pen down/up interrupt */
>  		writel(0x0, ts.io + S3C64XX_ADCCLRINTPNDNUP);
>  	}
> @@ -416,10 +414,10 @@ static struct dev_pm_ops s3c_ts_pmops = {
>  #endif
>  
>  static struct platform_device_id s3cts_driver_ids[] = {
> -	{ "s3c2410-ts", TYPE_S3C2410 },
> -	{ "s3c2440-ts", TYPE_S3C2440 },
> +	{ "s3c2410-ts", TYPE_S3C24XX },
> +	{ "s3c2440-ts", TYPE_S3C24XX },
>  	{ "s3c64xx-ts", TYPE_S3C64XX },
> -	{ "s5pv210-ts", TYPE_S5PV210 },
> +	{ "s5pv210-ts", TYPE_S3C64XX },

Do we really need this?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, s3cts_driver_ids);
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
