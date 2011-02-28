From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Feb 2011 16:42:31 +0900
Subject: [PATCH] ARM: EXYNOS4: Adds Samsung NURI board support
In-Reply-To: <4D676BB8.9040803@samsung.com>
References: <4D676BB8.9040803@samsung.com>
Message-ID: <002301cbd71b$1969bd00$4c3d3700$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minkyu Kang wrote:
> 
> This patch adds Samsung NURI board support.
> 
> Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> This patch is base on next-exynos4 branch at kgene tree.
> 
>  arch/arm/configs/exynos4_defconfig |    1 +
>  arch/arm/mach-exynos4/Kconfig      |   15 +++
>  arch/arm/mach-exynos4/Makefile     |    1 +
>  arch/arm/mach-exynos4/mach-nuri.c  |  233
> ++++++++++++++++++++++++++++++++++++
>  4 files changed, 250 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-exynos4/mach-nuri.c
> 

(snip)

> +config MACH_NURI
> +	bool "Mobile NURI Board"
> +	select CPU_EXYNOS4210
> +	select S3C_DEV_WDT
> +	select S3C_DEV_HSMMC
> +	select S3C_DEV_HSMMC2
> +	select S3C_DEV_HSMMC3
> +	select S3C_DEV_I2C1
> +	select S3C_DEV_I2C5
> +	select EXYNOS4_SETUP_I2C1
> +	select EXYNOS4_SETUP_I2C5
> +	select EXYNOS4_SETUP_SDHCI
> +	help
> +	  Machine support for Samsung Mobile NURI Board.
> +

(snip)

> +enum fixed_regulator_id {
> +	FIXED_REG_ID_MMC = 0,

	FIXED_REG_ID_MMC,

(snip)

> +static struct platform_device emmc_fixed_voltage = {
> +	.name			= "reg-fixed-voltage",
> +	.id			= FIXED_REG_ID_MMC,

Is there any reason to use FIXED_REG_ID_MMC instead directly id 0?

(snip)

> +static struct platform_device *nuri_devices[] __initdata = {
> +	/* Samsung Platform Devices */
> +	&emmc_fixed_voltage,
> +	&s3c_device_hsmmc0,
> +	&s3c_device_hsmmc2,
> +	&s3c_device_hsmmc3,
> +#ifdef CONFIG_S3C2410_WATCHDOG
> +	&s3c_device_wdt,
> +#endif

Basically no need to add #ifdef here.
Because "s3c_device_wdt" depends on CONFIG_S3C_DEV_WDT and you already
selected it in Kconfig.

Of course, CONFIG_S3C2410_WATCHDOG is another selection for watchdog driver.

I'm sorting it out like the relation of platform device and regarding device
driver.

(snip)

Others, looks ok to me.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
