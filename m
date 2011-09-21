From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Sep 2011 21:06:06 +0900
Subject: [PATCH V2 1/3] ARM: EXYNOS4: Add TVOUT support for SMDKV310
In-Reply-To: <1316583860-32510-2-git-send-email-hatim.rv@samsung.com>
References: <1316583860-32510-1-git-send-email-hatim.rv@samsung.com>
	<1316583860-32510-2-git-send-email-hatim.rv@samsung.com>
Message-ID: <004901cc7856$d7ee21d0$87ca6570$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hatim Ali wrote:
> 
> Add support for TVOUT on SMDKV310 board.
> 
> Signed-off-by: Hatim Ali <hatim.rv@samsung.com>
> ---
> Changes since V1:
> Incorporated changes as suggested by Tomasz Stanislawski
> - Added  GPIO settings for hot-plug detection.
> - Added setting hdmi and mixer's parent for TV power domain.
> 
>  arch/arm/mach-exynos4/Kconfig         |    2 ++
>  arch/arm/mach-exynos4/mach-smdkv310.c |   25
> +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
> index 3b594fe..0bf0fe04 100644
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@ -131,6 +131,7 @@ config MACH_SMDKV310
>  	select S3C_DEV_RTC
>  	select S3C_DEV_WDT
>  	select S3C_DEV_I2C1
> +	select S5P_DEV_I2C_HDMIPHY
>  	select S5P_DEV_MFC
>  	select S3C_DEV_HSMMC
>  	select S3C_DEV_HSMMC1
> @@ -140,6 +141,7 @@ config MACH_SMDKV310
>  	select EXYNOS4_DEV_AHCI
>  	select SAMSUNG_DEV_KEYPAD
>  	select EXYNOS4_DEV_PD
> +	select S5P_DEV_TV
>  	select SAMSUNG_DEV_PWM
>  	select EXYNOS4_DEV_SYSMMU
>  	select EXYNOS4_SETUP_FIMD0
> diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-
> exynos4/mach-smdkv310.c
> index 7ce4d8b..50de270 100644
> --- a/arch/arm/mach-exynos4/mach-smdkv310.c
> +++ b/arch/arm/mach-exynos4/mach-smdkv310.c
> @@ -239,6 +239,7 @@ static struct platform_device *smdkv310_devices[]
> __initdata = {
>  	&s3c_device_hsmmc2,
>  	&s3c_device_hsmmc3,
>  	&s3c_device_i2c1,
> +	&s5p_device_i2c_hdmiphy,
>  	&s3c_device_rtc,
>  	&s3c_device_wdt,
>  	&exynos4_device_ac97,
> @@ -262,6 +263,8 @@ static struct platform_device *smdkv310_devices[]
> __initdata = {
>  	&smdkv310_lcd_lte480wv,
>  	&smdkv310_smsc911x,
>  	&exynos4_device_ahci,
> +	&s5p_device_hdmi,
> +	&s5p_device_mixer,
>  };
> 
>  static void __init smdkv310_smsc911x_init(void)
> @@ -298,6 +301,25 @@ static struct platform_pwm_backlight_data
> smdkv310_bl_data = {
>  	.pwm_period_ns  = 1000,
>  };
> 
> +static void s5p_tv_setup(void)
> +{
> +	int ret;
> +
> +	/* direct HPD to HDMI chip */
> +	ret = gpio_request(EXYNOS4_GPX3(7), "hpd-plug");
> +
> +	if (!ret) {
> +		gpio_direction_input(EXYNOS4_GPX3(7));
> +		s3c_gpio_cfgpin_range(EXYNOS4_GPX3(7),
> +					1, S3C_GPIO_SFN(3));

Why do you use 's3c_gpio_cfgpin_range()' for just one gpio pin not range...?

> +	} else
> +		pr_err("Failed to request gpio for hpd: %d\n", ret);

According to coding style, should be added { and } around above.

> +
> +	/* setup dependencies between TV devices */
> +	s5p_device_hdmi.dev.parent = &exynos4_device_pd[PD_TV].dev;
> +	s5p_device_mixer.dev.parent = &exynos4_device_pd[PD_TV].dev;
> +}
> +
>  static void __init smdkv310_map_io(void)
>  {
>  	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
> @@ -327,6 +349,9 @@ static void __init smdkv310_machine_init(void)
>  	samsung_bl_set(&smdkv310_bl_gpio_info, &smdkv310_bl_data);
>  	s5p_fimd0_set_platdata(&smdkv310_lcd0_pdata);
> 
> +	s5p_tv_setup();
> +	s5p_i2c_hdmiphy_set_platdata(NULL);
> +
>  	platform_add_devices(smdkv310_devices,
> ARRAY_SIZE(smdkv310_devices));
>  	s5p_device_mfc.dev.parent = &exynos4_device_pd[PD_MFC].dev;
>  }
> --
> 1.7.2.3

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
