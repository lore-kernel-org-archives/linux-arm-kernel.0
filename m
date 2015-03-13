From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Mar 2015 15:53:16 +0100
Subject: [PATCH v4 8/9] ARM: at91: sama5 use SoC detection infrastructure
In-Reply-To: <1426172071-20743-9-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426172071-20743-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426172071-20743-9-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5502F9DC.8010707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/03/2015 15:54, Alexandre Belloni a ?crit :
> Use the soc detection infrastructure for sama5 initialization.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-at91/sama5.c | 49 ++++++++++++++++++++++++++++++++--------------
>  arch/arm/mach-at91/soc.h   | 13 ++++++++++++
>  2 files changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> index 03dcb441f3d2..bb9921e9cf78 100644
> --- a/arch/arm/mach-at91/sama5.c
> +++ b/arch/arm/mach-at91/sama5.c
> @@ -7,27 +7,41 @@
>   * Licensed under GPLv2 or later.
>   */
>  
> -#include <linux/types.h>
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/gpio.h>
>  #include <linux/micrel_phy.h>
>  #include <linux/of.h>
> -#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy.h>
> -#include <linux/clk-provider.h>
> -#include <linux/phy.h>
> -
> -#include <mach/hardware.h>
>  
> -#include <asm/setup.h>
> -#include <asm/irq.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> -#include <asm/mach/irq.h>
> +#include <asm/system_misc.h>
> +
> +#include <mach/hardware.h>
>  
>  #include "generic.h"
> +#include "soc.h"
> +
> +static const struct at91_soc sama5_socs[] = {
> +	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D31_EXID_MATCH,
> +		 "sama5d31", "sama5d3"),
> +	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D33_EXID_MATCH,
> +		 "sama5d33", "sama5d3"),
> +	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D34_EXID_MATCH,
> +		 "sama5d34", "sama5d3"),
> +	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D35_EXID_MATCH,
> +		 "sama5d35", "sama5d3"),
> +	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D36_EXID_MATCH,
> +		 "sama5d36", "sama5d3"),
> +	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D41_EXID_MATCH,
> +		 "sama5d41", "sama5d4"),
> +	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D42_EXID_MATCH,
> +		 "sama5d41", "sama5d4"),

Trivial: s/sama5d41/sama5d42/

;-)


> +	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D43_EXID_MATCH,
> +		 "sama5d43", "sama5d4"),
> +	AT91_SOC(SAMA5D4_CIDR_MATCH, SAMA5D44_EXID_MATCH,
> +		 "sama5d44", "sama5d4"),
> +	{ /* sentinel */ },
> +};
>  
>  static int ksz8081_phy_fixup(struct phy_device *phy)
>  {
> @@ -42,13 +56,20 @@ static int ksz8081_phy_fixup(struct phy_device *phy)
>  
>  static void __init sama5_dt_device_init(void)
>  {
> +	struct soc_device *soc;
> +	struct device *soc_dev = NULL;
> +
> +	soc = at91_soc_init(sama5_socs);
> +	if (soc != NULL)
> +		soc_dev = soc_device_to_device(soc);
> +
>  	if (of_machine_is_compatible("atmel,sama5d4ek") &&
>  	   IS_ENABLED(CONFIG_PHYLIB)) {
>  		phy_register_fixup_for_id("fc028000.etherne:00",
>  						ksz8081_phy_fixup);
>  	}
>  
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
>  	at91sam9x5_pm_init();
>  }
>  
> @@ -59,7 +80,6 @@ static const char *sama5_dt_board_compat[] __initconst = {
>  
>  DT_MACHINE_START(sama5_dt, "Atmel SAMA5")
>  	/* Maintainer: Atmel */
> -	.map_io		= at91_map_io,
>  	.init_machine	= sama5_dt_device_init,
>  	.dt_compat	= sama5_dt_board_compat,
>  MACHINE_END
> @@ -93,7 +113,6 @@ static struct map_desc at91_io_desc[] __initdata = {
>  
>  static void __init sama5_alt_map_io(void)
>  {
> -	at91_alt_map_io();
>  	iotable_init(at91_io_desc, ARRAY_SIZE(at91_io_desc));
>  }
>  
> diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
> index 2510c211f291..be23c400596b 100644
> --- a/arch/arm/mach-at91/soc.h
> +++ b/arch/arm/mach-at91/soc.h
> @@ -62,4 +62,17 @@ at91_soc_init(const struct at91_soc *socs);
>  #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
>  #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
>  
> +#define SAMA5D3_CIDR_MATCH		0x0a5c07c0
> +#define SAMA5D31_EXID_MATCH		0x00444300
> +#define SAMA5D33_EXID_MATCH		0x00414300
> +#define SAMA5D34_EXID_MATCH		0x00414301
> +#define SAMA5D35_EXID_MATCH		0x00584300
> +#define SAMA5D36_EXID_MATCH		0x00004301
> +
> +#define SAMA5D4_CIDR_MATCH		0x0a5c07c0
> +#define SAMA5D41_EXID_MATCH		0x00000001
> +#define SAMA5D42_EXID_MATCH		0x00000002
> +#define SAMA5D43_EXID_MATCH		0x00000003
> +#define SAMA5D44_EXID_MATCH		0x00000004
> +
>  #endif /* __AT91_SOC_H */
> 


-- 
Nicolas Ferre
