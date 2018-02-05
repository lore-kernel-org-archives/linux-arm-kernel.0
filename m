From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 5 Feb 2018 07:01:29 +0000
Subject: [PATCH 01/14] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
In-Reply-To: <20180205042238.64xjrrguls2drtrg@rob-hp-laptop>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
 <1517580222-23301-2-git-send-email-gabriel.fernandez@st.com>
 <20180205042238.64xjrrguls2drtrg@rob-hp-laptop>
Message-ID: <19273eb9-0c8c-cd2a-d100-f25f25e93234@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for reviewing.


On 02/05/2018 07:09 AM, Rob Herring wrote:
> On Fri, Feb 02, 2018 at 03:03:29PM +0100, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> The RCC block is responsible of the management of the clock and reset
>> generation for the complete circuit.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>   .../devicetree/bindings/mfd/st,stm32-rcc.txt       | 85 ++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
>> new file mode 100644
>> index 0000000..28017a1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
>> @@ -0,0 +1,85 @@
>> +STMicroelectronics STM32 Peripheral Reset Clock Controller
>> +==========================================================
>> +
>> +The RCC IP is both a reset and a clock controller.
>> +
>> +Please also refer to reset.txt for common reset controller binding usage.
>> +
>> +Please also refer to clock-bindings.txt for common clock controller
>> +binding usage.
>> +
>> +
>> +Required properties:
>> +- compatible: "simple-mfd", "syscon"
>
>> +- reg: should be register base and length as documented in the datasheet
>> +
>> +- Sub-nodes:
>> +  - compatible: "st,stm32mp1-rcc-clk"
>> +	- #clock-cells: 1, device nodes should specify the clock in their
>> +	  "clocks" property, containing a phandle to the clock device node,
>> +	  an index specifying the clock to use.
>> +
>> +  - compatible: "st,stm32mp1-rcc-rst"
>> +	- #reset-cells: Shall be 1
>> +
>> +Example:
>> +	rcc: rcc at 50000000 {
>> +		compatible = "syscon", "simple-mfd";
>> +		reg = <0x50000000 0x1000>;
>> +
>> +		rcc_clk: rcc-clk at 50000000 {
>> +			#clock-cells = <1>;
>> +			compatible = "st,stm32mp1-rcc-clk";
>> +		};
>> +
>> +		rcc_rst: rcc-reset at 50000000 {
> You should not have the same unit-address twice.
>
> IMO, this should just be:
>
> 	rcc: rcc at 50000000 {
> 		compatible = "st-stm32mp1-rcc";
> 		reg = <0x50000000 0x1000>;
> 		#clock-cells = <1>;
> 		#reset-cells = <1>;
> 	};
>
> There's no reason a node can't provide more than 1 function.
RCC is an dedicated IP for clocks and resets, but also for power 
management (patches will be sent later)
Then i need to probe 3 drivers with same IP.
It's also a way to avoid use of 'CLK_OF_DECLARE_DRIVER' and i need it to 
probe the 3th driver.

BR
Gabriel

>
>
>> +			#reset-cells = <1>;
>> +			compatible = "st,stm32mp1-rcc-rst";
>> +		};
>> +	};
>> +
>> +Specifying clocks
>> +=================
>> +
>> +All available clocks are defined as preprocessor macros in
>> +dt-bindings/clock/stm32mp1-clks.h header and can be used in device
>> +tree sources.
>> +
>> +Example:
>> +
>> +	/* Accessing DMA1 clock */
>> +	... {
>> +		clocks = <&rcc_clk DMA1>
>> +	};
>> +
>> +	/* Accessing SPI6 kernel clock */
>> +	... {
>> +		clocks = <&rcc_clk SPI6_K>
>> +	};
> Other than the path to header, the clock binding explains all this. No
> need to duplicate here.
ok
>> +
>> +Specifying softreset control of devices
>> +=======================================
>> +
>> +Device nodes should specify the reset channel required in their "resets"
>> +property, containing a phandle to the reset device node and an index specifying
>> +which channel to use.
>> +The index is the bit number within the RCC registers bank, starting from RCC
>> +base address.
>> +It is calculated as: index = register_offset / 4 * 32 + bit_offset.
>> +Where bit_offset is the bit offset within the register.
>> +
>> +For example on STM32MP1, for LTDC reset:
>> + ltdc = APB4_RSTSETR_offset / 4 * 32 + LTDC_bit_offset
>> +      = 0x180 / 4 * 32 + 0 = 3072
>> +
>> +The list of valid indices for STM32MP1 is available in:
>> +include/dt-bindings/reset-controller/stm32mp1-resets.h
>> +
>> +This file implements defines like:
>> +#define LTDC_R	3072
>> +
>> +example:
>> +
>> +	ltdc {
>> +		resets = <&rcc_rst LTDC_R>;
>> +	};
>> -- 
>> 1.9.1
>>
