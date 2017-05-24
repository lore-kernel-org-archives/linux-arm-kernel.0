From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Wed, 24 May 2017 10:48:24 +0800
Subject: [PATCH 2/3] Documentation: add sprd clock bindings
In-Reply-To: <20170519021202.GG20170@codeaurora.org>
References: <20170515083502.4492-1-chunyan.zhang@spreadtrum.com>
 <20170515083502.4492-3-chunyan.zhang@spreadtrum.com>
 <CAK8P3a0M6M9fUTpdnW+Eso0+HKD-MF-fKPmvj+wN8GBdzu_u8A@mail.gmail.com>
 <CAAfSe-u-+snc=b6QYgA4ysknxYDXS5UqbvWBqrnZ92sSBQqJRQ@mail.gmail.com>
 <20170519021202.GG20170@codeaurora.org>
Message-ID: <CAAfSe-vY=KwwfBE5KyGByOZ+LVuTR8kwjxp1ykmJoqTT6RqMeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 19 May 2017 at 10:12, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 05/18, Chunyan Zhang wrote:
>> On 18 May 2017 at 03:43, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Mon, May 15, 2017 at 10:35 AM, Chunyan Zhang
>> > <chunyan.zhang@spreadtrum.com> wrote:
>> >> diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
>> >> new file mode 100644
>> >> index 0000000..476e315
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
>> >> @@ -0,0 +1,17 @@
>> >> +Spreadtrum adjustable pll clock driver
>> >> +
>> >> +Required properties:
>> >> +
>> >> +- compatible : must be one of:
>> >> +       "sprd,sc9836-adjustable-pll-clock"
>> >> +       "sprd,sc9860-adjustable-pll-clock"
>> >> +
>> >> +Example:
>> >> +       clk_mpll0: clk at 40400024 {
>> >> +               compatible = "sprd,sc9860-adjustable-pll-clock";
>> >> +               #clock-cells = <0>;
>> >> +               reg = <0 0x40400024 0 0x4>,
>> >> +                     <0 0x40400028 0 0x4>;
>> >> +               clocks = <&clk_mpll_gates 2>;
>> >> +               clock-output-names = "clk_mpll0";
>> >> +       };
>> >
>> > The properties listed in the example must all be either
>> > defined as "required" or "optional" properties and have a
>> > description.
>>
>> Since these common properties are documented in the common clock binding [1]
>>
>> [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>>
>> I will add explanation in this file like I do in other bindings
>> introduced in this patch, and will address 'reg' which probably is not
>> similar to the common usage.
>>
>> >
>> > The reg property here is a bit odd, as it lists two consecutive
>> > 4-byte areas, and both are suspiciously close to a round
>> > address (0x40400000), so I would guess that they are
>> > in fact part of a clock controller with several registers.
>>
>> They are PLL clock configuration registers.
>>
>> Different PLL has different configurations which listed in pll_cfg.h,
>> and probably has different number of registers for storing
>> configurations, and on some Spreadtrum's SoCs PLL clock configuration
>> registers aren't consecutive, but all PLLs on all Spreadtrum's SoCs
>> (at least so far) are using the same driver.
>>
>> >
>> > If so, please define a node for the entire clock controller,
>> > the DT description should reflect the design of the hardware
>> > rather than the design of your device driver.
>>
>> I also realized our implementation might not be easy to be understood,
>> but I haven't thought out a better solution considering the hardware
>> limitation I explained above.
>
> This binding is going down the wrong path. Please look at how
> drivers such as sunxi-ng have done the binding in comparison to
> original sunxi design. We don't put this level of detail into DT,
> instead we put the details into the driver code and have clock
> controller nodes in DT. A quick glance shows that this binding is
> making a node per-clk, which is not going to be accepted.

I have had a look at sunxi-ng design, I will try to rewrite the driver
included in this patch-set, also DT and bindings.

Thanks for your comments,
Chunyan

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
