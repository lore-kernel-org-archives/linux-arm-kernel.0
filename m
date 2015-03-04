From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 05 Mar 2015 00:21:47 +0100
Subject: [PATCH 1/6] ARM: at91: switch to multiplatform
In-Reply-To: <1425480446-31711-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425480446-31711-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425480446-31711-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425511307.2090.60.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre Belloni schreef op wo 04-03-2015 om 15:47 [+0100]:
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -1,51 +1,22 @@
> -if ARCH_AT91
> -
> -config HAVE_AT91_UTMI
> -	bool
> -
> -config HAVE_AT91_USB_CLK
> -	bool
> -
> -config COMMON_CLK_AT91
> -	bool
> -	select COMMON_CLK
> -
> -config HAVE_AT91_SMD
> -	bool
> -
> -config HAVE_AT91_H32MX
> -	bool
> -
> -config SOC_SAMA5
> -	bool
> -	select ATMEL_AIC5_IRQ
> +config ARCH_AT91
> +	select ARCH_REQUIRE_GPIOLIB
>  	select COMMON_CLK_AT91
> -	select CPU_V7
> +	select CLKDEV_LOOKUP
>  	select GENERIC_CLOCKEVENTS
> -	select MEMORY
> -	select ATMEL_SDRAMC
> -	select PHYLIB if NETDEVICES
> -
> -menu "Atmel AT91 System-on-Chip"
> -
> -choice
> -
> -	prompt "Core type"
> -
> -config SOC_SAM_V4_V5
> -	bool "ARM9 AT91SAM9/AT91RM9200"
> -	help
> -	  Select this if you are using one of Atmel's AT91SAM9 or
> -	  AT91RM9200 SoC.
> +	select IRQ_DOMAIN
> +	select NEED_MACH_IO_H if PCCARD
> +	select PINCTRL
> +	select PINCTRL_AT91
> +	select SOC_BUS
> +	select USE_OF
> +	bool

Utterly trivial, but anyhow. Could you please make this
    bool

line to be the line directly following the line reading
    config ARCH_AT91

above?

> -config SOC_SAM_V7
> -	bool "Cortex A5"
> +menuconfig SOC_SAM_V7
> +	bool "Atmel SAMA5" if ARCH_MULTI_V7
> +	select ARCH_AT91
>  	help
> -	  Select this if you are using one of Atmel's SAMA5D3 SoC.
> -
> -endchoice
> -
> -comment "Atmel AT91 Processor"
> +	  This enables support for systems based on Atmel
> +	  SAMA5D3 or SAMA5D4 SoCs.
>  
>  if SOC_SAM_V7
>  config SOC_SAMA5D3
> @@ -71,25 +42,29 @@ config SOC_SAMA5D4
>  	select HAVE_AT91_H32MX
>  	help
>  	  Select this if you are using one of Atmel's SAMA5D4 family SoC.
> -endif
> +endif # SOC_SAM_V7
> +
> +
> +menuconfig SOC_SAM_V4_V5
> +	bool "Atmel ARM9 AT91SAM9/AT91RM9200" if ARCH_MULTI_V4_V5
> +	select ARCH_AT91
> +	help
> +	  Select this if you are using one of Atmel's AT91SAM9 or
> +	  AT91RM9200 SoC.
>  
>  if SOC_SAM_V4_V5
>  config SOC_AT91RM9200
> -	bool "AT91RM9200"
> +	bool "AT91RM9200" if ARCH_MULTI_V4T
>  	select ATMEL_AIC_IRQ
> -	select COMMON_CLK_AT91
>  	select CPU_ARM920T
> -	select GENERIC_CLOCKEVENTS
>  	select HAVE_AT91_USB_CLK
>  	select MIGHT_HAVE_PCI
>  
>  config SOC_AT91SAM9
> -	bool "AT91SAM9"
> +	bool "AT91SAM9" if ARCH_MULTI_V5
>  	select ATMEL_AIC_IRQ
>  	select ATMEL_SDRAMC
> -	select COMMON_CLK_AT91
>  	select CPU_ARM926T
> -	select GENERIC_CLOCKEVENTS
>  	select HAVE_AT91_SMD
>  	select HAVE_AT91_USB_CLK
>  	select HAVE_AT91_UTMI
> @@ -115,6 +90,34 @@ config SOC_AT91SAM9
>  	    AT91SAM9XE
>  endif # SOC_SAM_V4_V5
>  
> +if ARCH_AT91
> +
> +config HAVE_AT91_UTMI
> +	bool
> +
> +config HAVE_AT91_USB_CLK
> +	bool
> +
> +config COMMON_CLK_AT91
> +	bool
> +	select COMMON_CLK
> +
> +config HAVE_AT91_SMD
> +	bool
> +
> +config HAVE_AT91_H32MX
> +	bool
> +
> +config SOC_SAMA5
> +	bool
> +	select ATMEL_AIC5_IRQ
> +	select CPU_V7
> +	select MEMORY
> +	select ATMEL_SDRAMC
> +	select PHYLIB if NETDEVICES
> +
> +menu "Atmel AT91 common options"
> +
>  comment "AT91 Feature Selections"
>  
>  config AT91_SLOW_CLOCK
> @@ -132,12 +135,12 @@ config AT91_SLOW_CLOCK
>  	  need to be completely re-initialized.
>  
>  config AT91_TIMER_HZ
> -       int "Kernel HZ (jiffies per second)"
> -       range 32 1024
> -       depends on ARCH_AT91
> -       default "128" if SOC_AT91RM9200
> -       default "100"
> -       help
> +	int "Kernel HZ (jiffies per second)"
> +	range 32 1024
> +	depends on ARCH_AT91
> +	default "128" if SOC_AT91RM9200
> +	default "100"
> +	help
>  	  On AT91rm9200 chips where you're using a system clock derived
>  	  from the 32768 Hz hardware clock, this tick rate should divide
>  	  it exactly: use a power-of-two value, such as 128 or 256, to

Thanks,


Paul Bolle
