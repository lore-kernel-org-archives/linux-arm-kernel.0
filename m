From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Mon, 19 Feb 2018 15:59:28 +0000
Subject: [PATCH 1/6] dt-bindings: mfd: Add ST Multi-Function eXpander
 driver
In-Reply-To: <20180218231938.goeht7tomfkab6uu@rob-hp-laptop>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-2-git-send-email-amelie.delaunay@st.com>
 <20180218231938.goeht7tomfkab6uu@rob-hp-laptop>
Message-ID: <b08ab2cd-d6a0-b5da-e33e-ad150370776b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/19/2018 12:19 AM, Rob Herring wrote:
> On Thu, Feb 08, 2018 at 03:27:32PM +0100, Amelie Delaunay wrote:
>> This patch adds documentation of device tree bindings for the
>> STMicroelectronics Multi-Function eXpander (MFX).
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/st-mfx.txt | 51 ++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/st-mfx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/st-mfx.txt b/Documentation/devicetree/bindings/mfd/st-mfx.txt
>> new file mode 100644
>> index 0000000..423d800
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/st-mfx.txt
>> @@ -0,0 +1,51 @@
>> +STMicroelectronics Multi-Function eXpander
>> +
>> +ST Multi-Function eXpander (MFX) is a slave controller using I2C for
>> +communication with the main MCU. Its main features are gpio expansion, main
>> +MCU IDD measurement (IDD is the amount of current that flows through VDD)
>> +and resistive touchscreen controller.
> 
> You don't have to implement all the drivers now, but please completely
> describe the device. As is, there is no reason to have a child GPIO
> node.
>
The MFD driver will be abandoned as only GPIO part is used. I'll send a 
V2 soon.
>> +
>> +Required properties:
>> +- compatible: must be "st,mfx"
> 
> Kind of generic. Only 1 single version ever?
> 
"st-mfx" compatible will disappear in V2 (we keep only GPIO driver). MFX 
version can be read in MFX FW_VERSION register. So do I keep 
"st,mfx-gpio" compatible or you want to see mfx version ?

>> +- reg: I2C address of the device
>> +- interrupts: interrupt triggered by MFX_IRQ_OUT signal
>> +- interrupt-parent: interrupt controller MFX is connected to
>> +- interrupt-controller: marks the device as an interrupt controller
>> +- #interrupt-cells: should be <1>, index of the interrupt within the
>> +  controller, in accordance with the "one cell" variant of
>> +  <devicetree/bindings/interrupt-controller/interrupt.txt>
>> +
>> +Optional nodes:
>> +
>> +* GPIO eXpander
>> +MFX provides 16 programmable GPIOs, and it is also possible to recover 8
>> +alternate GPIOs if the main functions are not used (touchscreen controller and
>> +IDD measurement not enabled).
>> +
>> +Required properties:
>> +- compatible : must be "st,mfx-gpio"
>> +- interrupt-parent : must be <&mfx>
> 
> Not necessary. A parent node with 'interrupt-controller' property is the
> interrupt's parent.
> 
I will keep it in mind.
>> +- interrupts = must be <0>
>> +- gpio-controller: marks the device node as a GPIO controller
>> +- #gpio-cells: should be <2>, the first cell is the GPIO offset on this GPIO
>> +  controller, the second cell is the gpio flags in accordance with
>> +  <dt-bindings/gpio/st-mfx-gpio.h>.
> 
> Custom flags? Use standard flags.
> 
> DT binding headers should be part of this patch.
> 
Custom flags because MFX GPIOs have several types:
- Output open drain with internal pull-up resistor
- Output open drain without internal pull-up resistor
- Output push pull without internal pull resistor
- Input with internal pull-up resistor
- Input with internal pull-down resistor
- Input floating
- Input analog.
Standard flags don't have pull up or down information. That's why I am 
using custom flags, they overloads standard flags.
I will add DT bindings header in this patch V2.
>> +
>> +Example:
>> +
>> +	mfx: mfx at 42 {
>> +		compatible = "st,mfx";
>> +		reg = <0x42>;
>> +		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
>> +		interrupt-parent = <&gpioi>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
>> +
>> +		mfxgpio: mfx_gpio {
> 
> gpio {
> 
OK. Will change it in V2.

Thanks,
Amelie
>> +			compatible = "st,mfx-gpio";
>> +			interrupt-parent = <&mfx>;
>> +			interrupts = <0>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +		};
>> +	};
>> -- 
>> 2.7.4
>>
