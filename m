From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 15 Dec 2010 22:55:55 +0100
Subject: IMX SPI - 17-24 bit bug and >32 bit support.
In-Reply-To: <BLU0-SMTP23E8D9768DB476BFCE7B23B8140@phx.gbl>
References: <BLU0-SMTP23E8D9768DB476BFCE7B23B8140@phx.gbl>
Message-ID: <20101215215555.GF29833@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 04:33:54PM -0500, Bill Pringlemeir wrote:
> 
> Attach is an example patch to the spi_imx.c file.  The iMX spi doesn't
> handle 17-24bit values properly.  At least in sound/soc, the 24 bit
> values are being passed with three data bytes per unit.  Also the SPI
> count is being filled with '3' as a length.  Such data passed to the
> current iMX spi driver will cause it to loop forever as it decrements
> the unsigned length by '4' and eventually accesses invalid memory.
> 
> I believe that the reset of the kernel believes that the SPI layer
> should use three bytes per transfer/receive item if the SPI word
> length is 17 to 24 bits.

I remember soneone mentioned this already. Patches for this are welcome.

> 
> The other issue is that the current driver does not support SPI
> transfers of greater than 32bits (called 'BURST LENGTH' in iMX
> documentation).

The support for transfers > 32 bit is arguably broken at least on the
older cspi cores. That's why the we have the following comment next to
the spi platform data:

/*
 * struct spi_imx_master - device.platform_data for SPI controller devices.
 * @chipselect: Array of chipselects for this master. Numbers >= 0 mean gpio
 *              pins, numbers < 0 mean internal CSPI chipselects according
 *              to MXC_SPI_CS(). Normally you want to use gpio based chip
 *              selects as the CSPI module tries to be intelligent about
 *              when to assert the chipselect: The CSPI module deasserts the
 *              chipselect once it runs out of input data. The other problem
 *              is that it is not possible to mix between high active and low
 *              active chipselects on one single bus using the internal
 *              chipselects. Unfortunately Freescale decided to put some
 *              chipselects on dedicated pins which are not usable as gpios,
 *              so we have to support the internal chipselects.
 * @num_chipselect: ARRAY_SIZE(chipselect)
 */

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
