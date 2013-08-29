From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 29 Aug 2013 17:05:45 +0200
Subject: [RFC 3/3] ARM: s5pc100: Migrate clock handling to Common Clock
 Framework
In-Reply-To: <1377707357-4902-4-git-send-email-m.krawczuk@partner.samsung.com>
References: <1377707357-4902-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1377707357-4902-4-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <1406622.PIapD4Dc4U@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 of August 2013 18:29:17 Mateusz Krawczuk wrote:
> This patch migrates the s5pc100 platform to use new clock driver
> using Common Clock Framework.
> 
> Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
> ---
>  arch/arm/mach-s5pc100/Kconfig         |  8 ++++++++
>  arch/arm/mach-s5pc100/Makefile        |  4 ++--
>  arch/arm/mach-s5pc100/common.c        | 23 ++++++++++++++++++++++-
>  arch/arm/mach-s5pc100/common.h        | 13 +++++++++++++
>  arch/arm/mach-s5pc100/mach-smdkc100.c |  3 ++-
>  arch/arm/plat-samsung/Kconfig         |  2 +-
>  6 files changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pc100/Kconfig
> b/arch/arm/mach-s5pc100/Kconfig index 15170be..ed50897 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -11,6 +11,7 @@ config CPU_S5PC100
>  	bool
>  	select S5P_EXT_INT
>  	select SAMSUNG_DMADEV
> +	select S5P_CLOCK if !COMMON_CLK_S5PC100
>  	help
>  	  Enable S5PC100 CPU support
> 
> @@ -50,6 +51,13 @@ config S5PC100_SETUP_SPI
>  	help
>  	  Common setup code for SPI GPIO configurations.
> 
> +config COMMON_CLK_S5PC100
> +	bool "Common Clock Framework support"
> +	default y
> +	select COMMON_CLK
> +	help
> +	  Common setup code for common clock framework.
> +
>  config MACH_SMDKC100
>  	bool "SMDKC100"
>  	select CPU_S5PC100
> diff --git a/arch/arm/mach-s5pc100/Makefile
> b/arch/arm/mach-s5pc100/Makefile index 118c711..74b90ec 100644
> --- a/arch/arm/mach-s5pc100/Makefile
> +++ b/arch/arm/mach-s5pc100/Makefile
> @@ -11,8 +11,8 @@ obj-				:=
> 
>  # Core
> 
> -obj-y				+= common.o clock.o
> -
> +obj-y				+= common.o
> +obj-$(CONFIG_S5P_CLOCK)	+= clock.o
>  obj-y				+= dma.o
> 
>  # machine support
> diff --git a/arch/arm/mach-s5pc100/common.c
> b/arch/arm/mach-s5pc100/common.c index c5a8eea..d8db7b2 100644
> --- a/arch/arm/mach-s5pc100/common.c
> +++ b/arch/arm/mach-s5pc100/common.c
> @@ -40,7 +40,13 @@
> 
>  #include <plat/cpu.h>
>  #include <plat/devs.h>
> +
> +#ifdef CONFIG_S5P_CLOCK
>  #include <plat/clock.h>
> +#else
> +#include <linux/clk-provider.h>
> +#endif
> +
>  #include <plat/sdhci.h>
>  #include <plat/adc-core.h>
>  #include <plat/ata-core.h>
> @@ -54,6 +60,18 @@
> 
>  #include "common.h"
> 
> +static unsigned long xxti_f, xusbxti_f;
> +
> +void __init s5pc100_set_xxti_freq(unsigned long freq)
> +{
> +	xxti_f = freq;
> +}
> +
> +void __init s5pc100_set_xusbxti_freq(unsigned long freq)
> +{
> +	xusbxti_f = freq;
> +}
> +

You might consolidate the two functions above into one - 
s5pc100_init_external_clocks() taking two arguments.

>  static const char name_s5pc100[] = "S5PC100";
> 
>  static struct cpu_table cpu_ids[] __initdata = {
> @@ -201,13 +219,14 @@ void __init s5pc100_map_io(void)
> 
>  void __init s5pc100_init_clocks(int xtal)
>  {
> +#ifdef CONFIG_S5P_CLOCK
>  	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
> 
>  	s3c24xx_register_baseclocks(xtal);
>  	s5p_register_clocks(xtal);
>  	s5pc100_register_clocks();
>  	s5pc100_setup_clocks();
> -	samsung_wdt_reset_init(S3C_VA_WATCHDOG);
> +#endif
>  }
> 
>  void __init s5pc100_init_irq(void)
> @@ -216,6 +235,8 @@ void __init s5pc100_init_irq(void)
> 
>  	/* VIC0, VIC1, and VIC2 are fully populated. */
>  	s5p_init_irq(vic, ARRAY_SIZE(vic));
> +	s5pc100_clk_init(NULL, xxti_f, xusbxti_f, S3C_VA_SYS);
> +	samsung_wdt_reset_init(S3C_VA_WATCHDOG);

This change (moving WDT reset initialization) should be noted in patch 
description, along with the reason to do so.

Best regards,
Tomasz
