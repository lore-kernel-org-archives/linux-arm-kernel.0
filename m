From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 09 Dec 2013 18:19:16 +0100
Subject: [PATCH v3 5/5] ARM: S3C24XX: Convert s3c2416 and s3c2443 to common
 clock framework
In-Reply-To: <201312031624.11442.heiko@sntech.de>
References: <201312031619.58062.heiko@sntech.de>
 <201312031624.11442.heiko@sntech.de>
Message-ID: <4563504.qD7ztRvaeD@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Tuesday 03 of December 2013 16:24:11 Heiko St?bner wrote:
> This converts the mentioned platforms to use the newly introduced driver
> for the common clock framework for them.
> 
> With this the whole legacy clock structure can go away too.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/s3c2416-smdk2416.dts  |    9 +
>  arch/arm/boot/dts/s3c2416.dtsi          |   48 +++
>  arch/arm/mach-s3c24xx/Kconfig           |   14 +-
>  arch/arm/mach-s3c24xx/Makefile          |    5 +-
>  arch/arm/mach-s3c24xx/clock-s3c2416.c   |  171 --------
>  arch/arm/mach-s3c24xx/clock-s3c2443.c   |  212 ----------
>  arch/arm/mach-s3c24xx/common-s3c2443.c  |  675 -------------------------------
>  arch/arm/mach-s3c24xx/common.c          |   16 +-
>  arch/arm/mach-s3c24xx/common.h          |    6 +
>  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |   39 +-
>  arch/arm/mach-s3c24xx/mach-smdk2416.c   |    9 +-
>  arch/arm/mach-s3c24xx/mach-smdk2443.c   |    9 +-
>  12 files changed, 98 insertions(+), 1115 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
>  delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2443.c
>  delete mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c

I would split this patch into one adding necessary definitions to DTS
files, then one migrating the platform to CCF. Until the driver gets
selected by respective Kconfig options, the entries in device tree should
not have any impact on the system, but you get rid of one patch doing
changes across two different trees.

Ideally this should be also done in one more step, allowing both clock
frameworks to coexist first and then removing the legacy code as the last
step to allow the new code to get more testing. However for this platform,
which isn't really very active nowadays, it might be fine to skip this.

> diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
> index 59594cf..fefb699 100644
> --- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
> +++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
> @@ -19,6 +19,15 @@
>  		reg =  <0x30000000 0x4000000>;
>  	};
>  
> +	clocks {
> +		xti: xti {
> +			compatible = "fixed-clock";
> +			clock-frequency = <12000000>;
> +			clock-output-names = "xti";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
>  	serial at 50000000 {
>  		status = "okay";
>  		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
> index e6555bd..4bde5a2 100644
> --- a/arch/arm/boot/dts/s3c2416.dtsi
> +++ b/arch/arm/boot/dts/s3c2416.dtsi
> @@ -8,6 +8,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <dt-bindings/clock/samsung,s3c2443-clock.h>
>  #include "s3c24xx.dtsi"
>  #include "s3c2416-pinctrl.dtsi"
>  
> @@ -28,26 +29,59 @@
>  		compatible = "samsung,s3c2416-irq";
>  	};
>  
> +	clocks {

Don't you need compatible = "simple-bus" here for the subnodes to be
instantiated?

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		clocks: clock-controller at 0x4c000000 {

Why is this in a subnode? Clock controller is a part of the SoC, so IMHO
it should be on the same level as other peripherals.

> +			compatible = "samsung,s3c2416-clock";
> +			reg = <0x4c000000 0x40>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +
[snip]
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index 2eeeb55..f2fe2ad 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -50,9 +50,9 @@ config CPU_S3C2416
>  	select CPU_ARM926T
>  	select CPU_LLSERIAL_S3C2440
>  	select S3C2416_PM if PM
> -	select S3C2443_COMMON
>  	select S3C2443_DMA if S3C24XX_DMA
> -	select SAMSUNG_CLKSRC
> +	select COMMON_CLK
> +	select S3C2443_COMMON_CLK

Please keep selected symbols sorted alphabetically.

>  	help
>  	  Support for the S3C2416 SoC from the S3C24XX line
>  
> @@ -85,9 +85,9 @@ config CPU_S3C2443
>  	bool "SAMSUNG S3C2443"
>  	select CPU_ARM920T
>  	select CPU_LLSERIAL_S3C2440
> -	select S3C2443_COMMON
>  	select S3C2443_DMA if S3C24XX_DMA
> -	select SAMSUNG_CLKSRC
> +	select COMMON_CLK
> +	select S3C2443_COMMON_CLK

Ditto.

>  	help
>  	  Support for the S3C2443 SoC from the S3C24XX line
>  
> @@ -664,12 +664,6 @@ endif	# CPU_S3C2442
>  
>  if CPU_S3C2443 || CPU_S3C2416
>  
> -config S3C2443_COMMON
> -	bool
> -	help
> -	  Common code for the S3C2443 and similar processors, which includes
> -	  the S3C2416 and S3C2450.
> -
>  config S3C2443_COMMON_CLK
>  	bool
>  	help
[snip]
> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
> index 4adaa4b..d87e432 100644
> --- a/arch/arm/mach-s3c24xx/common.c
> +++ b/arch/arm/mach-s3c24xx/common.c
> @@ -145,7 +145,6 @@ static struct cpu_table cpu_ids[] __initdata = {
>  		.idcode		= 0x32450003,
>  		.idmask		= 0xffffffff,
>  		.map_io		= s3c2416_map_io,
> -		.init_clocks	= s3c2416_init_clocks,
>  		.init_uarts	= s3c2416_init_uarts,
>  		.init		= s3c2416_init,
>  		.name		= name_s3c2416,
> @@ -154,7 +153,6 @@ static struct cpu_table cpu_ids[] __initdata = {
>  		.idcode		= 0x32443001,
>  		.idmask		= 0xffffffff,
>  		.map_io		= s3c2443_map_io,
> -		.init_clocks	= s3c2443_init_clocks,
>  		.init_uarts	= s3c2443_init_uarts,
>  		.init		= s3c2443_init,
>  		.name		= name_s3c2443,
> @@ -535,3 +533,17 @@ struct platform_device s3c2443_device_dma = {
>  	},
>  };
>  #endif
> +
> +#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_CPU_S3C2416)

Isn't CONFIG_COMMON_CLK be selected by CPU_S3C2416?

> +void __init s3c2416_init_clocks(int xtal)
> +{
> +	s3c2443_common_clk_init(NULL, xtal, 0, S3C24XX_VA_CLKPWR);
> +}
> +#endif
> +
> +#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_CPU_S3C2443)

Ditto.

> +void __init s3c2443_init_clocks(int xtal)
> +{
> +	s3c2443_common_clk_init(NULL, xtal, 1, S3C24XX_VA_CLKPWR);
> +}
> +#endif
> diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
> index e46c104..d7323f1 100644
> --- a/arch/arm/mach-s3c24xx/common.h
> +++ b/arch/arm/mach-s3c24xx/common.h
> @@ -114,4 +114,10 @@ extern struct platform_device s3c2412_device_dma;
>  extern struct platform_device s3c2440_device_dma;
>  extern struct platform_device s3c2443_device_dma;
>  
> +#ifdef CONFIG_S3C2443_COMMON_CLK
> +void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
> +				    int current_soc,
> +				    void __iomem *reg_base);
> +#endif
> +
>  #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
> diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
> index f50454a..0a86953 100644
> --- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
> +++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
> @@ -18,59 +18,23 @@
>  #include <linux/clocksource.h>
>  #include <linux/irqchip.h>
>  #include <linux/of_platform.h>
> -#include <linux/serial_core.h>
>  
>  #include <asm/mach/arch.h>
>  #include <mach/map.h>
>  
>  #include <plat/cpu.h>
>  #include <plat/pm.h>
> -#include <plat/regs-serial.h>
>  
>  #include "common.h"
>  
> -/*
> - * The following lookup table is used to override device names when devices
> - * are registered from device tree. This is temporarily added to enable
> - * device tree support addition for the S3C2416 architecture.
> - *
> - * For drivers that require platform data to be provided from the machine
> - * file, a platform data pointer can also be supplied along with the
> - * devices names. Usually, the platform data elements that cannot be parsed
> - * from the device tree by the drivers (example: function pointers) are
> - * supplied. But it should be noted that this is a temporary mechanism and
> - * at some point, the drivers should be capable of parsing all the platform
> - * data from the device tree.
> - */
> -static const struct of_dev_auxdata s3c2416_auxdata_lookup[] __initconst = {
> -	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C24XX_PA_UART,
> -				"s3c2440-uart.0", NULL),
> -	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C24XX_PA_UART + 0x4000,
> -				"s3c2440-uart.1", NULL),
> -	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C24XX_PA_UART + 0x8000,
> -				"s3c2440-uart.2", NULL),
> -	OF_DEV_AUXDATA("samsung,s3c2440-uart", S3C24XX_PA_UART + 0xC000,
> -				"s3c2440-uart.3", NULL),
> -	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", S3C_PA_HSMMC0,
> -				"s3c-sdhci.0", NULL),
> -	OF_DEV_AUXDATA("samsung,s3c6410-sdhci", S3C_PA_HSMMC1,
> -				"s3c-sdhci.1", NULL),
> -	OF_DEV_AUXDATA("samsung,s3c2440-i2c", S3C_PA_IIC,
> -				"s3c2440-i2c.0", NULL),
> -	{},
> -};
> -
>  static void __init s3c2416_dt_map_io(void)
>  {
>  	s3c24xx_init_io(NULL, 0);
> -	s3c24xx_init_clocks(12000000);
>  }
>  
>  static void __init s3c2416_dt_machine_init(void)
>  {
> -	of_platform_populate(NULL, of_default_bus_match_table,
> -				s3c2416_auxdata_lookup, NULL);
> -
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  	s3c_pm_init();
>  }
>  
> @@ -86,6 +50,5 @@ DT_MACHINE_START(S3C2416_DT, "Samsung S3C2416 (Flattened Device Tree)")
>  	.map_io		= s3c2416_dt_map_io,
>  	.init_irq	= irqchip_init,
>  	.init_machine	= s3c2416_dt_machine_init,
> -	 .init_time	= clocksource_of_init,

Should it really be a part of this patch?

Otherwise the patch looks fine.

Best regards,
Tomasz
