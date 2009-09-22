From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 22 Sep 2009 21:00:41 +0200
Subject: [PATCH 2/3] mfd: add U8500 STw4500 SPI device support
In-Reply-To: <1253572630.21542.46.camel@vinay-desktop>
References: <1253572630.21542.46.camel@vinay-desktop>
Message-ID: <20090922190041.GF30627@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04:07 Tue 22 Sep     , srinidhi kasagar wrote:
> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> 
> This adds core driver support for STw4500 mixed signal
> multimedia & power management chip. This connects to U8500
> on the SSP (pl022) bus operating in SPI protocol and exports
> read/write functions for the device to get access to this chip.
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> ---
>  drivers/mfd/Kconfig   |   10 ++++
>  drivers/mfd/Makefile  |    1 +
>  drivers/mfd/stw4500.c |  137 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+), 0 deletions(-)
>  create mode 100755 drivers/mfd/stw4500.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 491ac0f..e3aec52 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -256,6 +256,16 @@ config AB3100_CORE
>  	  LEDs, vibrator, system power and temperature, power management
>  	  and ALSA sound.
>  
> +config U8500_STW4500
> +	tristate "ST-Ericsson U8500 Mixed Signal Power management chip"
> +	depends on SPI
please put the depend on ARCH_U8500 here
> +	default y if ARCH_U8500
it will be better to select it at soc config not here
> +	help
> +	  Select this option to enable access to STw4500 power management
> +	  chip. This connects to U8500 on the SSP/SPI bus and exports
> +	  read/write functions for the devices to get access to this chip.
> +	  This chip embeds various other multimedia funtionalities as well.
> +
>  config EZX_PCAP
>  	bool "PCAP Support"
>  	depends on GENERIC_HARDIRQS && SPI_MASTER
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 6f8a9a1..9b15e52 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -44,3 +44,4 @@ obj-$(CONFIG_MFD_PCF50633)	+= pcf50633-core.o
>  obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
>  obj-$(CONFIG_PCF50633_GPIO)	+= pcf50633-gpio.o
>  obj-$(CONFIG_AB3100_CORE)	+= ab3100-core.o
> +obj-$(CONFIG_U8500_STW4500)	+= stw4500.o
> diff --git a/drivers/mfd/stw4500.c b/drivers/mfd/stw4500.c
> new file mode 100755
> index 0000000..a8c1d39
> --- /dev/null
> +++ b/drivers/mfd/stw4500.c
> @@ -0,0 +1,137 @@
> +/*
> + * Copyright (C) 2009 ST-Ericsson
> + *
> + * Author: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + *
> + * STw4500 is a companion power management chip used with U8500. On this
> + * platform, this is interfaced with SSP0 controller which is a ARM
> + * primecell pl022.
> + *
> + * At the moment the module just exports read/write features.
> + * Interrupt management to be added.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/spi/spi.h>
> +
> +static struct spi_driver stw4500_driver;
currently you support only one instance of the driver why?
also you do not add an header for those read/write why?
> +
> +struct stw4500_chip {
> +	struct spi_device	*spi;
> +	unsigned long		tx_buf[4];
> +	unsigned long		rx_buf[4];
> +};
> +
> +struct stw4500_chip *the_stw4500;
> +
> +/*
> + * This funtion writes to any STw4500 registers using SPI protocol &
> + * before it writes it packs the data in the below 24 bit frame format
> + *
> + *	 *|------------------------------------|
> + *	 *| 23|22...18|17.......10|9|8|7......0|
> + *	 *| r/w  bank       adr          data  |
> + *	 * ------------------------------------
> + *
> + * This function shouldn't be called from interrupt context
> + */
> +int stw4500_write(unsigned char block, unsigned long addr,
> +		unsigned char data)
> +{
you may need to add a spinlock to avoid concurent acess problem
> +	struct spi_transfer xfer;
> +	struct spi_message	msg;
> +	unsigned long spi_data =
> +		block << 18 | addr << 10 | data;
> +
> +	the_stw4500->tx_buf[0] = spi_data;
> +	the_stw4500->rx_buf[0] = 0;
> +
> +	xfer.tx_buf	= the_stw4500->tx_buf;
> +	xfer.rx_buf 	= NULL;
> +	xfer.len	= sizeof(unsigned long);
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	return spi_sync(the_stw4500->spi, &msg);
> +}
> +EXPORT_SYMBOL(stw4500_write);
> +
> +int stw4500_read(unsigned char block, unsigned long addr)
> +{
ditto here
> +	struct spi_transfer xfer;
> +	struct spi_message	msg;
> +	unsigned long spi_data =
> +		1 << 23 | block << 18 | addr << 10;
> +
> +	the_stw4500->tx_buf[0] = spi_data;
> +	the_stw4500->rx_buf[0] = 0;
> +
> +	xfer.tx_buf	= the_stw4500->tx_buf;
> +	xfer.rx_buf 	= the_stw4500->rx_buf;
> +	xfer.len	= sizeof(unsigned long);
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +
> +	spi_sync(the_stw4500->spi, &msg);
> +
> +	return  the_stw4500->rx_buf[0];
> +}
> +EXPORT_SYMBOL(stw4500_read);
> +
> +static int __init stw4500_probe(struct spi_device *spi)
> +{
> +	struct stw4500_chip	*chip;
> +	unsigned char revision;
> +
> +	chip = kzalloc(sizeof *chip, GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->spi = spi;
> +	spi_set_drvdata(spi, chip);
> +	the_stw4500 = chip;
> +
> +	/* read the revision register */
> +	revision = stw4500_read(0x10, 0x1080);
could you use macro here to describe what register you use
> +	printk(KERN_INFO "STw4500 PMU Initialized, revision = %x\n", revision);
is there any way to check if the companion work fine and that it's really a
STw4500 and in this case only return 0
> +
> +	return 0;
> +}
> +
> +static int __devexit stw4500_remove(struct spi_device *spi)
> +{
> +	struct stw4500_chip *chip =
> +		spi_get_drvdata(spi);
please add an empty line
put NULL in the_stw4500 will be good too
> +	kfree(chip);
> +
> +	return 0;
> +}
Best Regards,
J.
