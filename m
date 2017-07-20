From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Thu, 20 Jul 2017 08:31:45 +0000
Subject: [PATCH v7 3/3] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <d999fc79-7b14-da8e-965f-371cf4352dd1@mleia.com>
References: <1500474344-9832-1-git-send-email-gabriel.fernandez@st.com>
 <1500474344-9832-4-git-send-email-gabriel.fernandez@st.com>
 <d999fc79-7b14-da8e-965f-371cf4352dd1@mleia.com>
Message-ID: <11c37627-a39b-7f2d-d0d4-af312eac8668@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,


On 07/19/2017 11:20 PM, Vladimir Zapolskiy wrote:
> Hello Gabriel,
>
> On 07/19/2017 05:25 PM, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch enables clocks for STM32H743 boards.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> for MFD changes:
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>
>> for DT-Bindings
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/clock/st,stm32h7-rcc.txt   |   82 ++
> I'll provide some review comments about device tree bindings only.
>
>>   drivers/clk/Makefile                               |    1 +
>>   drivers/clk/clk-stm32h7.c                          | 1409 ++++++++++++++++++++
>>   include/dt-bindings/clock/stm32h7-clks.h           |  165 +++
>>   include/dt-bindings/mfd/stm32h7-rcc.h              |  136 ++
>>   5 files changed, 1793 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>   create mode 100644 drivers/clk/clk-stm32h7.c
>>   create mode 100644 include/dt-bindings/clock/stm32h7-clks.h
>>   create mode 100644 include/dt-bindings/mfd/stm32h7-rcc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>> new file mode 100644
>> index 0000000..442c50c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>> @@ -0,0 +1,82 @@
>> +STMicroelectronics STM32H7 Reset and Clock Controller
>> +=====================================================
>> +
>> +The RCC IP is both a reset and a clock controller.
>> +
>> +Please refer to clock-bindings.txt for common clock controller binding usage.
>> +Please also refer to reset.txt for common reset controller binding usage.
>> +
>> +Required properties:
>> +- compatible: Should be:
>> +  "st,stm32h743-rcc"
>> +
>> +- reg: should be register base and length as documented in the
>> +  datasheet
>> +
>> +- #reset-cells: 1, see below
>> +
>> +- #clock-cells : from common clock binding; shall be set to 1
>> +
>> +- clocks: External oscillator clock phandle
>> +  - high speed external clock signal (HSE)
>> +  - low speed external clock signal (LSE)
>> +  - external I2S clock (I2S_CKIN)
>> +
>> +Optional properties:
>> +- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
>> +  write protection (RTC clock).
>> +
>> +Example:
>> +
>> +	rcc: rcc at 58024400 {
> 'rcc' as a generic device node name is awkward.
>
> I believe the main function of the device is clock controller (unlikely
> a generic reset controller can be converted into a clock controller),
> the locations of the document and device driver also indicate that
> primarily it is a clock controller, so I suggest to replace device node
> name with 'clock-controller' like below:
I prefer to keep rcc node name, to be coherent with the other ST 
platforms (STM32F4/F7)
> 	rcc: clock-controller at 58024400 {
>
>> +		#reset-cells = <1>;
>> +		#clock-cells = <2>
> Missing trailing semicolon       ^^^
ok
> My recommendation is to move #reset-cells and #clock-cells properties
> down after 'reg' or 'clocks' property in the list.
ok
>
>> +		compatible = "st,stm32h743-rcc", "st,stm32-rcc";
>> +		reg = <0x58024400 0x400>;
>> +		clocks = <&clk_hse>, <&clk_lse>, <&clk_i2s_ckin>;
>> +
>> +		st,syscfg = <&pwrcfg>;
>> +
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
> Please drop #address-cells and #size-cells properties completely, from
> the document the device node does not define any children subnodes.
ok
>> +	};
>> +
>> +The peripheral clock consumer should specify the desired clock by
>> +having the clock ID in its "clocks" phandle cell.
>> +
>> +All available clocks are defined as preprocessor macros in
>> +dt-bindings/clock/stm32h7-clks.h header and can be used in device
>> +tree sources.
>> +
>> +Example:
>> +
>> +		timer5: timer at 40000c00 {
>> +			compatible = "st,stm32-timer";
>> +			reg = <0x40000c00 0x400>;
>> +			interrupts = <50>;
>> +			clocks = <&rcc TIM5_CK>;
>> +
> Please remote the empty line above.
ok
>> +		};
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
>> +For example, for CRC reset:
>> +  crc = AHB4RSTR_offset / 4 * 32 + CRCRST_bit_offset = 0x88 / 4 * 32 + 19 = 1107
>> +
>> +All available preprocessor macros for reset are defined dt-bindings//mfd/stm32h7-rcc.h
> Double slashes ---------->                                           ^^^^
ok
> I have doubts if it is permitted to add source paths into the device
> tree bindings documentation, because such information is specific to
> the Linux source code.
>
> Rob, can you clarify please?
>
>> +header and can be used in device tree sources.
>> +
>> +example:
> For unification, please capitalize it: 'Example:'
ok
>> +
>> +	timer2 {
>> +		resets	= <&rcc STM32H7_APB1L_RESET(TIM2)>;
>> +	};
> --
> With best wishes,
> Vladimir
Best Regards
Gabriel
