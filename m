From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Jul 2014 13:14 +0200
Subject: [PATCH v2 1/3] usb: host: st-hcd: Add USB HCD support for STi SoCs
In-Reply-To: <1406199616-10533-2-git-send-email-peter.griffin@linaro.org>
References: <1406199616-10533-1-git-send-email-peter.griffin@linaro.org>
 <1406199616-10533-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <11018717.Ey5qEJxGNJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 July 2014 12:00:14 Peter Griffin wrote:
> This driver adds support for the USB HCD present in STi
> SoC's from STMicroelectronics. It has been tested on the
> stih416-b2020 board.

Unfortunately, this seems to be done in a rather strange way,
I suspect you'll have to start over, but I'll let Alan and Greg
weigh in.

> +
> +struct st_hcd_dev {
> +	int port_nr;
> +	struct platform_device *ehci_device;
> +	struct platform_device *ohci_device;
> +	struct clk *ic_clk;
> +	struct clk *ohci_clk;
> +	struct reset_control *pwr;
> +	struct reset_control *rst;
> +	struct phy *phy;
> +};

The way you do this apparently is to create a device that encapsulates
the OHCI and the EHCI and then goes on to create child devices that
are bound to the real drivers.

The way it should be done however is to put the two host controllers
into DT directly and describe their resources (phy, clock, reset, ...)
using the DT bindings for those.

Depending on what kind of special requirements the ST version has,
this can be done either by using the generic ohci/ehci bindings
with extensions where necessary, or by creating a new binding and
new driver files that use 'ohci_init_driver'/'ehci_init_driver'
to inherit from the common code.

The first of the two approaches is preferred.

> +	pdev->dev.parent = &parent->dev;
> +	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> +	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);

This is something we shouldn't ever do these days, the DMA settings
should come directly from DT without driver interaction.

	Arnd
