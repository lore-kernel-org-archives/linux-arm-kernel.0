From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Tue, 27 Jun 2017 09:38:33 +0200
Subject: [PATCH 1/2] dt-bindings: spi: Document the STM32 SPI bindings
In-Reply-To: <20170626182130.px4sjfxuvdl2br42@rob-hp-laptop>
References: <1498055526-6918-1-git-send-email-amelie.delaunay@st.com>
 <1498055526-6918-2-git-send-email-amelie.delaunay@st.com>
 <20170626182130.px4sjfxuvdl2br42@rob-hp-laptop>
Message-ID: <52df2951-f22b-a0b1-27c1-434f3031025a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 06/26/2017 08:21 PM, Rob Herring wrote:
> On Wed, Jun 21, 2017 at 04:32:05PM +0200, Amelie Delaunay wrote:
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
> 
> Don't show status in examples.
> 
Ok.
>> +		cs-gpios = <&gpioa 11 0>;
>> +
>> +		spidev at 0 {
>> +			compatible = "spidev";
> 
> This is not a valid compatible. Pick a real device.
Ok this was just to illustrate the optional property st,spi-midi-ns.
> 
> Rob
> 

I will send a new patch to fix these issues.
Thanks,

Amelie
