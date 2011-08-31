From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 31 Aug 2011 17:13:24 +0200
Subject: [PATCH 2/2] at91: USB-A9G20 C01 & C11 board support
In-Reply-To: <1314721553-3283-2-git-send-email-plagnioj@jcrosoft.com>
References: <1314281314-28912-1-git-send-email-nicolas.ferre@atmel.com>
	<1314721553-3283-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4E5E4F94.8040908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/08/2011 18:25, Jean-Christophe PLAGNIOL-VILLARD :
> http://www.calao-systems.com

Well, it is a bit short. Before submitting to at91-l2, I rephrase it to:
"Add support for Calao USB-A9G20 boards. It will be integrated in
existing support for board of same form factor using at91sam9260 or
at91sam9263."

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  arch/arm/mach-at91/Kconfig              |    8 ++
>  arch/arm/mach-at91/Makefile             |    1 +
>  arch/arm/mach-at91/board-usb-a926x.c    |  145 +++++++++++++++++++++++++------
>  arch/arm/mach-at91/include/mach/timex.h |    5 +
>  4 files changed, 133 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 2248467..e27d160 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -381,6 +381,14 @@ config MACH_GSIA18S
>  	  This enables support for the GS_IA18_S board
>  	  produced by GeoSIG Ltd company. This is an internet accelerograph.
>  	  <http://www.geosig.com>
> +
> +config MACH_USB_A9G20
> +	bool "CALAO USB-A9G20"
> +	depends on ARCH_AT91SAM9G20
> +	help
> +	  Select this if you are using a Calao Systems USB-A9G20.
> +	  <http://www.calao-systems.com>
> +
>  endif
>  
>  if (ARCH_AT91SAM9260 || ARCH_AT91SAM9G20)
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index adcb9a0..ff8a283 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_MACH_STAMP9G20)	+= board-stamp9g20.o
>  obj-$(CONFIG_MACH_PORTUXG20)	+= board-stamp9g20.o
>  obj-$(CONFIG_MACH_PCONTROL_G20)	+= board-pcontrol-g20.o board-stamp9g20.o
>  obj-$(CONFIG_MACH_GSIA18S)	+= board-gsia18s.o board-stamp9g20.o
> +obj-$(CONFIG_MACH_USB_A9G20)	+= board-usb-a926x.o
>  
>  # AT91SAM9260/AT91SAM9G20 board-specific support
>  obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
> diff --git a/arch/arm/mach-at91/board-usb-a926x.c b/arch/arm/mach-at91/board-usb-a926x.c
> index b9b9847..260260b 100644
> --- a/arch/arm/mach-at91/board-usb-a926x.c
> +++ b/arch/arm/mach-at91/board-usb-a926x.c
> @@ -4,6 +4,7 @@
>   *  Copyright (C) 2005 SAN People
>   *  Copyright (C) 2007 Atmel Corporation.
>   *  Copyright (C) 2007 Calao-systems
> + *  Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -28,6 +29,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/input.h>
> +#include <linux/spi/mmc_spi.h>
>  
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
> @@ -74,18 +76,42 @@ static struct at91_udc_data __initdata ek_udc_data = {
>  	.pullup_pin	= 0,		/* pull-up driven by UDC */
>  };
>  
> -void ek_add_device_udc(void)
> +static void __init ek_add_device_udc(void)
>  {
> -	if (machine_is_usb_a9260())
> +	if (machine_is_usb_a9260() || machine_is_usb_a9g20())
>  		ek_udc_data.vbus_pin = AT91_PIN_PC5;
>  
>  	at91_add_device_udc(&ek_udc_data);
>  }
>  
> +#if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
> +#define MMC_SPI_CARD_DETECT_INT AT91_PIN_PC4
> +static int at91_mmc_spi_init(struct device *dev,
> +	irqreturn_t (*detect_int)(int, void *), void *data)
> +{
> +	/* Configure Interrupt pin as input, no pull-up */
> +	at91_set_gpio_input(MMC_SPI_CARD_DETECT_INT, 0);
> +	return request_irq(gpio_to_irq(MMC_SPI_CARD_DETECT_INT), detect_int,
> +		IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +		"mmc-spi-detect", data);
> +}
> +
> +static void at91_mmc_spi_exit(struct device *dev, void *data)
> +{
> +	free_irq(gpio_to_irq(MMC_SPI_CARD_DETECT_INT), data);
> +}
> +
> +static struct mmc_spi_platform_data at91_mmc_spi_pdata = {
> +	.init = at91_mmc_spi_init,
> +	.exit = at91_mmc_spi_exit,
> +	.detect_delay = 100, /* msecs */
> +};
> +#endif
> +
>  /*
>   * SPI devices.
>   */
> -static struct spi_board_info ek_spi_devices[] = {
> +static struct spi_board_info usb_a9263_spi_devices[] = {
>  #if !defined(CONFIG_MMC_AT91)
>  	{	/* DataFlash chip */
>  		.modalias	= "mtd_dataflash",
> @@ -96,10 +122,25 @@ static struct spi_board_info ek_spi_devices[] = {
>  #endif
>  };
>  
> -void ek_add_device_spi(void)
> +static struct spi_board_info usb_a9g20_spi_devices[] = {
> +#if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
> +	{
> +		.modalias = "mmc_spi",
> +		.max_speed_hz = 20000000,	/* max spi clock (SCK) speed in HZ */
> +		.bus_num = 1,
> +		.chip_select = 0,
> +		.platform_data = &at91_mmc_spi_pdata,
> +		.mode = SPI_MODE_3,
> +	},
> +#endif
> +};
> +
> +static void __init ek_add_device_spi(void)
>  {
>  	if (machine_is_usb_a9263())
> -		at91_add_device_spi(ek_spi_devices, ARRAY_SIZE(ek_spi_devices));
> +		at91_add_device_spi(usb_a9263_spi_devices, ARRAY_SIZE(usb_a9263_spi_devices));
> +	else if (machine_is_usb_a9g20())
> +		at91_add_device_spi(usb_a9g20_spi_devices, ARRAY_SIZE(usb_a9g20_spi_devices));
>  }
>  
>  /*
> @@ -110,9 +151,9 @@ static struct at91_eth_data __initdata ek_macb_data = {
>  	.is_rmii	= 1,
>  };
>  
> -void ek_add_device_eth(void)
> +static void __init ek_add_device_eth(void)
>  {
> -	if (machine_is_usb_a9260())
> +	if (machine_is_usb_a9260() || machine_is_usb_a9g20())
>  		ek_macb_data.phy_irq_pin = AT91_PIN_PA31;
>  
>  	at91_add_device_eth(&ek_macb_data);
> @@ -123,19 +164,29 @@ void ek_add_device_eth(void)
>   */
>  static struct mtd_partition __initdata ek_nand_partition[] = {
>  	{
> -		.name	= "Uboot & Kernel",
> +		.name	= "barebox",
>  		.offset	= 0,
> -		.size	= SZ_16M,
> -	},
> -	{
> -		.name	= "Root FS",
> +		.size	= 3 * SZ_128K,
> +	}, {
> +		.name	= "bareboxenv",
>  		.offset	= MTDPART_OFS_NXTBLK,
> -		.size	= 120 * SZ_1M,
> -	},
> -	{
> -		.name	= "FS",
> +		.size	= SZ_128K,
> +	}, {
> +		.name	= "bareboxenv2",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= SZ_128K,
> +	}, {
> +		.name	= "kernel",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= 4 * SZ_1M,
> +	}, {
> +		.name	= "rootfs",
>  		.offset	= MTDPART_OFS_NXTBLK,
>  		.size	= 120 * SZ_1M,
> +	}, {
> +		.name	= "data",
> +		.offset	= MTDPART_OFS_NXTBLK,
> +		.size	= MTDPART_SIZ_FULL,
>  	}
>  };
>  
> @@ -154,7 +205,7 @@ static struct atmel_nand_data __initdata ek_nand_data = {
>  	.partition_info	= nand_partitions,
>  };
>  
> -static struct sam9_smc_config __initdata ek_nand_smc_config = {
> +static struct sam9_smc_config __initdata usb_a9260_nand_smc_config = {
>  	.ncs_read_setup		= 0,
>  	.nrd_setup		= 1,
>  	.ncs_write_setup	= 0,
> @@ -172,15 +223,36 @@ static struct sam9_smc_config __initdata ek_nand_smc_config = {
>  	.tdf_cycles		= 2,
>  };
>  
> +static struct sam9_smc_config __initdata usb_a9g20_nand_smc_config = {
> +	.ncs_read_setup		= 0,
> +	.nrd_setup		= 2,
> +	.ncs_write_setup	= 0,
> +	.nwe_setup		= 2,
> +
> +	.ncs_read_pulse		= 4,
> +	.nrd_pulse		= 4,
> +	.ncs_write_pulse	= 4,
> +	.nwe_pulse		= 4,
> +
> +	.read_cycle		= 7,
> +	.write_cycle		= 7,
> +
> +	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8,
> +	.tdf_cycles		= 3,
> +};
> +
>  static void __init ek_add_device_nand(void)
>  {
> -	if (machine_is_usb_a9260()) {
> +	if (machine_is_usb_a9260() || machine_is_usb_a9g20()) {
>  		ek_nand_data.rdy_pin	= AT91_PIN_PC13;
>  		ek_nand_data.enable_pin	= AT91_PIN_PC14;
>  	}
>  
>  	/* configure chip-select 3 (NAND) */
> -	sam9_smc_configure(3, &ek_nand_smc_config);
> +	if (machine_is_usb_a9g20())
> +		sam9_smc_configure(3, &usb_a9g20_nand_smc_config);
> +	else
> +		sam9_smc_configure(3, &usb_a9260_nand_smc_config);
>  
>  	at91_add_device_nand(&ek_nand_data);
>  }
> @@ -237,15 +309,20 @@ static struct gpio_led ek_leds[] = {
>  	}
>  };
>  
> -void ek_add_device_leds(void)
> +static struct i2c_board_info __initdata ek_i2c_devices[] = {
> +	{
> +		I2C_BOARD_INFO("rv3029c2", 0x56),
> +	},
> +};
> +
> +static void __init ek_add_device_leds(void)
>  {
> -	if (machine_is_usb_a9260())
> +	if (machine_is_usb_a9260() || machine_is_usb_a9g20())
>  		ek_leds[0].active_low = 0;
>  
>  	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
>  }
>  
> -
>  static void __init ek_board_init(void)
>  {
>  	/* Serial */
> @@ -260,15 +337,22 @@ static void __init ek_board_init(void)
>  	ek_add_device_eth();
>  	/* NAND */
>  	ek_add_device_nand();
> -	/* I2C */
> -	at91_add_device_i2c(NULL, 0);
>  	/* Push Buttons */
>  	ek_add_device_buttons();
>  	/* LEDs */
>  	ek_add_device_leds();
> -	/* shutdown controller, wakeup button (5 msec low) */
> -	at91_sys_write(AT91_SHDW_MR, AT91_SHDW_CPTWK0_(10) | AT91_SHDW_WKMODE0_LOW
> +
> +	if (machine_is_usb_a9g20()) {
> +		/* I2C */
> +		at91_add_device_i2c(ek_i2c_devices, ARRAY_SIZE(ek_i2c_devices));
> +	} else {
> +		/* I2C */
> +		at91_add_device_i2c(NULL, 0);
> +		/* shutdown controller, wakeup button (5 msec low) */
> +		at91_sys_write(AT91_SHDW_MR, AT91_SHDW_CPTWK0_(10)
> +				| AT91_SHDW_WKMODE0_LOW
>  				| AT91_SHDW_RTTWKEN);
> +	}
>  }
>  
>  MACHINE_START(USB_A9263, "CALAO USB_A9263")
> @@ -288,3 +372,12 @@ MACHINE_START(USB_A9260, "CALAO USB_A9260")
>  	.init_irq	= at91_init_irq_default,
>  	.init_machine	= ek_board_init,
>  MACHINE_END
> +
> +MACHINE_START(USB_A9G20, "CALAO USB_A92G0")
> +	/* Maintainer: Jean-Christophe PLAGNIOL-VILLARD */
> +	.timer		= &at91sam926x_timer,
> +	.map_io		= at91_map_io,
> +	.init_early	= ek_init_early,
> +	.init_irq	= at91_init_irq_default,
> +	.init_machine	= ek_board_init,
> +MACHINE_END
> diff --git a/arch/arm/mach-at91/include/mach/timex.h b/arch/arm/mach-at91/include/mach/timex.h
> index 31ac2d9..85820ad 100644
> --- a/arch/arm/mach-at91/include/mach/timex.h
> +++ b/arch/arm/mach-at91/include/mach/timex.h
> @@ -64,7 +64,12 @@
>  
>  #elif defined(CONFIG_ARCH_AT91SAM9G20)
>  
> +#if defined(CONFIG_MACH_USB_A9G20)
> +#define AT91SAM9_MASTER_CLOCK	133000000
> +#else
>  #define AT91SAM9_MASTER_CLOCK	132096000
> +#endif
> +
>  #define CLOCK_TICK_RATE		(AT91SAM9_MASTER_CLOCK/16)
>  
>  #elif defined(CONFIG_ARCH_AT91SAM9G45)


-- 
Nicolas Ferre
