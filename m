From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 18 Apr 2010 08:33:40 +0300
Subject: [spi-devel-general] [PATCH v3 0/2] spi: driver for Cirrus
	EP93xx SPI controller
In-Reply-To: <s2i56d259a01004171143m74b06d85yd1cbb38ef7ce778e@mail.gmail.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D710785@AUSP01VMBX24.collaborationhost.net>
	<20100417045913.GA19534@gw.healthdatacare.com>
	<s2i56d259a01004171143m74b06d85yd1cbb38ef7ce778e@mail.gmail.com>
Message-ID: <20100418053340.GD19534@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 17, 2010 at 07:43:23PM +0100, Martin Guy wrote:
> 
> There's a further strangeness when a board has a single SPI device not
> using any GPIO chip select. At present, clients seem to need to
> declare that they have 1 chip select and to provide an empty
> cs_control function that does nothing. For example:
> 
> static void null_cs_control(unsigned cs, unsigned value, void *data) {
>        /* Sim.One only has MMC card and no GPIO chip select logic */
> }
> 
> static struct ep93xx_spi_info simone_spi_info = {
>        .num_chipselect = 1,
>        .cs_control     = null_cs_control,
>        .data           = NULL,
> };
> ...
> static void __init simone_init_machine(void)
> {
> ...
>        spi_register_board_info(simone_spi_board_info,
> ARRAY_SIZE(simone_spi_board_info));
>        ep93xx_register_spi(&simone_spi_info);
> ...
> 
> Allowing cs_control to be NULL would do away with the empty function, but
> when I just tried with num_chipselect = 0 the device did not appear. There
> may be a better solution.

There is a check in spi_master_register() where num_chipselect should be at
least 1. This is probably why it failed in your case.

However, I can add check to the driver that NULL cs_control is ok.

Thanks,
MW
