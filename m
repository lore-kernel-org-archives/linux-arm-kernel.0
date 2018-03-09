From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Mar 2018 11:46:10 +0800
Subject: [PATCH v4 1/2] Doc: dt: binding: imx: update pinctrl doc for
 imx6sll
In-Reply-To: <1520503083-22819-1-git-send-email-ping.bai@nxp.com>
References: <1520503083-22819-1-git-send-email-ping.bai@nxp.com>
Message-ID: <20180309034609.GI3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 05:58:02PM +0800, Bai Ping wrote:
> Add pinctrl binding doc update for imx6sll.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  changes v2-v3:
>  - add generic config binding
> 
>  change v3->v4:
>  - add SION bit define
>  - fix typo
>  - move the pin header file to dts patch.
> ---
>  .../bindings/pinctrl/fsl,imx6sll-pinctrl.txt       | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
> new file mode 100644
> index 0000000..b830a86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx6sll-pinctrl.txt
> @@ -0,0 +1,71 @@
> +* Freescale i.MX6 SLL IOMUX Controller
> +
> +Please refer to the pinctrl-bindings.txt in this directory for generic pinctrl binding.
> +
> +=== Pin Controller Node ===
> +
> +Required properties:
> +- compatible: "fsl,imx6sll-iomuxc"
> +- reg: Should contain the base physical address and size of the iomuxc registers.
> +
> +
> +=== Pin Configuration Node ===
> +- pinmux: One integers array, represents a group of pins mux setting.
> +	The format is pinmux = <PIN_FUNC_ID>, PIN_FUNC_ID is a pin working on
> +	a specific function. which can be found in imx6sll-pinfunc.h under device
> +	tree source folder. Please also refer to i.MX6SLL Reference Manual for detailed
> +	CONFIG settings.
> +
> +Optional Properties:
> +- drive-strength		Integer. Controls Drive Strength
> +					0: HI-Z
> +					1: 260 ohm at 3.3v, 150 ohm at 1.8v
> +					2: 130 ohm at 3.3v, 75 ohm at 1.8v
> +					3: 86 ohm at 3.3v, 50 ohm at 1.8v
> +					4: 65 ohm at 3.3v, 37 ohm at 1.8v
> +					5: 52 ohm at 3.3v, 30 ohm at 1.8v
> +					6: 43 ohm at 3.3v, 25 ohm at 1.8v
> +					7: 37 ohm at 3.3v, 21 ohm at 1.8v
> +- drive-open-drain		Bool. Enable Pin Open-drian
> +- slew-rate:			Integer. Controls Slew Rate
> +					0: slow
> +					1: fast
> +- fsl,pin-speed:		Integer, Controls the pin speed
> +					0: reserverd
> +					1: low(50 MHz)
> +					2: medium(100 MHz)
> +					3: maximum(200 MHz)

...

> +
> +- bias-pull-down:		Integer. Pull down on pin
> +					0: 100K ohm pull down
> +- bias-pull-up:			Integer. Pull up on pin
> +					1: 47K ohm pull up
> +					2: 100K ohm pull up
> +					3: 22K ohm pull up
> +- input-schmitt-enable:		bool, Schmitt trigger input enable
> +- input-enable			bool, Software input on enbale
> +- fsl,low-voltage-enable:	Integer. low voltage enable
> +					0: High voltage
> +					1: Low voltage

As discussed in Lucas' i.MX8QM pinctrl patches, majority of i.MX folks
agreed that i.MX pin configuration has too many specialities, and it's
not worth to switch to the generic pinconf bindings.

Shawn

> +Examples:
> +#include "imx6sll-pinfunc.h"
> +
> +/* Pin Controller Node */
> +
> +iomuxc: iomuxc at 020e0000 {
> +		compatible = "fsl,imx6sll-iomuxc";
> +		reg = <0x020e0000 0x4000>;
> +
> +	/* Pin configuration Node */
> +	pinctrl_uart1: uart1grp {
> +		pinmux = <
> +			MX6SLL_PAD_UART1_TXD__UART1_DCE_TX
> +			MX6SLL_PAD_UART1_RXD__UART1_DCE_RX
> +		>;
> +		slew-rate = <0x1>;
> +		drive-strength = <0x6>;
> +		fsl,pin-speed = <0x2>;
> +		bias-pull-up = <0x2>;
> +		input-schmitt-enable;
> +	};
> +};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
