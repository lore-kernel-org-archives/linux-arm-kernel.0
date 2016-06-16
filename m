From: stefan@agner.ch (Stefan Agner)
Date: Wed, 15 Jun 2016 22:37:42 -0700
Subject: [PATCH 3/3] ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D
 support
In-Reply-To: <20160612023100.GW20243@tiger>
References: <20160608023709.32090-1-stefan@agner.ch>
 <20160608023709.32090-4-stefan@agner.ch> <20160612023100.GW20243@tiger>
Message-ID: <59f88a185c67034087f3eabf88da6c8c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-06-11 19:31, Shawn Guo wrote:
> On Tue, Jun 07, 2016 at 07:37:09PM -0700, Stefan Agner wrote:
>> +&lcdif {
>> +	status = "okay";
>> +	display = <&display0>;
> 
> Please put 'status' at the bottom of property list.
> 
>> +
>> +	display0: lcd-display {
>> +		bits-per-pixel = <16>;
>> +		bus-width = <18>;
>> +
>> +		display-timings {
>> +			native-mode = <&timing_vga>;
>> +
>> +			/* Standard VGA timing */
>> +			timing_vga: 640x480 {
>> +				clock-frequency = <25175000>;
>> +				hactive = <640>;
>> +				vactive = <480>;
>> +				hback-porch = <40>;
>> +				hfront-porch = <24>;
>> +				vback-porch = <32>;
>> +				vfront-porch = <11>;
>> +				hsync-len = <96>;
>> +				vsync-len = <2>;
>> +				de-active = <1>;
>> +				hsync-active = <0>;
>> +				vsync-active = <0>;
>> +				pixelclk-active = <0>;
>> +			};
>> +		};
>> +	};
>> +};
> 
> <snip>
> 
>> +&usdhc1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
>> +	no-1-8-v;
>> +	cd-gpios = <&gpio1 0 0>;
> 
> Use the macro in include/dt-bindings/gpio/gpio.h.
> 
>> +	enable-sdio-wakeup;
> 
> This is deprecated.  Please use wakeup-source instead.
> 
>> +	fsl,tuning-step = <2>;
>> +	keep-power-in-suspend;
>> +	status = "okay";
>> +};
> 
> <snip>
> 
>> +&fec1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_enet1>;
>> +	clocks = <&clks IMX7D_ENET_AXI_ROOT_CLK>,
>> +		<&clks IMX7D_ENET_AXI_ROOT_CLK>,
>> +		<&clks IMX7D_ENET1_TIME_ROOT_CLK>,
>> +		<&clks IMX7D_PLL_ENET_MAIN_50M_CLK>;
>> +	clock-names = "ipg", "ahb", "ptp", "enet_clk_ref";
>> +
> 
> Drop this newline.
> 
>> +	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
>> +			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
>> +	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
>> +	assigned-clock-rates = <0>, <100000000>;
>> +	phy-mode = "rmii";
>> +	phy-supply = <&reg_LDO1>;
>> +	fsl,magic-packet;
>> +};
> 
> <snip>
> 
>> +&uart1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart1 &pinctrl_uart1_ctrl1 &pinctrl_uart1_ctrl2>;
>> +	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
>> +	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
>> +	fsl,uart-has-rtscts;
> 
> Please use generic 'uart-has-rtscts' instead.
> 
>> +	fsl,dte-mode;
>> +};
>> +
>> +&uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart2>;
>> +	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
>> +	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
>> +	fsl,uart-has-rtscts;
> 
> Ditto
> 
>> +	fsl,dte-mode;
>> +};

Agreed on all the stuff above.

> 
> <snip>
> 
>> +/ {
>> +	model = "Toradex Colibri iMX7D on Colibri Evaluation Board V3";
>> +	compatible = "toradex,colibri_imx7d-eval", "toradex,colibri_imx7d", \
> 
> We always use hyphen than underscore in compatible string.

We always used underscores, this goes back to the first Colibri specific
device tree: tegra20-iris-512.dts.

I would rather prefer to not change this for the sake of consistency...
What do you think?

> 
>> +		     "fsl,imx7d";
>> +
>> +	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_usbotg2_reg>;
>> +		regulator-name = "VCC_USB[1-4]";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		gpio = <&gpio4 7 GPIO_ACTIVE_LOW>;
>> +	};
>> +};
>> +/ {
>> +	model = "Toradex Colibri iMX7S on Colibri Evaluation Board V3";
>> +	compatible = "toradex,colibri_imx7s-eval", "toradex,colibri_imx7s", \
>> +		     "fsl,imx7s", "fsl,imx7d";
> 
> You may not want to have "fsl,imx7d" here.  Otherwise, the detection
> between  imx7s and imx7d colibri-eval-v3 board will be difficult.

Yeah my idea behind this is that "imx7d" is still kind of the base name
of that SoC. But I agree for the bindings it does not make that much
sense.

I have to add imx7s to arch/arm/mach-imx/mach-imx7d.c though.

--
Stefan
