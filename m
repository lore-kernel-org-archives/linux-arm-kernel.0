From: jakob@viketoft.se (Jakob Viketoft)
Date: Tue, 20 Apr 2010 13:58:40 +0200
Subject: SPI trouble on Colibri 270 (PXA)...
Message-ID: <4BCD96F0.5010506@viketoft.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

I've come to a dead end in finding out what's wrong with my SPI setup so 
I was hoping that someone here has some pointers to help me along. I'm 
trying to use an m25p80 SPI flash through the pxa2xx SPI controller 
(through SSP1), but read accesses go wrong (I haven't even tried writing 
yet). What happens is that after the pxa2xx writes the read command on 
the SPI bus, the chip is deselected - effectively terminating the read 
operation. Some 100 us afterwards the cs go low again and it seems as 
the read operation is continued (clock runs, no output data), but by 
then the chip has already terminated. Forcing the cs_change bit on each 
transfer doesn't seem to do any difference, there is still a pause 
between two transfers in the same message.

I haven't seen any other board using the same combination (the m25p80 
and the pxa2xx), but I'm still opting for an error on my part somewhere. 
I've attached my SPI configuration (board setup) in the end of the mail.

I'm ready for any suggestions at this point. Please CC me as I'm not on 
the list.

Regards,

	/Jakob

------------

/*
  *  linux/arch/arm/mach-pxa/colibri-pxa270-spi.c
  *
  *  Separate file for the Toradex Colibri 270 SPI definitions to avoid
  *  conflicts with the "regular" flash includes.
  *  Jakob Viketoft <info@bitsim.com>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */

#include <linux/mtd/mtd.h>
#include <linux/mtd/partitions.h>
#include <linux/mtd/physmap.h>
#include <linux/spi/spi.h>
#include <linux/spi/flash.h>
#include <mach/pxa2xx_spi.h>
#include <mach/mfp-pxa27x.h>
#include <mach/pxa2xx-regs.h>
#include <mach/gpio.h>

#include "generic.h"
#include "devices.h"

/* SPI interface on SSP1 */
static unsigned long colibri_spi_pin_config[] __initdata = {
	GPIO23_SSP1_SCLK,
	GPIO24_SSP1_SFRM,
	GPIO25_SSP1_TXD,
	GPIO26_SSP1_RXD,
};

static struct pxa2xx_spi_master colibri_spi_ssp1_info = {
	.clock_enable = CKEN_SSP1,
	.num_chipselect	= 1,
	.enable_dma = 0,
};

struct mtd_partition fpga_flash_partitions[] = {
	{
		.name		= "FPGA code",
		.size		= 0x00100000,
		.offset		= 0,
		.mask_flags	= 0,
//		.mask_flags	= MTD_WRITEABLE,
	},
};

static struct flash_platform_data colibri_spi_m25p80_info = {
	.type		= "m25p80",
	.name		= "fpga_flash",
	.parts		= fpga_flash_partitions,
	.nr_parts	= ARRAY_SIZE(fpga_flash_partitions),
};

static struct pxa2xx_spi_chip colibri_spi_m25p80_chip = {
	.rx_threshold = 1,
	.tx_threshold = 1,
	.gpio_cs = GPIO24_SSP1_SFRM,
};

static struct spi_board_info __initdata colibri_spi_devices[] = {
	{
		.modalias	= "m25p80",
		.max_speed_hz	= 1200000,
		.bus_num	= 1,
		.chip_select	= 0,
		.platform_data	= &colibri_spi_m25p80_info,
		.controller_data= &colibri_spi_m25p80_chip,
	},
  };

static int __init colibri_init_spi(void)
{
	printk(KERN_ERR "Init Colibri SPI\n");
	pxa2xx_mfp_config(ARRAY_AND_SIZE(colibri_spi_pin_config));
	pxa2xx_set_spi_info(1, &colibri_spi_ssp1_info);
	return spi_register_board_info(ARRAY_AND_SIZE(colibri_spi_devices));
}

subsys_initcall(colibri_init_spi);
