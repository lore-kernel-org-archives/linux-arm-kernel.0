From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Tue, 13 Mar 2012 13:38:49 +0900
Subject: [PATCH 2/3] ARM: Exynos: Add DRM core device support for
 Universal C210 board
In-Reply-To: <CAK9yfHyHoDucPwvZbb_ireRTohkd9hCDf3ER_yp3Rv_7BmNwhg@mail.gmail.com>
References: <1331291105-18152-1-git-send-email-m.szyprowski@samsung.com>
 <1331291105-18152-3-git-send-email-m.szyprowski@samsung.com>
 <CAK9yfHyHoDucPwvZbb_ireRTohkd9hCDf3ER_yp3Rv_7BmNwhg@mail.gmail.com>
Message-ID: <CAH9JG2UWE1CNOrHVtMawS9TrPHHZrgpbVwvgmXb4OiLObnxdsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/12, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi Marek,
> Thanks for the patch.
>
> On 09/03/2012, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Add core DRM device and alternative platform device data for FIMD DRM
>> subdriver. Based on the initial patch by Joonyoung Shim
>> <jy0922.shim@samsung.com>
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-exynos/Kconfig               |    1 +
>>  arch/arm/mach-exynos/mach-universal_c210.c |   31
>> ++++++++++++++++++++++++++++
>>  2 files changed, 32 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index 5a26944..c73eeba 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -257,6 +257,7 @@ config MACH_UNIVERSAL_C210
>>  	select S5P_DEV_ONENAND
>>  	select S5P_DEV_TV
>>  	select EXYNOS4_DEV_DMA
>> +	select EXYNOS_DEV_DRM
>>  	select EXYNOS4_SETUP_FIMD0
>>  	select EXYNOS4_SETUP_I2C1
>>  	select EXYNOS4_SETUP_I2C3
>> diff --git a/arch/arm/mach-exynos/mach-universal_c210.c
>> b/arch/arm/mach-exynos/mach-universal_c210.c
>> index 322b272..30a3ff3 100644
>> --- a/arch/arm/mach-exynos/mach-universal_c210.c
>> +++ b/arch/arm/mach-exynos/mach-universal_c210.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/i2c-gpio.h>
>>  #include <linux/i2c/mcs.h>
>>  #include <linux/i2c/atmel_mxt_ts.h>
>> +#include <drm/exynos_drm.h>
>>
>>  #include <asm/mach/arch.h>
>>  #include <asm/hardware/gic.h>
>> @@ -811,6 +812,27 @@ static struct i2c_board_info i2c1_devs[] __initdata =
>> {
>>  	/* Gyro, To be updated */
>>  };
>>
>> +#ifdef CONFIG_DRM_EXYNOS
>> +static struct exynos_drm_fimd_pdata drm_fimd_pdata = {
>> +	.timing	= {
>> +		.left_margin	= 16,
>> +		.right_margin	= 16,
>> +		.upper_margin	= 2,
>> +		.lower_margin	= 28,
>> +		.hsync_len	= 2,
>> +		.vsync_len	= 1,
>> +		.xres		= 480,
>> +		.yres		= 800,
>> +		.refresh	= 55,
>> +	},
>
> Shouldn't this be:
Right, recently we added the panel information. It should be drm-next soon.

Thank you,
Kyungmin Park
>                .panel = {
>                       .timing	= {
> 		                .left_margin	= 16,
>                         	.right_margin	= 16,
>                                 .upper_margin	= 2,
>                         	.lower_margin	= 28,
>                 		.hsync_len	= 2,
>                           	.vsync_len	= 1,
>                  		.xres		= 480,
>                                 .yres		= 800,
>                         	.refresh	= 55,
>                          },
>                  },
> 	
>
>> +	.vidcon0	= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB |
>> +			  VIDCON0_CLKSEL_LCD,
>> +	.vidcon1	= VIDCON1_INV_VCLK | VIDCON1_INV_VDEN
>> +			  | VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
>> +	.default_win	= 3,
>> +	.bpp		= 32,
>> +};
>> +#else
>>  /* Frame Buffer */
>>  static struct s3c_fb_pd_win universal_fb_win0 = {
>>  	.win_mode = {
>> @@ -838,6 +860,7 @@ static struct s3c_fb_platdata universal_lcd_pdata
>> __initdata = {
>>  			  | VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
>>  	.setup_gpio	= exynos4_fimd0_gpio_setup_24bpp,
>>  };
>> +#endif
>>
>>  static struct regulator_consumer_supply cam_vt_dio_supply =
>>  	REGULATOR_SUPPLY("vdd_core", "0-003c");
>> @@ -1046,6 +1069,9 @@ static struct platform_device *universal_devices[]
>> __initdata = {
>>  	&universal_gpio_keys,
>>  	&s5p_device_onenand,
>>  	&s5p_device_fimd0,
>> +#ifdef CONFIG_DRM_EXYNOS
>> +	&exynos_device_drm,
>> +#endif
>>  	&s5p_device_mfc,
>>  	&s5p_device_mfc_l,
>>  	&s5p_device_mfc_r,
>> @@ -1091,7 +1117,12 @@ static void __init universal_machine_init(void)
>>  	s5p_i2c_hdmiphy_set_platdata(NULL);
>>  	i2c_register_board_info(5, i2c5_devs, ARRAY_SIZE(i2c5_devs));
>>
>> +#ifdef CONFIG_DRM_EXYNOS
>> +	s5p_device_fimd0.dev.platform_data = &drm_fimd_pdata;
>> +	exynos4_fimd0_gpio_setup_24bpp();
>> +#else
>>  	s5p_fimd0_set_platdata(&universal_lcd_pdata);
>> +#endif
>>
>>  	universal_touchkey_init();
>>  	i2c_register_board_info(I2C_GPIO_BUS_12, i2c_gpio12_devs,
>> --
>> 1.7.1.569.g6f426
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-samsung-soc"
>> in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> With warm regards,
> Sachin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
