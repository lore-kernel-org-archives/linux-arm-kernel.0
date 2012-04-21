From: dongas86@gmail.com (Dong Aisheng)
Date: Sun, 22 Apr 2012 00:47:13 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120421164713.GA3408@das-ThinkPad-X61>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 04:12:05PM +0800, Shawn Guo wrote:
> Add pinctrl support for Freescale MXS SoCs, i.MX23 and i.MX28.
> The driver supports device tree probe only.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
First, it seems i.MX23 and i.MX28 have the same situation as
other IMX families like i.MX6Q that they're all pin based
SoCs. Thus i think the correct thing to do now may be to
enhance pinctrl-imx core driver to support them all rather
than write a much similar one only for i.MX23 and i.MX28,
right?

>  .../bindings/pinctrl/fsl,mxs-pinctrl.txt           |  923 ++++++++++++++++++++
>  drivers/pinctrl/Kconfig                            |   15 +
>  drivers/pinctrl/Makefile                           |    3 +
>  drivers/pinctrl/pinctrl-imx23.c                    |  304 +++++++
>  drivers/pinctrl/pinctrl-imx28.c                    |  420 +++++++++
>  drivers/pinctrl/pinctrl-mxs.c                      |  508 +++++++++++
>  drivers/pinctrl/pinctrl-mxs.h                      |   91 ++
>  7 files changed, 2264 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
>  create mode 100644 drivers/pinctrl/pinctrl-imx23.c
>  create mode 100644 drivers/pinctrl/pinctrl-imx28.c
>  create mode 100644 drivers/pinctrl/pinctrl-mxs.c
>  create mode 100644 drivers/pinctrl/pinctrl-mxs.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
> new file mode 100644
> index 0000000..7dfd3cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
> @@ -0,0 +1,923 @@
> +* Freescale MXS Pin Controller
> +
> +The pins controlled by mxs pin controller are organized in banks, each bank
> +has 32 pins.  Each pin has 4 multiplexing functions, and generally, the 4th
> +function is GPIO.  The configuration on the pins includes drive strength,
> +voltage and pull-up.
> +
> +Required properties:
> +- compatible: "fsl,imx23-pinctrl" or "fsl,imx28-pinctrl"
> +- reg: Should contain the register physical address and length for the
> +  pin controller.
> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices, including the meaning of the
> +phrase "pin configuration node".
> +
[...]

> +The pin configuration nodes act as a container for an arbitrary number of
> +subnodes.  Each of these subnodes represents some desired configuration for
Do you allow sub nodes under pin configuration node?
I did not see it from the example.

> +a group of pins, and only affects those parameters that are explicitly listed.
> +In other words, a subnode that describes a drive strength parameter implies no
> +information pull-up. For this reason, even seemingly boolean values are
> +actually tristates in this binding: unspecified, off, or on. Unspecified is
> +represented as an absent property, and off/on are represented as integer
> +values 0 and 1.
> +
> +Those subnodes will fall into two categories.  One is to set up a group of
> +pins for a function, both mux selection and pin configurations.  For the same
> +function, all pin group nodes should use the same node name and be sorted
> +together in "reg" value.  And the other one is the pure pin configuration
> +node, which are used to configure some pins that need a different drive
> +strength, voltage or pull-up configurations from what specified in the pin
> +group node.
> +
That's indeed a limitation and raised by Sascha in my first pinctrl binding
that you need create a pure pin config node to reconfigure pins which needs
different setting in the same group.
After received some other people's suggestion, finally i remove this limitation
and allow each pin to set its pad config value in the same group.
See my pinctrl imx v2 driver patch and provide comment if you have different
option.
Basically i think we should try to get one unified binding method for all FSL
SoC families rather than find two if no big differences.

> +Required subnode-properties:
> +- fsl,pinmux-ids: An integer array.  Each integer in the array specify a pin
> +  with given mux function, with bank, pin and mux packed as below.
> +
> +    [15..12] : bank number
> +    [11..4]  : pin number
> +    [3..0]   : mux selection
> +
Can you use a simple id here and hide these information in driver?
Like:
MX28_PAD_GPMI_D00__GPMI_D0	0
MX28_PAD_GPMI_D01__GPMI_D1	1
MX28_PAD_GPMI_D02__GPMI_D2	2
MX28_PAD_GPMI_D03__GPMI_D3	3
MX28_PAD_GPMI_D04__GPMI_D4	4
...
I did it for pinctrl imx.

> +  For the pure pin configuration nodes, the mux selection packed in the
> +  integer takes no effect, which means the mux selection of the pins that
> +  need separate configuration will also have to be set up by group node.
> +  In other word, the pin group node should include all the pins for given
> +  function, regardless of whether separate pin configuration nodes are needed
> +  to configure some pins differently or not.
> +
Then we did some duplicated things.

> +  Valid values for these integers are listed below.
> +
> +- reg: Should be the index of the pin group nodes for same function.  This
> +  property is required only for pin group nodes, and should not be present
> +  in any pure pin configuration nodes.
> +
> +Optional subnode-properties:
> +- fsl,drive-strength: Integer.
> +    0: 4 mA
> +    1: 8 mA
> +    2: 12 mA
> +    3: 16 mA
> +- fsl,voltage: Integer.
> +    0: 1.8 V
> +    1: 3.3 V
> +- fsl,pull-up: Integer.
> +    0: Disable the internal pull-up
> +    1: Enable the internal pull-up
> +
You already use raw data for mux, i really don't think it helps too much
to not for config.

> +Examples:
> +
> +pinctrl at 80018000 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "fsl,imx28-pinctrl";
> +	reg = <0x80018000 2000>;
> +
> +	mmc0_4bit_pins_a: mmc0-4bit at 0 {
"mmc0-4bit" is more likely be a group,
but you use it as function name, right?

> +		reg = <0>;
> +		fsl,pinmux-ids = <
> +			0x2000 0x2010 0x2020 0x2030
> +			0x2080 0x2090 0x20a0>;
> +		fsl,drive-strength = <1>;
> +		fsl,voltage = <1>;
> +		fsl,pull-up = <1>;
> +	};
> +
> +	mmc0_4bit_pins_b: mmc0-4bit at 1 {
> +		reg = <1>;
> +		fsl,pinmux-ids = <
> +			0x2040 0x2050 0x2060 0x2070
> +			0x2080 0x2090 0x20a0>;
> +		fsl,drive-strength = <1>;
> +		fsl,voltage = <1>;
> +		fsl,pull-up = <1>;
> +	};
> +
> +	mmc0_cd_cfg: mmc0-cd-cfg {
> +		fsl,pinmux-ids = <0x2090>;
> +		fsl,drive-strength = <1>;
> +		fsl,voltage = <1>;
> +		fsl,pull-up = <0>;
> +	};
> +
> +	mmc0_sck_cfg: mmc0-sck-cfg {
> +		fsl,pinmux-ids = <0x20a0>;
> +		fsl,drive-strength = <2>;
> +		fsl,voltage = <1>;
> +		fsl,pull-up = <0>;
> +	};
> +};
> +
> +In this example, there are two pin groups mmc0_4bit_pins_a and mmc0_4bit_pins_b
> +for function mmc0-4bit.  These two groups of pins have the first 4 pins (data)
> +be different, and the last 3 pins (card-detect, command, clock) be same.  The
> +card-detect and clock pins require different pin configuration than the group.
> +
Supporting pin based config can get rid of the last two config nodes.

> +Valid values for i.MX28 pinmux-id:
> +
> +pinmux						id
> +------						--
> +MX28_PAD_GPMI_D00__GPMI_D0			0x0000
> +MX28_PAD_GPMI_D01__GPMI_D1			0x0010
> +MX28_PAD_GPMI_D02__GPMI_D2			0x0020
> +MX28_PAD_GPMI_D03__GPMI_D3			0x0030
> +MX28_PAD_GPMI_D04__GPMI_D4			0x0040
> +MX28_PAD_GPMI_D05__GPMI_D5			0x0050
> +MX28_PAD_GPMI_D06__GPMI_D6			0x0060
> +MX28_PAD_GPMI_D07__GPMI_D7			0x0070
[...]

Regards
Dong Aisheng
