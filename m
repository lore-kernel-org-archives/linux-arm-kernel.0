From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Nov 2012 12:33:04 +0100
Subject: [RFC] ARM: mx5: Replace clk_register_clkdev with clock DT lookup
In-Reply-To: <1353087415-10442-1-git-send-email-festevam@gmail.com>
References: <1353087415-10442-1-git-send-email-festevam@gmail.com>
Message-ID: <20121119113304.GV10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, Nov 16, 2012 at 03:36:55PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam fabio.estevam at freescale.com>
> 
> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> task for the clock devices easier.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

It's a good start. Thanks for working on this. However, before merging
this we should add all clocks for all devices to the devicetree, so also
the ones which have auxdata now:

static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst =
{
	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART1_BASE_ADDR, "imx21-uart.0", NULL),
	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART2_BASE_ADDR, "imx21-uart.1", NULL),
	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART3_BASE_ADDR, "imx21-uart.2", NULL),
	OF_DEV_AUXDATA("fsl,imx51-fec", MX51_FEC_BASE_ADDR, "imx27-fec.0", NULL),
	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx51.0", NULL),
	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx51.1", NULL),
	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx51.2", NULL),
	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC4_BASE_ADDR, "sdhci-esdhc-imx51.3", NULL),
	OF_DEV_AUXDATA("fsl,imx51-ecspi", MX51_ECSPI1_BASE_ADDR, "imx51-ecspi.0", NULL),
	OF_DEV_AUXDATA("fsl,imx51-ecspi", MX51_ECSPI2_BASE_ADDR, "imx51-ecspi.1", NULL),
	OF_DEV_AUXDATA("fsl,imx51-cspi", MX51_CSPI_BASE_ADDR, "imx35-cspi.0", NULL),
	OF_DEV_AUXDATA("fsl,imx51-i2c", MX51_I2C1_BASE_ADDR, "imx-i2c.0", NULL),
	OF_DEV_AUXDATA("fsl,imx51-i2c", MX51_I2C2_BASE_ADDR, "imx-i2c.1", NULL),
	OF_DEV_AUXDATA("fsl,imx51-sdma", MX51_SDMA_BASE_ADDR, "imx35-sdma", NULL),
	OF_DEV_AUXDATA("fsl,imx51-wdt", MX51_WDOG1_BASE_ADDR, "imx2-wdt.0", NULL),
	{ /* sentinel */ }
};

> +* Clock bindings for Freescale i.MX5
> +
> +Required properties:
> +- compatible: Should be "fsl,imx5-ccm"

The ccms on i.MX51 and i.MX53 differ, so compatible string should be
51/53 specific.

This also means that we either must have two different clock/id lists
or (imo better) only have a single one, but then we should add comments
to the clock/ids which are specific to one the the two SoCs only.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
