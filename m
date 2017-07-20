From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 20 Jul 2017 14:51:06 +0300
Subject: [PATCH v7 3/3] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <11c37627-a39b-7f2d-d0d4-af312eac8668@st.com>
References: <1500474344-9832-1-git-send-email-gabriel.fernandez@st.com>
 <1500474344-9832-4-git-send-email-gabriel.fernandez@st.com>
 <d999fc79-7b14-da8e-965f-371cf4352dd1@mleia.com>
 <11c37627-a39b-7f2d-d0d4-af312eac8668@st.com>
Message-ID: <c5264416-754b-6ec8-f9fb-3b0ac2ba3a58@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,

On 07/20/2017 11:31 AM, Gabriel FERNANDEZ wrote:
> Hi Vladimir,
> 
> 
> On 07/19/2017 11:20 PM, Vladimir Zapolskiy wrote:
>> Hello Gabriel,
>>
>> On 07/19/2017 05:25 PM, gabriel.fernandez at st.com wrote:
>>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>
>>> This patch enables clocks for STM32H743 boards.
>>>
>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>
>>> for MFD changes:
>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>>
>>> for DT-Bindings
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   .../devicetree/bindings/clock/st,stm32h7-rcc.txt   |   82 ++
>> I'll provide some review comments about device tree bindings only.
>>
>>>   drivers/clk/Makefile                               |    1 +
>>>   drivers/clk/clk-stm32h7.c                          | 1409 ++++++++++++++++++++
>>>   include/dt-bindings/clock/stm32h7-clks.h           |  165 +++
>>>   include/dt-bindings/mfd/stm32h7-rcc.h              |  136 ++
>>>   5 files changed, 1793 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>>   create mode 100644 drivers/clk/clk-stm32h7.c
>>>   create mode 100644 include/dt-bindings/clock/stm32h7-clks.h
>>>   create mode 100644 include/dt-bindings/mfd/stm32h7-rcc.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>> new file mode 100644
>>> index 0000000..442c50c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>> @@ -0,0 +1,82 @@
>>> +STMicroelectronics STM32H7 Reset and Clock Controller
>>> +=====================================================
>>> +
>>> +The RCC IP is both a reset and a clock controller.
>>> +
>>> +Please refer to clock-bindings.txt for common clock controller binding usage.
>>> +Please also refer to reset.txt for common reset controller binding usage.
>>> +
>>> +Required properties:
>>> +- compatible: Should be:
>>> +  "st,stm32h743-rcc"
>>> +
>>> +- reg: should be register base and length as documented in the
>>> +  datasheet
>>> +
>>> +- #reset-cells: 1, see below
>>> +
>>> +- #clock-cells : from common clock binding; shall be set to 1
>>> +
>>> +- clocks: External oscillator clock phandle
>>> +  - high speed external clock signal (HSE)
>>> +  - low speed external clock signal (LSE)
>>> +  - external I2S clock (I2S_CKIN)
>>> +
>>> +Optional properties:
>>> +- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
>>> +  write protection (RTC clock).
>>> +
>>> +Example:
>>> +
>>> +	rcc: rcc at 58024400 {
>> 'rcc' as a generic device node name is awkward.
>>
>> I believe the main function of the device is clock controller (unlikely
>> a generic reset controller can be converted into a clock controller),
>> the locations of the document and device driver also indicate that
>> primarily it is a clock controller, so I suggest to replace device node
>> name with 'clock-controller' like below:
> I prefer to keep rcc node name, to be coherent with the other ST 
> platforms (STM32F4/F7)

the thing is, a device node name is expected to comply with ePAPR or
the devicetree specification, which says

	The name of a node should be somewhat generic, reflecting
	the function of the device and not its precise programming model.

If devicetree and CCF maintainers are fine with 'rcc', I won't object,
my role is just to emphasize the found issue and recommend to use another
and more common name 'clock-controller', it is a simple and fortunately
backward compatible change to other ST platforms as well.

>> 	rcc: clock-controller at 58024400 {
>>
>>> +		#reset-cells = <1>;
>>> +		#clock-cells = <2>
>> Missing trailing semicolon       ^^^
> ok

--
With best wishes,
Vladimir
