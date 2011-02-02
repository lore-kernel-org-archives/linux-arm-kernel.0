From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 2 Feb 2011 12:18:59 -0600
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
In-Reply-To: <1296653211.1504.40.camel@r60e>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
	<20110202125327.GO12743@opensource.wolfsonmicro.com>
	<1296653211.1504.40.camel@r60e>
Message-ID: <0D753D10438DA54287A00B027084269764CEFD4802@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 02, 2011 6:27 AM, Alexander Sverdlin wrote:
> I think we can leave reset management in CODEC (as it will be almost the
> same for all platforms), leave enable pin management in CODEC unused,
> but attach enable GPIO to spi_board_info in platform to enable other SPI
> devices on bus.
> 
> Hartley, in this case we cannot use existing cs4271_platform_data and
> have to leave long if-else statemens as is. Would it be ok?

Alexander,

Below is what I propose for the platform init code.  This assumes that the
reset gpio will still be handled by the codec since it's related to power
management.

Regards,
Hartley



static struct cs4271_platform_data edb93xx_cs4271_data = {
	.gpio_nreset		= -EINVAL,	/* filled in later */
};

static int edb93xx_cs4271_hw_setup(struct spi_device *spi)
{
	return gpio_request_one(EP93XX_GPIO_LINE_EGPIO6,
				GPIOF_OUT_INIT_HIGH, spi->modalias);
}

static void edb93xx_cs4271_hw_cleanup(struct spi_device *spi)
{
	gpio_free(EP93XX_GPIO_LINE_EGPIO6);
}

static void edb93xx_cs4271_hw_cs_control(struct spi_device *spi, int value)
{
	gpio_set_value(EP93XX_GPIO_LINE_EGPIO6, value);
}

static struct ep93xx_spi_chip_ops edb93xx_cs4721_hw  = {
	.setup		= edb93xx_cs4271_hw_setup,
	.cleanup	= edb93xx_cs4271_hw_cleanup,
	.cs_control	= edb93xx_cs4271_hw_cs_control,
};

static struct spi_board_info edb93xx_spi_board_info[] __initdata = {
	{
		.modalias		= "cs4271",
		.platform_data		= &edb93xx_cs4271_data,
		.controller_data	= &edb93xx_cs4721_hw,
		.max_speed_hz		= 6000000,
		.bus_num		= 0,
		.chip_select		= 0,
		.mode			= SPI_MODE_3,
	},
};

static struct ep93xx_spi_info edb93xx_spi_master __initdata = {
	.num_chipselect		= ARRAY_SIZE(edb93xx_spi_board_info),
};

static void __init edb93xx_register_spi(void)
{
	if (machine_is_edb9301() || machine_is_edb9302()) {
		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO1;
	} else if (machine_is_edb9302a() || machine_is_edb9307a()) {
		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_H(2);
	} else if (machine_is_edb9315a()) {
		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO14;
	}

	ep93xx_register_spi(&edb93xx_spi_master,
			    edb93xx_spi_board_info,
			    ARRAY_SIZE(edb93xx_spi_board_info));
}
