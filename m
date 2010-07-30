From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 30 Jul 2010 09:22:51 +0900
Subject: [PATCH v3 3/3] ARM: SAMSUNG: i2c/busses: Add HAVE_S3C2410_I2C
	option to include I2C for Samsung SoCs
In-Reply-To: <1280396565-21014-1-git-send-email-kgene.kim@samsung.com>
References: <1280396565-21014-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTikyOUyz+sNPgBvWU8FvYa8HvgRY4P2udhMY=eOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 6:42 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> From: Naveen Krishna Ch <ch.naveen@samsung.com>
>
> This patch adds HAVE_S3C2410_I2C to control inclusion of I2C bus driver
> on Samsung SoCs and makes I2C bus driver dependency SoC specific instead
> of machine specific. This will enalbe all machines using Samsung ARCH_S3C2410,
> _S3C64XX, _S5P6440, _S5PC100, and _S5PV210 to select the I2C driver by default

What's the different from use PLAT_SAMSUNG?

config I2C_S3C2410
        tristate "S3C2410 I2C Driver"
        depends on PLAT_SAMSUNG

Please don't populate the Kconfigs.

Thank you,
Kyungmin Park

>
> Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
> Changes since v2:
> - Added HAVE_S3C2410_I2C in drivers Kconfig
> - Made I2C bus driver dependency SoC specific
> - Selected additional support I2C bus driver for S5P6440, S5PC100,
> ?and S5PV210
>
> Changes since v1:
> - Modifed the Kconfig help comments.
>
> ?arch/arm/Kconfig ? ? ? ? ? | ? ?5 +++++
> ?drivers/i2c/busses/Kconfig | ? 11 +++++++++--
> ?2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 98922f7..e922994 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -634,6 +634,7 @@ config ARCH_S3C2410
> ? ? ? ?select ARCH_HAS_CPUFREQ
> ? ? ? ?select HAVE_CLK
> ? ? ? ?select ARCH_USES_GETTIMEOFFSET
> + ? ? ? select HAVE_S3C2410_I2C
> ? ? ? ?help
> ? ? ? ? ?Samsung S3C2410X CPU based systems, such as the Simtec Electronics
> ? ? ? ? ?BAST (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or
> @@ -663,6 +664,7 @@ config ARCH_S3C64XX
> ? ? ? ?select S3C_DEV_NAND
> ? ? ? ?select USB_ARCH_HAS_OHCI
> ? ? ? ?select SAMSUNG_GPIOLIB_4BIT
> + ? ? ? select HAVE_S3C2410_I2C
> ? ? ? ?help
> ? ? ? ? ?Samsung S3C64XX series based systems
>
> @@ -672,6 +674,7 @@ config ARCH_S5P6440
> ? ? ? ?select GENERIC_GPIO
> ? ? ? ?select HAVE_CLK
> ? ? ? ?select ARCH_USES_GETTIMEOFFSET
> + ? ? ? select HAVE_S3C2410_I2C
> ? ? ? ?help
> ? ? ? ? ?Samsung S5P6440 CPU based systems
>
> @@ -691,6 +694,7 @@ config ARCH_S5PC100
> ? ? ? ?select CPU_V7
> ? ? ? ?select ARM_L1_CACHE_SHIFT_6
> ? ? ? ?select ARCH_USES_GETTIMEOFFSET
> + ? ? ? select HAVE_S3C2410_I2C
> ? ? ? ?help
> ? ? ? ? ?Samsung S5PC100 series based systems
>
> @@ -701,6 +705,7 @@ config ARCH_S5PV210
> ? ? ? ?select HAVE_CLK
> ? ? ? ?select ARM_L1_CACHE_SHIFT_6
> ? ? ? ?select ARCH_USES_GETTIMEOFFSET
> + ? ? ? select HAVE_S3C2410_I2C
> ? ? ? ?help
> ? ? ? ? ?Samsung S5PV210/S5PC110 series based systems
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index bceafbf..f1751da 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -521,12 +521,19 @@ config I2C_PXA_SLAVE
> ? ? ? ? ?is necessary for systems where the PXA may be a target on the
> ? ? ? ? ?I2C bus.
>
> +config HAVE_S3C2410_I2C
> + ? ? ? bool
> + ? ? ? help
> + ? ? ? ? This will include I2C support for Samsung SoCs. If you want to
> + ? ? ? ? include I2C support for any machine, kindly select this in the
> + ? ? ? ? respective Kconfig file.
> +
> ?config I2C_S3C2410
> ? ? ? ?tristate "S3C2410 I2C Driver"
> - ? ? ? depends on ARCH_S3C2410 || ARCH_S3C64XX
> + ? ? ? depends on HAVE_S3C2410_I2C
> ? ? ? ?help
> ? ? ? ? ?Say Y here to include support for I2C controller in the
> - ? ? ? ? Samsung S3C2410 based System-on-Chip devices.
> + ? ? ? ? Samsung SoCs.
>
> ?config I2C_S6000
> ? ? ? ?tristate "S6000 I2C support"
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
