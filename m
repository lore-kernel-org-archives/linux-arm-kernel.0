From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Mar 2017 14:04:02 -0500
Subject: [PATCH] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <dce20025-9f42-e747-e325-e1667504e615@st.com>
References: <1489569810-24350-1-git-send-email-gabriel.fernandez@st.com>
 <20170324020630.vhffmeeb6wto53zx@rob-hp-laptop>
 <dce20025-9f42-e747-e325-e1667504e615@st.com>
Message-ID: <CAL_Jsq++rdPqNZk54S7gQaeLBdzSptogp3dp9P1HmNTV67Sk9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 4:41 AM, Gabriel Fernandez
<gabriel.fernandez@st.com> wrote:
> Hi Rob,
>
> Thanks for reviewing
>
>
>
> On 03/24/2017 03:06 AM, Rob Herring wrote:
>>
>> On Wed, Mar 15, 2017 at 10:23:30AM +0100, gabriel.fernandez at st.com wrote:
>>>
>>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>
>>> This patch enables clocks for STM32H743 boards.
>>>
>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>> ---
>>>   .../devicetree/bindings/clock/st,stm32h7-rcc.txt   |  152 ++
>>>   drivers/clk/Makefile                               |    1 +
>>>   drivers/clk/clk-stm32h7.c                          | 1586
>>> ++++++++++++++++++++
>>>   include/dt-bindings/clock/stm32h7-clks.h           |  165 ++
>>>   include/dt-bindings/mfd/stm32h7-rcc.h              |  138 ++
>>>   5 files changed, 2042 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>>   create mode 100644 drivers/clk/clk-stm32h7.c
>>>   create mode 100644 include/dt-bindings/clock/stm32h7-clks.h
>>>   create mode 100644 include/dt-bindings/mfd/stm32h7-rcc.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>> b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>> new file mode 100644
>>> index 0000000..9d4b587
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>> @@ -0,0 +1,152 @@
>>> +STMicroelectronics STM32H7 Reset and Clock Controller
>>> +=====================================================
>>> +
>>> +The RCC IP is both a reset and a clock controller.
>>> +
>>> +Please refer to clock-bindings.txt for common clock controller binding
>>> usage.
>>> +Please also refer to reset.txt for common reset controller binding
>>> usage.
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
>>> +- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup
>>> domain
>>> +  write protection (RTC clock).
>>> +
>>> +- pll x node: Allow to register a pll with specific parameters.
>>> +  Please see PLL section below.
>>> +
>>> +Example:
>>> +
>>> +       rcc: rcc at 58024400 {
>>> +               #reset-cells = <1>;
>>> +               #clock-cells = <2>
>>> +               compatible = "st,stm32h743-rcc", "st,stm32-rcc";
>>> +               reg = <0x58024400 0x400>;
>>> +               clocks = <&clk_hse>, <&clk_lse>, <&clk_i2s_ckin>;
>>> +
>>> +               st,syscfg = <&pwrcfg>;
>>> +
>>> +               #address-cells = <1>;
>>> +               #size-cells = <0>;
>>> +
>>> +               vco1 at 58024430 {
>>> +                       #clock-cells = <0>;
>>> +                       compatible = "stm32,pll";
>>> +                       reg = <0>;
>>
>> The reg addr value and unit address don't match.
>
> ok il will change into
>
>         vco1 at 0 {
>                 reg = <0>;
>
>
>>
>>> +               };
>>> +
>>> +               vco2 at 58024438 {
>>> +                       #clock-cells = <0>;
>>> +                       compatible = "stm32,pll";
>>> +                       reg = <1>;
>>> +                       st,clock-div = <2>;
>>> +                       st,clock-mult = <40>;
>>> +                       st,frac-status = <0>;
>>> +                       st,frac = <0>;
>>> +                       st,vcosel = <1>;
>>> +                       st,pllrge = <2>;
>>> +               };
>>> +       };
>>> +
>>> +
>>> +STM32H7 PLL
>>> +-----------
>>> +
>>> +The VCO of STM32 PLL could be reprensented like this:
>>> +
>>> +  Vref    ---------       --------
>>> +    ---->| / DIVM  |---->| x DIVN | ------> VCO
>>> +          ---------       --------
>>> +                            ^
>>> +                            |
>>> +                         -------
>>> +                        | FRACN |
>>> +                         -------
>>> +
>>> +When the PLL is configured in integer mode:
>>> +- VCO = ( Vref / DIVM ) * DIVN
>>> +
>>> +When the PLL is configured in fractional mode:
>>> +- VCO = ( Vref / DIVM ) * ( DIVN + FRACN / 2^13)
>>> +
>>> +
>>> +Required properties for pll node:
>>> +- compatible: Should be:
>>> +  "stm32,pll"
>>
>> Only 1 single PLL design for all STM32 chips ever?
>
> no, i can change into "stm32h7,pll"

Actually, should be "st,stm32h7-pll".

>
>>> +
>>> +- #clock-cells: from common clock binding; shall be set to 0
>>> +- reg: Should be the pll number.
>>> +
>>> +Optional properties:
>>> +- st,clock-div:  DIVM division factor       : <1..63>
>>> +- st,clock-mult: DIVN multiplication factor : <4..512>
>>> +
>>> +- st,frac-status:
>>> +   - 0 Pll is configured in integer mode
>>> +   - 1 Pll is configure in fractional mode
>>
>> Isn't this implied by the presence of the next property?
>
> do you prefer this ?
>
> - st,frac :
> 0 : pll is configured in integer mode
> 1..8191 : Fractional part of the multiplication factor and pll is configured
> in fractional mode

Why not no st,frac property means integer mode?

Rob
