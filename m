From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 30 Nov 2009 00:49:17 +0100
Subject: [PATCH] [AT91] Add support for the Daricom C3-Ax03 board
In-Reply-To: <1259414048-23497-1-git-send-email-derkling@gmail.com>
References: <1259414048-23497-1-git-send-email-derkling@gmail.com>
Message-ID: <20091129234917.GB18841@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 2fd8843..8553ffa 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -231,6 +231,13 @@ config MACH_CPU9260
>  	  Select this if you are using a Eukrea Electromatique's
>  	  CPU9260 Board <http://www.eukrea.com/>
>  
> +config MACH_C3AX03
> +	bool "Daricom C3-Ax03 board"
> +	depends on ARCH_AT91SAM9260
no need of the depend please remove
> +	help
> +	  Select this if you are using the Daricom C3-Ax03 Ex Telemetry Device.
> +	  <http://www.daricom.it>
> +
>  endif
>  
>  # ----------------------------------------------------------
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index ada440a..4f74746 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_MACH_USB_A9260)	+= board-usb-a9260.o
>  obj-$(CONFIG_MACH_QIL_A9260)	+= board-qil-a9260.o
>  obj-$(CONFIG_MACH_AFEB9260)	+= board-afeb-9260v1.o
>  obj-$(CONFIG_MACH_CPU9260)	+= board-cpu9krea.o
> +obj-$(CONFIG_MACH_C3AX03)	+= board-c3ax03.o
>  
>  # AT91SAM9261 board-specific support
>  obj-$(CONFIG_MACH_AT91SAM9261EK) += board-sam9261ek.o
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index 07eb7b0..7af7ecd 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -183,8 +183,13 @@ void __init at91_add_device_eth(struct at91_eth_data *data)
>  		at91_set_B_periph(AT91_PIN_PA25, 0);	/* ERX2 */
>  		at91_set_B_periph(AT91_PIN_PA26, 0);	/* ERX3 */
>  		at91_set_B_periph(AT91_PIN_PA27, 0);	/* ERXCK */
> +#if defined(CONFIG_MACH_C3AX03)
please use mach_is
but anyway here it's better to update the at91_eth_data to handle it
> +		at91_set_B_periph(AT91_PIN_PA10, 0);	/* ETX2 */
> +		at91_set_B_periph(AT91_PIN_PA11, 0);	/* ETX3 */
> +#else
>  		at91_set_B_periph(AT91_PIN_PA23, 0);	/* ETX2 */
>  		at91_set_B_periph(AT91_PIN_PA24, 0);	/* ETX3 */
> +#endif
>  		at91_set_B_periph(AT91_PIN_PA22, 0);	/* ETXER */
>  	}
>  
> @@ -571,7 +576,11 @@ static struct platform_device at91sam9260_spi1_device = {
>  	.num_resources	= ARRAY_SIZE(spi1_resources),
>  };
>  
> +#if defined(CONFIG_MACH_C3AX03)
> +static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB3, AT91_PIN_PC18, AT91_PIN_PC19, AT91_PIN_PC20 };
> +#else
>  static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB3, AT91_PIN_PC5, AT91_PIN_PC4, AT91_PIN_PC3 };
> +#endif
here ditto we need to avoid board specific stuff in the cpu specific file

btw please check your patch with checkpatch.pl as your patch contains a lots
of whitesapce and other coding style issue

Best Regards,
J.
