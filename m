From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Thu, 3 Nov 2016 12:11:19 +0100
Subject: [PATCH 01/10] Documentation: dt-bindings: Document STM32 ADC DT
 bindings
In-Reply-To: <20161031030222.vjxcxklpaua3o77d@rob-hp-laptop>
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
 <1477412722-24061-2-git-send-email-fabrice.gasnier@st.com>
 <20161031030222.vjxcxklpaua3o77d@rob-hp-laptop>
Message-ID: <37fc7ac7-8b99-9f21-d9d7-de2e217eb4cd@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2016 04:02 AM, Rob Herring wrote:
> On Tue, Oct 25, 2016 at 06:25:13PM +0200, Fabrice Gasnier wrote:
>> This patch adds documentation of device tree bindings for the STM32 ADC.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>   .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 78 ++++++++++++++++++++++
>>   1 file changed, 78 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>> new file mode 100644
>> index 0000000..a9a8b3c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>> @@ -0,0 +1,78 @@
>> +STMicroelectronics STM32 ADC device driver
>> +
>> +STM32 ADC is a successive approximation analog-to-digital converter.
>> +It has several multiplexed input channels. Conversions can be performed
>> +in single, continuous, scan or discontinuous mode. Result of the ADC is
>> +stored in a left-aligned or right-aligned 32-bit data register.
>> +Conversions can be launched in software or using hardware triggers.
>> +
>> +The analog watchdog feature allows the application to detect if the input
>> +voltage goes beyond the user-defined, higher or lower thresholds.
>> +
>> +Each STM32 ADC block can have up to 3 ADC instances.
>> +
>> +Each instance supports two contexts to manage conversions, each one has its
>> +own configurable sequence and trigger:
>> +- regular conversion can be done in sequence, running in background
>> +- injected conversions have higher priority, and so have the ability to
>> +  interrupt regular conversion sequence (either triggered in SW or HW).
>> +  Regular sequence is resumed, in case it has been interrupted.
>> +
>> +Required properties:
>> +- compatible: Should be "st,stm32f4-adc".
>> +- reg: Offset and length of the ADC block register set.
>> +- interrupts: Must contain the interrupt for ADC.
>> +- clocks: Clock for the analog circuitry (common to all ADCs).
>> +- clock-names: Must be "adc".
>> +- vref-supply: Phandle to the vref input analog reference voltage.
>> +- #address-cells = <1>;
>> +- #size-cells = <0>;
>> +
>> +Optional properties:
>> +- A pinctrl state named "default" for each ADC channel may be defined to set
>> +  inX ADC pins in mode of operation for analog input on external pin.
>> +- gpios: Array of gpios that may be configured as EXTi trigger sources.
>> +
>> +Example:
> This should be last.
Hi Rob,

I'll fix this.
>
>> +	adc: adc at 40012000 {
>> +		compatible = "st,stm32f4-adc";
>> +		reg = <0x40012000 0x400>;
>> +		interrupts = <18>;
>> +		clocks = <&rcc 0 168>;
>> +		clock-names = "adc";
>> +		vref-supply = <&reg_vref>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&adc3_in8_pin>;
>> +		gpios = <&gpioa 11 0>,
>> +			<&gpioa 15 0>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		adc1: adc1-master at 0 {
> adc at 0 sufficient?
Yes, if you agree, I'd go for adc1 at 0, adc2 at 100, adc3 at 200, to reflect reg 
property for child node.
Is it ok from your point of view ?

>
>> +			#io-channel-cells = <1>;
>> +			reg = <0x0>;
>> +			clocks = <&rcc 0 168>;
>> +			st,adc-channels = <8>;
>> +		};
>> +		...
>> +		other adc child nodes follow...
>> +	};
>> +
>> +Contents of a stm32 adc child node:
>> +-----------------------------------
>> +An ADC block node should contain at least one subnode, representing an
>> +ADC instance available on the machine.
>> +
>> +Required properties:
>> +- reg: Offset of ADC instance in ADC block (e.g. may be 0x0, 0x100, 0x200).
>> +- st,adc-channels: List of single-ended channels muxed for this ADC.
> How many? What are valid values?
stm32f4 can have up to 19 channels, numbered from 0 to 18 to match with 
reference manual.
I'll add this.
>
>> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
>> +  Documentation/devicetree/bindings/iio/iio-bindings.txt
>> +
>> +Optional properties:
>> +- clocks: Input clock private to this ADC instance.
>> +- st,injected: Use injected conversion sequence on an ADC, rather than regular.
> Not sure about this one. Seems like this would either be a user choice
> or depend on what's connected to the ADC.
It's related to ADC sequencer, and the way it's being configured/used 
(see above paragraph on regular/injected).
This is not related to what's connected to adc inputs.
As suggested by Jonathan, I think I'll drop injected support for now, to 
simplify the driver and review.

Thanks,
Best Regards,
Fabrice
>
>> +- dmas: Phandle to dma channel for this ADC instance, only for regular
>> +  conversions. See ../../dma/dma.txt for details.
>> +- dma-names: Must be "rx" when dmas property is being used.
>> -- 
>> 1.9.1
>>
