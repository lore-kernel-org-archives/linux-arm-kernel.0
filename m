From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Wed, 9 May 2018 07:31:31 +0000
Subject: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
In-Reply-To: <20180416181940.4b5z4svbde3ompij@rob-hp-laptop>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
 <1523440025-18077-2-git-send-email-amelie.delaunay@st.com>
 <20180416181940.4b5z4svbde3ompij@rob-hp-laptop>
Message-ID: <124c557b-d6c0-5734-5992-af15b527cbe4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/16/2018 08:19 PM, Rob Herring wrote:
> On Wed, Apr 11, 2018 at 11:47:01AM +0200, Amelie Delaunay wrote:
>> This patch adds documentation of device tree bindings for the
>> STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 118 +++++++++++++++++++++
>>   1 file changed, 118 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
>> new file mode 100644
>> index 0000000..4d8941de
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
>> @@ -0,0 +1,118 @@
>> +STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander bindings
>> +
>> +ST Multi-Function eXpander (STMFX) is a slave controller using I2C for
>> +communication with the main MCU. It offers up to 24 GPIOs expansion.
>> +
>> +Required properties:
>> +- compatible: should be "st,stmfx-0300".
>> +- reg: I2C slave address of the device.
>> +- interrupt-parent: phandle of the STMFX parent interrupt controller.
>> +- interrutps: interrupt specifier triggered by MFX_IRQ_OUT signal.
>> +
>> +Optional property:
> 
> s/property/properties/
> 
>> +- drive-open-drain: configure MFX_IRQ_OUT as open drain.
>> +- vdd-supply: phandle of the regulator supplying STMFX.
>> +
>> +Required properties for gpio controller sub-node:
>> +- #gpio-cells: should be <2>, the first cell is the GPIO number and the second
>> +  cell is the gpio flags in accordance with <dt-bindings/gpio/gpio.h>.
>> +- gpio-controller: marks the device as a GPIO controller.
>> +Please refer to ../gpio/gpio.txt.
>> +
>> +Optional properties for gpio controller sub-node:
>> +- #interrupt-cells: should be <2>, the first cell is the GPIO number and the
>> +  second cell is the interrupt flags in accordance with
>> +  <dt-bindings/interrupt-controller/irq.h>.
>> +- interrupt-controller: marks the device as an interrupt controller.
>> +
>> +Please refer to pinctrl-bindings.txt for pin configuration.
>> +
>> +Required properties for pin configuration sub-nodes:
>> +- pins: list of pins to which the configuration applies.
>> +
>> +Optional properties for pin configuration sub-nodes (pinconf-generic ones):
>> +- bias-disable: disable any bias on the pin.
>> +- bias-pull-up: the pin will be pulled up.
>> +- bias-pull-pin-default: use the pin-default pull state.
>> +- bias-pull-down: the pin will be pulled down.
>> +- drive-open-drain: the pin will be driven with open drain.
>> +- drive-push-pull: the pin will be driven actively high and low.
>> +- output-high: the pin will be configured as an output driving high level.
>> +- output-low: the pin will be configured as an output driving low level.
>> +
>> +Note that STMFX pins[15:0] are called "gpio[15:0]", and STMFX pins[23:16] are
>> +called "agpio[7:0]". Example, to refer to pin 18 of STMFX, use "agpio2".
>> +
>> +Example:
>> +
>> +	stmfxpinctrl: stmfx at 42 {
>> +		compatible = "st,stmfx-0300";
>> +		reg = <0x42>;
>> +		interrupt-parent = <&gpioi>;
>> +		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
>> +		vdd-supply = <&v3v3>;
>> +		status = "okay";
> 
> Don't show status in examples.
> 

I'll fix it.

>> +
>> +		stmfxgpio: gpio {
> 
> Why does this need to be a sub node? Are there functions beyond GPIO?
> 

I'll address this point in my response to Linus.

>> +			#gpio-cells = <2>;
>> +			#interrupt-cells = <2>;
>> +			gpio-controller;
>> +			interrupt-controller;
>> +			status = "okay";
>> +		};
>> +
>> +		joystick_pins: joystick at 0 {
> 
> A unit-address without a reg prop is not valid.
> 

OK, I'll replace it by 'joystick_pins: joystick-0'.

>> +			pins = "gpio0", "gpio1", "gpio2", "gpio3", "gpio4";
>> +			drive-push-pull;
>> +			bias-pull-down;
>> +		};
>> +	};
>> +
>> +	joystick {
>> +		compatible = "gpio-keys";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		pinctrl-0 = <&joystick_pins>;
>> +		pinctrl-names = "default";
>> +		button at 0 {
>> +			label = "JoySel";
>> +			linux,code = <KEY_ENTER>;
>> +			interrupt-parent = <&stmfxgpio>;
>> +			interrupts = <0 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +		button at 1 {
>> +			label = "JoyDown";
>> +			linux,code = <KEY_DOWN>;
>> +			interrupt-parent = <&stmfxgpio>;
>> +			interrupts = <1 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +		button at 2 {
>> +			label = "JoyLeft";
>> +			linux,code = <KEY_LEFT>;
>> +			interrupt-parent = <&stmfxgpio>;
>> +			interrupts = <2 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +		button at 3 {
>> +			label = "JoyRight";
>> +			linux,code = <KEY_RIGHT>;
>> +			interrupt-parent = <&stmfxgpio>;
>> +			interrupts = <3 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +		button at 4 {
>> +			label = "JoyUp";
>> +			linux,code = <KEY_UP>;
>> +			interrupt-parent = <&stmfxgpio>;
>> +			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		orange {
>> +			gpios = <&stmfxgpio 17 1>;
>> +		};
>> +
>> +		blue {
>> +			gpios = <&stmfxgpio 19 1>;
>> +		};
>> +	}
>> -- 
>> 2.7.4
>>

Thanks,
Amelie
