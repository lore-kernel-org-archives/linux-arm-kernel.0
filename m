From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 28 Oct 2013 06:17:41 -0500
Subject: [PATCH v6 2/8] pinctrl: imx27: imx27 pincontrol driver
In-Reply-To: <1382950843-26066-3-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
 <1382950843-26066-3-git-send-email-mpa@pengutronix.de>
Message-ID: <B923ADBC-0C66-45D0-B9FE-F1038F93B176@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 28, 2013, at 4:00 AM, Markus Pargmann wrote:

> imx27 pincontrol driver using the imx1 core driver. The DT bindings are
> similar to other imx pincontrol drivers.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> .../bindings/pinctrl/fsl,imx27-pinctrl.txt         |  89 ++++
> drivers/pinctrl/Kconfig                            |   8 +
> drivers/pinctrl/Makefile                           |   1 +
> drivers/pinctrl/pinctrl-imx27.c                    | 477 +++++++++++++++++++++
> 4 files changed, 575 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
> create mode 100644 drivers/pinctrl/pinctrl-imx27.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
> new file mode 100644
> index 0000000..32c81c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx27-pinctrl.txt
> @@ -0,0 +1,89 @@
> +* Freescale IMX27 IOMUX Controller
> +
> +Required properties:
> +- compatible: "fsl,imx27-iomuxc"
> +
> +The iomuxc driver node should define subnodes containing of pinctrl configuration subnodes.

Here would probably be a good point to reference "pinctrl/pinctrl-bindings.txt"

> +
> +Required properties for pin configuration node:
> +- fsl,pins: three integers array, represents a group of pins mux and config
> +  setting. The format is fsl,pins = <PIN MUX_ID CONFIG>.
> +
> +  PIN is an integer between 0 and 0xbf. imx27 has 6 ports with 32 configurable
> +  configurable pins each. PIN is PORT * 32 + PORT_PIN, PORT_PIN is the pin
> +  number on the specific port (between 0 and 31).

I might be coming late to this, so feel free to ignore if this has already been discussed.

Why not encode PORT in fsl,pins so it would be <PORT PORT_PIN MUX_ID CONFIG> ?

> +
> +  MUX_ID is
> +    function + (direction << 2) + (gpio_oconf << 4) + (gpio_iconfa << 8) + (gpio_iconfb << 10)
> +
> +    function:      0 - Primary function
> +                   1 - Alternate function
> +                   2 - GPIO
> +      Registers GIUS (GPIO In Use) and GPR (General Purpose Register)
> +
> +    direction:     0 - Input
> +                   1 - Output
> +      Register DDIR
> +
> +    gpio_oconf:    0 - A_IN
> +                   1 - B_IN
> +                   2 - C_IN
> +                   3 - Data Register

what does this mean?

> +      Registers OCR1 and OCR2
> +
> +    gpio_iconfa/b: 0 - GPIO_IN
> +                   1 - Interrupt Status Register
> +                   2 - 0
> +                   3 - 1

What does any of these option mean (especially 2 & 3)?

> +      Registers ICONFA1, ICONFA2, ICONFB1 and ICONFB2
> +
> +

Someone should be able to reasonable read this and determine how to set MUX_ID w/o having to reference the HW manual.

> +  CONFIG can be 0 or 1, meaning Pullup disable/enable.

just for clarity do:
    CONFIG: 0 - Pullup disabled
            1 - Pullup enabled

> +
> +
> +
> +
> +Example:
> +
> +iomuxc: iomuxc at 10015000 {
> +	compatible = "fsl,imx27-iomuxc";
> +	reg = <0x10015000 0x600>;
> +
> +	uart {
> +		pinctrl_uart1: uart-1 {
> +			fsl,pins = <
> +				0x8c 0x004 0x0 /* UART1_TXD__UART1_TXD */
> +				0x8d 0x000 0x0 /* UART1_RXD__UART1_RXD */
> +				0x8e 0x004 0x0 /* UART1_CTS__UART1_CTS */
> +				0x8f 0x000 0x0 /* UART1_RTS__UART1_RTS */
> +			>;
> +		};
> +
> +		...
> +	};
> +};
> +
> +
> +For convenience there are macros defined in imx27-pinfunc.h which provide PIN
> +and MUX_ID. They are structured as MX27_PAD_<Pad name>__<Signal name>. The names
> +are defined in the i.MX27 reference manual.


> +
> +The above example using macros:
> +
> +iomuxc: iomuxc at 10015000 {
> +	compatible = "fsl,imx27-iomuxc";
> +	reg = <0x10015000 0x600>;
> +
> +	uart {
> +		pinctrl_uart1: uart-1 {
> +			fsl,pins = <
> +				MX27_PAD_UART1_TXD__UART1_TXD 0x0
> +				MX27_PAD_UART1_RXD__UART1_RXD 0x0
> +				MX27_PAD_UART1_CTS__UART1_CTS 0x0
> +				MX27_PAD_UART1_RTS__UART1_RTS 0x0
> +			>;
> +		};
> +
> +		...
> +	};
> +};

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
