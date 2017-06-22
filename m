From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 22 Jun 2017 13:51:51 +0200
Subject: [PATCH 1/2] dt-bindings: spi: Document the STM32 SPI bindings
In-Reply-To: <5df6d07a-59b7-6460-75c5-c3b239067616@baylibre.com>
References: <1498055526-6918-1-git-send-email-amelie.delaunay@st.com>
 <1498055526-6918-2-git-send-email-amelie.delaunay@st.com>
 <5df6d07a-59b7-6460-75c5-c3b239067616@baylibre.com>
Message-ID: <af653847-8850-5ca3-17a1-63cb23e74ad6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/21/2017 05:20 PM, Neil Armstrong wrote:
> On 06/21/2017 04:32 PM, Amelie Delaunay wrote:
>> This patch adds the documentation of device tree bindings
>> for the STM32 SPI controller.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   .../devicetree/bindings/spi/spi-stm32.txt          | 60 ++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
>> new file mode 100644
>> index 0000000..3958bf6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
>> @@ -0,0 +1,60 @@
>> +STMicroelectronics STM32 SPI Controller
>> +
>> +The STM32 SPI controller is used to communicate with external devices using
>> +the Serial Peripheral Interface. It supports full-duplex, half-duplex and
>> +simplex synchronous serial communication with external devices. It supports
>> +from 4 to 32-bit data size. Although it can be configured as master or slave,
>> +only master is supported by the driver.
>> +
>> +Required properties:
>> +- compatible: Must be "st,stm32-spi".
> 
> Hi Amelie,
> 
> What about the gen1 SPI devices like the F4 ?
> 
> It should have been better to use SoC specific compatible, or specify the SPI HW gen like gen1 or gen2.
> 
> Neil
> 

Hi Neil,

The gen1 SPI controller embedded on F4/F7 is different from gen2 
embedded on H7 and just to illustrate this, there are 5 main registers 
(16-bit) on gen1 versus 10 main registers on gen2 (32-bit)! Their 
operating modes are different, fifo management and so on... Moreover, I 
know that the community is working on an SPI driver for F4.

I agree with you on the fact that it would be better to use a SoC 
specific compatible: I will send a v2 with "st,stm32h7-spi". This way, 
this will be aligned with what have been done for the I2S part of this 
controller: https://patchwork.kernel.org/patch/9737799/

By the way, I also noticed that my optional property "st,spi-midi-ns" 
doesn't fit with the example "st,spi-midi". I will fix that in the v2 
and keep "st,spi-midi-ns".

Regards,
Amelie

>> +- reg: Offset and length of the device's register set.
>> +- interrupts: Must contain the interrupt id.
>> +- clocks: Must contain an entry for spiclk (which feeds the internal clock
>> +	  generator).
>> +- #address-cells:  Number of cells required to define a chip select address.
>> +- #size-cells: Should be zero.
>> +
>> +Optional properties:
>> +- resets: Must contain the phandle to the reset controller.
>> +- A pinctrl state named "default" may be defined to set pins in mode of
>> +  operation for SPI transfer.
>> +- dmas: DMA specifiers for tx and rx dma. DMA fifo mode must be used. See the
>> +  STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt.
>> +- dma-names: DMA request names should include "tx" and "rx" if present.
>> +- cs-gpios: list of GPIO chip selects. See the SPI bus bindings,
>> +  Documentation/devicetree/bindings/spi/spi-bus.txt
>> +
>> +
>> +Child nodes represent devices on the SPI bus
>> +  See ../spi/spi-bus.txt
>> +
>> +Optional properties:
>> +- st,spi-midi-ns: (Master Inter-Data Idleness) minimum time delay in
>> +		  nanoseconds inserted between two consecutive data frames.
>> +
>> +
>> +Example:
>> +	spi2: spi at 40003800 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		compatible = "st,stm32-spi";
>> +		reg = <0x40003800 0x400>;
>> +		interrupts = <36>;
>> +		clocks = <&rcc SPI2_CK>;
>> +		resets = <&rcc 1166>;
>> +		dmas = <&dmamux1 0 39 0x400 0x01>,
>> +		       <&dmamux1 1 40 0x400 0x01>;
>> +		dma-names = "rx", "tx";
>> +		pinctrl-0 = <&spi2_pins_b>;
>> +		pinctrl-names = "default";
>> +		status = "okay";
>> +		cs-gpios = <&gpioa 11 0>;
>> +
>> +		spidev at 0 {
>> +			compatible = "spidev";
>> +			reg = <0>;
>> +			spi-max-frequency = <4000000>;
>> +			st,spi-midi = <4000>;
>> +		};
>> +	};
>>
> 
