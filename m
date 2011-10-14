From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Oct 2011 16:13:50 +0900
Subject: [PATCH] ARM: Samsung: Move fimc plat. device from board files to
	plat-samsung
In-Reply-To: <1318433485-1757-1-git-send-email-s.nawrocki@samsung.com>
References: <039b01cc8730$594ab530$0be01f90$%kim@samsung.com>
	<1318433485-1757-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <085e01cc8a40$d31a54c0$794efe40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Move the platform device definitions from boards code to plat-samsung
> to avoid multiple instances when multiple board support is compiled in.
> The boards should select at least S5P_DEV_FIMC0 to enable FIMC support.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Hi Kgene,
> 
> To decrease overall diff size, if it's not too late yet, you might want to
> squash parts of this patch with previous commits:
> 
Hi Sylwester,

Sorry it's late to rebase following which are included in
next-samsung-devel-2 branch and already it has been sent to arm-soc.

> 0513218 ARM: S5PV210: Add support for M-5MOLS image sensor on
> UNIVERSAL_C210
> 39aefab ARM: S5PV210: Add support for NOON010PC30 sensor on GONI board
> 
> Here is the optional new patch summary:
> 
> ARM: Samsung: Add fimc platform device for s5p-fimc media device driver
> 
> The s5p-fimc driver now creates an aggregate media device which is bound
> to "s5p-fimc-md" platform device. This patch adds such a platform device
> instance to be registered by each board that requires FIMC device support.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Sorry for the noise.
> 
> Regards,
> Sylwester
> ---
>  arch/arm/mach-exynos4/mach-universal_c210.c |    5 -----
>  arch/arm/mach-s5pv210/mach-goni.c           |    5 -----
>  arch/arm/plat-samsung/devs.c                |    5 +++++
>  arch/arm/plat-samsung/include/plat/devs.h   |    1 +
>  4 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-
> exynos4/mach-universal_c210.c
> index 18cf5c7..2096c8b 100644
> --- a/arch/arm/mach-exynos4/mach-universal_c210.c
> +++ b/arch/arm/mach-exynos4/mach-universal_c210.c
> @@ -920,11 +920,6 @@ static struct s5p_platform_fimc fimc_md_platdata = {
>  	.num_clients	= ARRAY_SIZE(universal_camera_sensors),
>  };
> 
> -struct platform_device s5p_device_fimc_md = {
> -	.name	= "s5p-fimc-md",
> -	.id	= -1,
> -};
> -
>  static struct gpio universal_camera_gpios[] = {
>  	{ GPIO_CAM_LEVEL_EN(1),	GPIOF_OUT_INIT_HIGH,
> "CAM_LVL_EN1" },
>  	{ GPIO_CAM_LEVEL_EN(2),	GPIOF_OUT_INIT_LOW,
> "CAM_LVL_EN2" },
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c
b/arch/arm/mach-s5pv210/mach-
> goni.c
> index 01e4867..61da205 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -849,11 +849,6 @@ struct s5p_platform_fimc goni_fimc_md_platdata
> __initdata = {
>  	.num_clients	= ARRAY_SIZE(goni_camera_sensors),
>  };
> 
> -struct platform_device s5p_device_fimc_md = {
> -	.name		= "s5p-fimc-md",
> -	.id		= -1,
> -};
> -
>  static struct platform_device *goni_devices[] __initdata = {
>  	&s3c_device_fb,
>  	&s5p_device_onenand,
> diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
> index cb6fd9e..4ca8b57 100644
> --- a/arch/arm/plat-samsung/devs.c
> +++ b/arch/arm/plat-samsung/devs.c
> @@ -204,6 +204,11 @@ struct platform_device s5p_device_fimc0 = {
>  		.coherent_dma_mask	= DMA_BIT_MASK(32),
>  	},
>  };
> +
> +struct platform_device s5p_device_fimc_md = {
> +	.name	= "s5p-fimc-md",
> +	.id	= -1,
> +};
>  #endif /* CONFIG_S5P_DEV_FIMC0 */
> 
>  #ifdef CONFIG_S5P_DEV_FIMC1
> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-
> samsung/include/plat/devs.h
> index 8f19241..ab633c9 100644
> --- a/arch/arm/plat-samsung/include/plat/devs.h
> +++ b/arch/arm/plat-samsung/include/plat/devs.h
> @@ -77,6 +77,7 @@ extern struct platform_device s5p_device_fimc0;
>  extern struct platform_device s5p_device_fimc1;
>  extern struct platform_device s5p_device_fimc2;
>  extern struct platform_device s5p_device_fimc3;
> +extern struct platform_device s5p_device_fimc_md;
>  extern struct platform_device s5p_device_fimd0;
>  extern struct platform_device s5p_device_hdmi;
>  extern struct platform_device s5p_device_i2c_hdmiphy;
> --
> 1.7.7

Applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
