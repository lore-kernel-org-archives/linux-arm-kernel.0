From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 25 May 2011 14:22:41 -0700
Subject: [GIT PULL] Samsung S5P for 2.6.40 merge window
In-Reply-To: <20110525205005.GC24876@n2100.arm.linux.org.uk>
References: <4DDD4659.5050602@samsung.com>
	<20110525205005.GC24876@n2100.arm.linux.org.uk>
Message-ID: <4DDD7321.80607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/11 13:50, Russell King - ARM Linux wrote:
> On Wed, May 25, 2011 at 11:11:37AM -0700, Kukjin Kim wrote:
>> These things are for 2.6.40 and it includes removing ARCH_S5P6442.
>> Actually there is no user now and if required will merge it into other
>> ARCH like ARCH_S5P64X0 later.
>
> I have a merge conflict with this, and resolved it as below.  Please check
> whether this is correct.
>
Hi Russell,

It's correct :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> diff --cc arch/arm/Kconfig
> index 3bc1a58,e81c72c..f7cce8b
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@@ -2028,7 -1998,7 +2016,7 @@@ menu "Power management options
>    source "kernel/power/Kconfig"
>
>    config ARCH_SUSPEND_POSSIBLE
> - 	depends on !ARCH_S5P64X0&&  !ARCH_S5P6442&&  !ARCH_S5PC100
>   -	depends on !ARCH_S5P64X0
> ++	depends on !ARCH_S5P64X0&&  !ARCH_S5PC100
>    	depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
>    		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE
>    	def_bool y
> diff --cc arch/arm/mach-exynos4/Kconfig
> index 8051962,11b57a4..b92c1e5
> --- a/arch/arm/mach-exynos4/Kconfig
> +++ b/arch/arm/mach-exynos4/Kconfig
> @@@ -169,9 -169,10 +169,11 @@@ config MACH_NUR
>    	select S3C_DEV_HSMMC2
>    	select S3C_DEV_HSMMC3
>    	select S3C_DEV_I2C1
> + 	select S3C_DEV_I2C3
>    	select S3C_DEV_I2C5
>   +	select S5P_DEV_USB_EHCI
>    	select EXYNOS4_SETUP_I2C1
> + 	select EXYNOS4_SETUP_I2C3
>    	select EXYNOS4_SETUP_I2C5
>    	select EXYNOS4_SETUP_SDHCI
>    	select SAMSUNG_DEV_PWM
> diff --cc arch/arm/mach-exynos4/mach-nuri.c
> index bb5d12f,d13c5e8..642702b
> --- a/arch/arm/mach-exynos4/mach-nuri.c
> +++ b/arch/arm/mach-exynos4/mach-nuri.c
> @@@ -30,8 -31,8 +31,10 @@@
>    #include<plat/cpu.h>
>    #include<plat/devs.h>
>    #include<plat/sdhci.h>
>   +#include<plat/ehci.h>
>   +#include<plat/clock.h>
> + #include<plat/gpio-cfg.h>
> + #include<plat/iic.h>
>
>    #include<mach/map.h>
>
> @@@ -282,7 -355,7 +367,8 @@@ static struct platform_device *nuri_dev
>    	&s3c_device_hsmmc3,
>    	&s3c_device_wdt,
>    	&s3c_device_timer[0],
>   +	&s5p_device_ehci,
> + 	&s3c_device_i2c3,
>
>    	/* NURI Devices */
>    	&nuri_gpio_keys,
> @@@ -300,13 -373,13 +386,16 @@@ static void __init nuri_map_io(void
>    static void __init nuri_machine_init(void)
>    {
>    	nuri_sdhci_init();
> + 	nuri_tsp_init();
>
>    	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
> + 	s3c_i2c3_set_platdata(&i2c3_data);
> + 	i2c_register_board_info(3, i2c3_devs, ARRAY_SIZE(i2c3_devs));
>    	i2c_register_board_info(5, i2c5_devs, ARRAY_SIZE(i2c5_devs));
>
>   +	nuri_ehci_init();
>   +	clk_xusbxti.rate = 24000000;
>   +
>    	/* Last */
>    	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
>    }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
