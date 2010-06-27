From: freddy2_es@yahoo.com (=?iso-8859-1?Q?Alfredo_Quesada_S=E1nchez?=)
Date: Sun, 27 Jun 2010 13:55:51 -0700 (PDT)
Subject: Using SPI in a kernel module
In-Reply-To: <4C27B013.4010400@softerra.com>
Message-ID: <189502.64100.qm@web33802.mail.mud.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a few compiled files in that directory (more preciselly is arch/arm/mach-at91), including:

- board-XXX.c (well, the name of the board)

MACHINE_START(AT91SAM9G45EKES, "Atmel AT91SAM9G45-EKES")
	/* Maintainer: Atmel */
	.phys_io	= AT91_BASE_SYS,
	.io_pg_offst	= (AT91_VA_BASE_SYS >> 18) & 0xfffc,
	.boot_params	= AT91_SDRAM_BASE + 0x100,
	.timer		= &at91sam926x_timer,
	.map_io		= ek_map_io,
	.init_irq	= ek_init_irq,
	.init_machine	= ek_board_init,
MACHINE_END

In this file there is:

/*
 * SPI devices.
 */
static struct spi_board_info ek_spi_devices[] = {
	{	/* DataFlash chip */
		.modalias	= "mtd_dataflash",
		.chip_select	= 0,
		.max_speed_hz	= 15 * 1000 * 1000,
		.bus_num	= 0,
	},
};

And in ek_board_init I can see a call to:

/* SPI */
at91_add_device_spi(ek_spi_devices, ARRAY_SIZE(ek_spi_devices));


This function is in at91sam9g45_devices.c (also compiled), also having:

static struct resource spi0_resources[] = {
	[0] = {
		.start	= AT91SAM9G45_BASE_SPI0,
		.end	= AT91SAM9G45_BASE_SPI0 + SZ_16K - 1,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= AT91SAM9G45_ID_SPI0,
		.end	= AT91SAM9G45_ID_SPI0,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device at91sam9g45_spi0_device = {
	.name		= "atmel_spi",
	.id		= 0,
	.dev		= {
				.dma_mask		= &spi_dmamask,
				.coherent_dma_mask	= DMA_BIT_MASK(32),
	},
	.resource	= spi0_resources,
	.num_resources	= ARRAY_SIZE(spi0_resources),
};

static const unsigned spi0_standard_cs[4] = { AT91_PIN_PB3, AT91_PIN_PB18, AT91_PIN_PB19, AT91_PIN_PD27 };

static struct resource spi1_resources[] = {
	[0] = {
		.start	= AT91SAM9G45_BASE_SPI1,
		.end	= AT91SAM9G45_BASE_SPI1 + SZ_16K - 1,
		.flags	= IORESOURCE_MEM,
	},
	[1] = {
		.start	= AT91SAM9G45_ID_SPI1,
		.end	= AT91SAM9G45_ID_SPI1,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device at91sam9g45_spi1_device = {
	.name		= "atmel_spi",
	.id		= 1,
	.dev		= {
				.dma_mask		= &spi_dmamask,
				.coherent_dma_mask	= DMA_BIT_MASK(32),
	},
	.resource	= spi1_resources,
	.num_resources	= ARRAY_SIZE(spi1_resources),
};

static const unsigned spi1_standard_cs[4] = { AT91_PIN_PB17, AT91_PIN_PD28, AT91_PIN_PD18, AT91_PIN_PD19 };

void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
{
	int i;
	unsigned long cs_pin;
	short enable_spi0 = 0;
	short enable_spi1 = 0;

	/* Choose SPI chip-selects */
	for (i = 0; i < nr_devices; i++) {
		if (devices[i].controller_data)
			cs_pin = (unsigned long) devices[i].controller_data;
		else if (devices[i].bus_num == 0)
			cs_pin = spi0_standard_cs[devices[i].chip_select];
		else
			cs_pin = spi1_standard_cs[devices[i].chip_select];

		if (devices[i].bus_num == 0)
			enable_spi0 = 1;
		else
			enable_spi1 = 1;

		/* enable chip-select pin */
		at91_set_gpio_output(cs_pin, 1);

		/* pass chip-select pin to driver */
		devices[i].controller_data = (void *) cs_pin;
	}

	spi_register_board_info(devices, nr_devices);

	/* Configure SPI bus(es) */
	if (enable_spi0) {
		at91_set_A_periph(AT91_PIN_PB0, 0);	/* SPI0_MISO */
		at91_set_A_periph(AT91_PIN_PB1, 0);	/* SPI0_MOSI */
		at91_set_A_periph(AT91_PIN_PB2, 0);	/* SPI0_SPCK */

		at91_clock_associate("spi0_clk", &at91sam9g45_spi0_device.dev, "spi_clk");
		platform_device_register(&at91sam9g45_spi0_device);
	}
	if (enable_spi1) {
		at91_set_A_periph(AT91_PIN_PB14, 0);	/* SPI1_MISO */
		at91_set_A_periph(AT91_PIN_PB15, 0);	/* SPI1_MOSI */
		at91_set_A_periph(AT91_PIN_PB16, 0);	/* SPI1_SPCK */

		at91_clock_associate("spi1_clk", &at91sam9g45_spi1_device.dev, "spi_clk");
		platform_device_register(&at91sam9g45_spi1_device);
	}
}

To summarize, in the end platform_device_register should be called for SPI 0 (as you can see the board has 2 SPI channels).


So.. assuming this is working as expected, when should i see a call to my driver's probe function? and.. which spi_device will be passed as parameter? (there is only 1 registered, but for this question let's assume that i have more spi devices registered).

Regards

> Hello
> How about specifying correct data (for your particular
> board) in the 
> machine-specific
> code?(arch/your_arch/mach-your_machine/your_machine.c)
> Basically it is enough for the system to invoke proper
> probes.
> Mikhail



      
