From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2012 08:29:21 +0000
Subject: [PATCH] gpio: Device tree support for LPC32xx
In-Reply-To: <1333407513-18231-1-git-send-email-stigge@antcom.de>
References: <1333407513-18231-1-git-send-email-stigge@antcom.de>
Message-ID: <201204030829.21911.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 April 2012, Roland Stigge wrote:
> This patch adds device tree support for gpio-lpc32xx.c
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Hi Roland,

I'm glad it worked. Some more comments:

> --- /dev/null
> +++ linux-2.6/Documentation/devicetree/bindings/gpio/gpio_lpc32xx.txt
> @@ -0,0 +1,71 @@
> +NXP LPC32xx SoC GPIO controller
> +
> +Required properties:
> +- compatible: "nxp,lpc32xx-gpio"
> +- reg: Physical base address and length of the controller's registers.
> +- #address-cells: For indexing of the subnodes (GPIO groups of the SoC)
> +- #size-cells: Always 0
> +- #gpio-cells: Should be two. The first cell is the pin number and the
> +  second cell is used to specify optional parameters:
> +  - bit 0 specifies polarity (0 for normal, 1 for inverted)

The description for #address-cells should mention that it's always <1>.
There should be no #gpio-cells in this node.

> +Required properties of sub-nodes which describe the GPIO groups of LPC32xx:
> +- gpio-controller: Marks the device node as a GPIO controller.
> +- #gpio-cells: Should be two. The first cell is the pin number and the
> +  second cell is used to specify optional parameters:
> +  - bit 0 specifies polarity (0 for normal, 1 for inverted)
> +- reg: Index of the GPIO group
> +- gpio-lines: Number of GPIOs in that subnode/GPIO group

While I suggested the gpio-lines property, I'm not sure if it's worth
including it when you don't actually use it.

You could add code to the probe function that sets the respective
fields in the gpio_chip structure, which would be particularly
interesting when you disable the unused banks by adding a
status="disabled" property (you already check for of_device_is_available()
in the loop). That will only work after all your gpio using code has
been converted to device tree probing, because it means the
hardcoded numbers don't work any more.

You can also let the user change that number if only the first X gpios
in one bank are actually used, or if some lpc32xx variants have fewer
gpio pins than others.

	Arnd
