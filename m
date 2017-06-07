From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 7 Jun 2017 13:55:25 +0200
Subject: [PATCH 3/3] ARM: dts: meson8: add and use the real clock
 controller
In-Reply-To: <CAFBinCBi4TrX58XoSkiCLiUECWQhsETdC-PeW1xR7+fMr=U3kg@mail.gmail.com>
References: <20170604183341.21417-1-martin.blumenstingl@googlemail.com>
 <20170604183341.21417-4-martin.blumenstingl@googlemail.com>
 <1496607638.3552.20.camel@baylibre.com>
 <CAFBinCBi4TrX58XoSkiCLiUECWQhsETdC-PeW1xR7+fMr=U3kg@mail.gmail.com>
Message-ID: <64d7a1cf-1a6f-2872-cef2-925782210c96@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2017 12:13 AM, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Sun, Jun 4, 2017 at 10:20 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> On Sun, 2017-06-04 at 20:33 +0200, Martin Blumenstingl wrote:
>>> This removes the dummy clk81 gate and replaces it with the actual clock
>>> controller's CLKID_CLK81. This will also allow us to pass the real clock
>>> IDs to all devices where the clock is controlled by clkc in the future.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> This is going in the right direction and at least align meson8 and meson8b.
>>
>> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> that was quick, thanks!
> 
>> Later on, I'm wondering if some of these clock assignments should be moved to
>> meson.dtsi ? meson8.dtsi and meson8b.dtsi look very similar
> actually I think that the Meson6/MX/<however it is called> clock
> controller is different (based on a quick look).
> so we may end up with a similar situation that we have on
> GXBB/GXL/GXM: the clock controller will stay in the corresponding
> .dtsi and we have to "duplicate" the clock assignments for each SoC
> 
> however, I guess at some point we can create a .dtsi with all the bits
> that are shared between Meson8 and Meson8b (during my experiments
> meson8m2.dtsi just inherits meson8.dtsi and overrides a bunch of
> compatibles). we can discuss whether we want to move the clock
> controller to that shared/common .dtsi as well once we start
> generalizing this

Personally I think we should use the same schema as arm64 and leave the clock
definitions in the SoCs dtsi files.

Neil

> 
>>> ---
>>>  arch/arm/boot/dts/meson8.dtsi | 32 ++++++++++++++++----------------
>>>  1 file changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
>>> index 6993077331c7..9b0b3ddbb17e 100644
>>> --- a/arch/arm/boot/dts/meson8.dtsi
>>> +++ b/arch/arm/boot/dts/meson8.dtsi
>>> @@ -43,6 +43,7 @@
>>>   *     OTHER DEALINGS IN THE SOFTWARE.
>>>   */
>>>
>>> +#include <dt-bindings/clock/meson8b-clkc.h>
>>>  #include <dt-bindings/gpio/meson8-gpio.h>
>>>  /include/ "meson.dtsi"
>>>
>>> @@ -82,13 +83,6 @@
>>>                       reg = <0x203>;
>>>               };
>>>       };
>>> -
>>> -     clk81: clk at 0 {
>>> -             #clock-cells = <0>;
>>> -             compatible = "fixed-clock";
>>> -             clock-frequency = <141666666>;
>>> -     };
>>> -
>>>  }; /* end of / */
>>>
>>>  &aobus {
>>> @@ -126,6 +120,12 @@
>>>  };
>>>
>>>  &cbus {
>>> +     clkc: clock-controller at 4000 {
>>> +             #clock-cells = <1>;
>>> +             compatible = "amlogic,meson8-clkc";
>>> +             reg = <0x8000 0x4>, <0x4000 0x460>;
>>> +     };
>>> +
>>>       pinctrl_cbus: pinctrl at 9880 {
>>>               compatible = "amlogic,meson8-cbus-pinctrl";
>>>               reg = <0x9880 0x10>;
>>> @@ -172,20 +172,20 @@
>>>  };
>>>
>>>  &ethmac {
>>> -     clocks = <&clk81>;
>>> +     clocks = <&clkc CLKID_CLK81>;
>>>       clock-names = "stmmaceth";
>>>  };
>>>
>>>  &i2c_AO {
>>> -     clocks = <&clk81>;
>>> +     clocks = <&clkc CLKID_CLK81>;
>>>  };
>>>
>>>  &i2c_A {
>>> -     clocks = <&clk81>;
>>> +     clocks = <&clkc CLKID_CLK81>;
>>>  };
>>>
>>>  &i2c_B {
>>> -     clocks = <&clk81>;
>>> +     clocks = <&clkc CLKID_CLK81>;
>>>  };
>>>
>>>  &L2 {
>>> @@ -195,21 +195,21 @@
>>>  };
>>>
>>>  &spifc {
>>> -     clocks = <&clk81>;
>>> +     clocks = <&clkc CLKID_CLK81>;
>>>  };
>>>
>>>  &uart_AO {
>>> -     clocks = <&clk81>;
>>> +     clocks = <&clkc CLKID_CLK81>;
>>>  };
>>>
>>>  &uart_A {
>>> -     clocks = <&clk81>;
>>> +     clocks = <&clkc CLKID_CLK81>;
>>>  };
>>>
>>>  &uart_B {
>>> -     clocks = <&clk81>;
>>> +     clocks = <&clkc CLKID_CLK81>;
>>>  };
>>>
>>>  &uart_C {
>>> -     clocks = <&clk81>;
>>> +     clocks = <&clkc CLKID_CLK81>;
>>>  };
>>
