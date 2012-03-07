From: robherring2@gmail.com (Rob Herring)
Date: Wed, 07 Mar 2012 13:58:06 -0600
Subject: [PATCH 5/6] ARM: at91: add ram controller DT support
In-Reply-To: <1330718048-9314-5-git-send-email-plagnioj@jcrosoft.com>
References: <20120302192844.GB21255@game.jcrosoft.org>
 <1330718048-9314-5-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4F57BDCE.1050708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2012 01:54 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> We can now drop the call to ioremap_registers() as we have the binding for the
> SDRAM/DDR Controller.
> 
> Drop ioremap_registers() for sam9x5 too.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.txt         |   19 ++++++++++++++
>  arch/arm/boot/dts/at91sam9g20.dtsi                 |    5 +++
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |    6 ++++
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 +++
>  arch/arm/mach-at91/at91sam9x5.c                    |    6 ----
>  arch/arm/mach-at91/include/mach/at91sam9x5.h       |    5 ---
>  arch/arm/mach-at91/setup.c                         |   27 +++++++++++++++++--
>  7 files changed, 59 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> index a64f867..1f87820 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> @@ -42,3 +42,22 @@ Example:
>  		compatible = "atmel,at91sam9260-rstc";
>  		reg = <0xfffffd00 0x10>;
>  	};
> +
> +RAMC SDRAM/DDR Controller required properties:
> +- compatible: Should be "atmel,at91sam9260-sdramc",
> +			"atmel,at91sam9g45-ddramc",
> +- reg: Should contain registers location and length
> +  For at91sam9263 and at91sam9g45 you must specify 2 entries.
> +
> +Examples:
> +
> +	ramc0: ramc at ffffe800 {
> +		compatible = "atmel,at91sam9g45-ddramc";
> +		reg = <0xffffe800 0x200>;
> +	};
> +
> +	ramc0: ramc at ffffe400 {
> +		compatible = "atmel,at91sam9g45-ddramc";
> +		reg = <0xffffe400 0x200
> +		       0xffffe600 0x200>;
> +	};
> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> index 5414347..573ac5a 100644
> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> @@ -59,6 +59,11 @@
>  				reg = <0xfffff000 0x200>;
>  			};
>  
> +			ramc0: ramc at ffffea00 {
> +				compatible = "atmel,at91sam9260-sdramc";
> +				reg = <0xffffea00 0x200>;
> +			};
> +
>  			pmc: pmc at fffffc00 {
>  				compatible = "atmel,at91rm9200-pmc";
>  				reg = <0xfffffc00 0x100>;
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index e2ccba5..6da07a9 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -60,6 +60,12 @@
>  				reg = <0xfffff000 0x200>;
>  			};
>  
> +			ramc0: ramc at ffffe400 {
> +				compatible = "atmel,at91sam9g45-ddramc";
> +				reg = <0xffffe400 0x200
> +				       0xffffe600 0x200>;
> +			};
> +
>  			pmc: pmc at fffffc00 {
>  				compatible = "atmel,at91rm9200-pmc";
>  				reg = <0xfffffc00 0x100>;
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 54e3030..09bc806 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -58,6 +58,11 @@
>  				reg = <0xfffff000 0x200>;
>  			};
>  
> +			ramc0: ramc at ffffe800 {
> +				compatible = "atmel,at91sam9g45-ddramc";
> +				reg = <0xffffe800 0x200>;
> +			};
> +
>  			pmc: pmc at fffffc00 {
>  				compatible = "atmel,at91rm9200-pmc";
>  				reg = <0xfffffc00 0x100>;
> diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
> index 0b82c34..b6831ee 100644
> --- a/arch/arm/mach-at91/at91sam9x5.c
> +++ b/arch/arm/mach-at91/at91sam9x5.c
> @@ -302,11 +302,6 @@ static void __init at91sam9x5_map_io(void)
>  	at91_init_sram(0, AT91SAM9X5_SRAM_BASE, AT91SAM9X5_SRAM_SIZE);
>  }
>  
> -static void __init at91sam9x5_ioremap_registers(void)
> -{
> -	at91_ioremap_ramc(0, AT91SAM9X5_BASE_DDRSDRC0, 512);
> -}
> -
>  void __init at91sam9x5_initialize(void)
>  {
>  	at91_extern_irq = (1 << AT91SAM9X5_ID_IRQ0);
> @@ -359,7 +354,6 @@ static unsigned int at91sam9x5_default_irq_priority[NR_AIC_IRQS] __initdata = {
>  struct at91_init_soc __initdata at91sam9x5_soc = {
>  	.map_io = at91sam9x5_map_io,
>  	.default_irq_priority = at91sam9x5_default_irq_priority,
> -	.ioremap_registers = at91sam9x5_ioremap_registers,
>  	.register_clocks = at91sam9x5_register_clocks,
>  	.init = at91sam9x5_initialize,
>  };
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9x5.h b/arch/arm/mach-at91/include/mach/at91sam9x5.h
> index a297a77..88e43d5 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9x5.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9x5.h
> @@ -55,11 +55,6 @@
>  #define AT91SAM9X5_BASE_USART2	0xf8024000
>  
>  /*
> - * System Peripherals
> - */
> -#define AT91SAM9X5_BASE_DDRSDRC0	0xffffe800
> -
> -/*
>   * Base addresses for early serial code (uncompress.h)
>   */
>  #define AT91_DBGU	AT91_BASE_DBGU0
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 3e48b59..f86450d 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -315,12 +315,33 @@ static void at91_dt_rstc(void)
>  	of_node_put(np);
>  }
>  
> +static struct of_device_id ramc_ids[] = {
> +	{ .compatible = "atmel,at91sam9260-sdramc" },
> +	{ .compatible = "atmel,at91sam9g45-ddramc" },
> +	{ /*sentinel*/ }
> +};
> +
> +static void at91_dt_ramc(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, ramc_ids);
> +	if (!np)
> +		panic("unable to find compatible ram conroller node in dtb\n");

You really can't boot if this fails? A WARN is better if it allows you
to boot until at least your console is actually up.

> +
> +	at91_ramc_base[0] = of_iomap(np, 0);
> +	if (!at91_ramc_base[0])
> +		panic("unable to map ramc[0] cpu registers\n");
> +	/* the controller may have 2 banks */
> +	at91_ramc_base[1] = of_iomap(np, 1);
> +
> +	of_node_put(np);
> +}
> +
>  void __init at91_dt_initialize(void)
>  {
>  	at91_dt_rstc();
> -
> -	/* temporary until have the ramc binding*/
> -	at91_boot_soc.ioremap_registers();
> +	at91_dt_ramc();
>  
>  	/* Init clock subsystem */
>  	at91_dt_clock_init();
