From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 01 Jul 2014 11:05:04 +0900
Subject: [PATCH 15/17] video: fbdev: s3c-fb: remove s5pc100 related fimd
 and fb codes
In-Reply-To: <1404163947-3105-16-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <1404163947-3105-16-git-send-email-kgene.kim@samsung.com>
Message-ID: <00a401cf94d0$df8d94e0$9ea8bea0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 01, 2014 6:32 AM, Kukjin Kim wrote:
> 
> This patch removes fimd and fb codes for s5pc100 SoC.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  .../devicetree/bindings/video/samsung-fimd.txt     |    1 -
>  drivers/video/fbdev/Kconfig                        |    2 +-
>  drivers/video/fbdev/s3c-fb.c                       |   35 --------------------
>  include/video/samsung_fimd.h                       |    2 +-
>  4 files changed, 2 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/video/samsung-fimd.txt
> b/Documentation/devicetree/bindings/video/samsung-fimd.txt
> index 741f4a6..7794260 100644
> --- a/Documentation/devicetree/bindings/video/samsung-fimd.txt
> +++ b/Documentation/devicetree/bindings/video/samsung-fimd.txt
> @@ -8,7 +8,6 @@ Required properties:
>  - compatible: value should be one of the following
>  		"samsung,s3c2443-fimd"; /* for S3C24XX SoCs */
>  		"samsung,s3c6400-fimd"; /* for S3C64XX SoCs */
> -		"samsung,s5pc100-fimd"; /* for S5PC100 SoC  */
>  		"samsung,s5pv210-fimd"; /* for S5PV210 SoC */
>  		"samsung,exynos4210-fimd"; /* for Exynos4 SoCs */
>  		"samsung,exynos5250-fimd"; /* for Exynos5 SoCs */
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 11506e5..79708b2 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2019,7 +2019,7 @@ config FB_TMIO_ACCELL
>  config FB_S3C
>  	tristate "Samsung S3C framebuffer support"
>  	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX || \
> -		ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
> +		ARCH_S5PV210 || ARCH_EXYNOS)
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
> index a0cde41..b33abb0 100644
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1805,38 +1805,6 @@ static struct s3c_fb_driverdata s3c_fb_data_64xx = {
>  	.win[4]	= &s3c_fb_data_64xx_wins[4],
>  };
> 
> -static struct s3c_fb_driverdata s3c_fb_data_s5pc100 = {
> -	.variant = {
> -		.nr_windows	= 5,
> -		.vidtcon	= VIDTCON0,
> -		.wincon		= WINCON(0),
> -		.winmap		= WINxMAP(0),
> -		.keycon		= WKEYCON,
> -		.osd		= VIDOSD_BASE,
> -		.osd_stride	= 16,
> -		.buf_start	= VIDW_BUF_START(0),
> -		.buf_size	= VIDW_BUF_SIZE(0),
> -		.buf_end	= VIDW_BUF_END(0),
> -
> -		.palette = {
> -			[0] = 0x2400,
> -			[1] = 0x2800,
> -			[2] = 0x2c00,
> -			[3] = 0x3000,
> -			[4] = 0x3400,
> -		},
> -
> -		.has_prtcon	= 1,
> -		.has_blendcon	= 1,
> -		.has_clksel	= 1,
> -	},
> -	.win[0]	= &s3c_fb_data_s5p_wins[0],
> -	.win[1]	= &s3c_fb_data_s5p_wins[1],
> -	.win[2]	= &s3c_fb_data_s5p_wins[2],
> -	.win[3]	= &s3c_fb_data_s5p_wins[3],
> -	.win[4]	= &s3c_fb_data_s5p_wins[4],
> -};
> -
>  static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
>  	.variant = {
>  		.nr_windows	= 5,
> @@ -1975,9 +1943,6 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
>  		.name		= "s3c-fb",
>  		.driver_data	= (unsigned long)&s3c_fb_data_64xx,
>  	}, {
> -		.name		= "s5pc100-fb",
> -		.driver_data	= (unsigned long)&s3c_fb_data_s5pc100,
> -	}, {
>  		.name		= "s5pv210-fb",
>  		.driver_data	= (unsigned long)&s3c_fb_data_s5pv210,
>  	}, {
> diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
> index b039320..8af0c61 100644
> --- a/include/video/samsung_fimd.h
> +++ b/include/video/samsung_fimd.h
> @@ -107,7 +107,7 @@
>  #define VIDCON2_ORGYCbCr			(1 << 8)
>  #define VIDCON2_YUVORDCrCb			(1 << 7)
> 
> -/* PRTCON (S3C6410, S5PC100)
> +/* PRTCON (S3C6410)
>   * Might not be present in the S3C6410 documentation,
>   * but tests prove it's there almost for sure; shouldn't hurt in any case.
>   */
> --
> 1.7.10.4
