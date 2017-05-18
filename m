From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Thu, 18 May 2017 16:47:34 +0800
Subject: [PATCH 2/3] Documentation: add sprd clock bindings
In-Reply-To: <CAK8P3a0M6M9fUTpdnW+Eso0+HKD-MF-fKPmvj+wN8GBdzu_u8A@mail.gmail.com>
References: <20170515083502.4492-1-chunyan.zhang@spreadtrum.com>
 <20170515083502.4492-3-chunyan.zhang@spreadtrum.com>
 <CAK8P3a0M6M9fUTpdnW+Eso0+HKD-MF-fKPmvj+wN8GBdzu_u8A@mail.gmail.com>
Message-ID: <CAAfSe-u-+snc=b6QYgA4ysknxYDXS5UqbvWBqrnZ92sSBQqJRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Many thanks for your time.

On 18 May 2017 at 03:43, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, May 15, 2017 at 10:35 AM, Chunyan Zhang
> <chunyan.zhang@spreadtrum.com> wrote:
>> This patch adds a new directory under the 'clock' for Spreadtrum platform,
>> also bindings which document compatible strings and properties used for
>> devicetree node of clocks on Spreadtrum SoCs.
>>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  .../clock/sprd/sprd,adjustable-pll-clock.txt       | 17 +++++
>>  .../bindings/clock/sprd/sprd,composite-clock.txt   | 28 +++++++++
>>  .../bindings/clock/sprd/sprd,divider-clock.txt     | 24 +++++++
>>  .../bindings/clock/sprd/sprd,gates-clock.txt       | 73 ++++++++++++++++++++++
>>  .../bindings/clock/sprd/sprd,muxed-clock.txt       | 23 +++++++
>>  5 files changed, 165 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,divider-clock.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,muxed-clock.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
>> new file mode 100644
>> index 0000000..476e315
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
>> @@ -0,0 +1,17 @@
>> +Spreadtrum adjustable pll clock driver
>> +
>> +Required properties:
>> +
>> +- compatible : must be one of:
>> +       "sprd,sc9836-adjustable-pll-clock"
>> +       "sprd,sc9860-adjustable-pll-clock"
>> +
>> +Example:
>> +       clk_mpll0: clk at 40400024 {
>> +               compatible = "sprd,sc9860-adjustable-pll-clock";
>> +               #clock-cells = <0>;
>> +               reg = <0 0x40400024 0 0x4>,
>> +                     <0 0x40400028 0 0x4>;
>> +               clocks = <&clk_mpll_gates 2>;
>> +               clock-output-names = "clk_mpll0";
>> +       };
>
> The properties listed in the example must all be either
> defined as "required" or "optional" properties and have a
> description.

Since these common properties are documented in the common clock binding [1]

[1] Documentation/devicetree/bindings/clock/clock-bindings.txt

I will add explanation in this file like I do in other bindings
introduced in this patch, and will address 'reg' which probably is not
similar to the common usage.

>
> The reg property here is a bit odd, as it lists two consecutive
> 4-byte areas, and both are suspiciously close to a round
> address (0x40400000), so I would guess that they are
> in fact part of a clock controller with several registers.

They are PLL clock configuration registers.

Different PLL has different configurations which listed in pll_cfg.h,
and probably has different number of registers for storing
configurations, and on some Spreadtrum's SoCs PLL clock configuration
registers aren't consecutive, but all PLLs on all Spreadtrum's SoCs
(at least so far) are using the same driver.

>
> If so, please define a node for the entire clock controller,
> the DT description should reflect the design of the hardware
> rather than the design of your device driver.

I also realized our implementation might not be easy to be understood,
but I haven't thought out a better solution considering the hardware
limitation I explained above.

>
>> diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
>> new file mode 100644
>> index 0000000..a476eb6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
>> @@ -0,0 +1,28 @@
>> +Spreadtrum composite clock driver.
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +
>> +- compatible:  should be "sprd,composite-clock"
>> +
>> +- sprd,mux-msk:        arbitrary bitmask for selecting clock input
>
> "arbitrary" is not a good word to use in a specification document ;-)
>
> Are there no constraints whatsoever on the allowed values? How
> many bits are there?

This actually represents which bits in the register of this clock
should be used for selecting clock inputs, so it depends on how many
clock inputs this composite-clock includes.  Also different
composite-clock has different combination of clock inputs.

>
>> +- sprd,div-msk:        arbitrary bitmask for programming the divider,
>> +               denominator of divider is the value consisted
>> +               of these bits plus 1
>
> This sounds like it should just be the denominator, you can add
> or subtract one in the driver.

I will rephrase this description.  This represents which bits in the
register of this clock should be used for setting the value of
denominator (more exactly to say that the value plus 1 as
denominator).

>
>> diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
>> new file mode 100644
>> index 0000000..f23ecb6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
>> @@ -0,0 +1,73 @@
>> +Spreadtrum gate clock driver
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Spreadtrum's SoCs often use one register to control more than one gate clocks.
>> +Clock consumers can use index to get the correct gate clock.
>> +
>> +In Spreadtrum platform, some of gate clocks have three registers, respectively
>> +used for controlling, setting and clearing gate clock, the addresses of
>> +these three registers generally are <start>, <start + offset>, and
>> +<start + offset * 2>, and offset would be 0x1000 or 0x100, so the register
>> +size of gate clocks is either 0x3000 or 0x300. While for some historical issue
>> +there also are some clocks which don't have independent set/clear registers.
>> +Please see bellow for more specific information.
>> +
>> +Required properties:
>> +
>> +- compatible:  should be one of the following:
>> +               "sprd,sc1000-gates-clock"
>> +               - offset of the registers for setting gate is 0x1000
>> +
>> +               "sprd,sc100-gates-clock"
>> +               - offset of the registers for setting gate is 0x100
>> +
>> +               "sprd,gates-clock"
>> +               - for clocks without independent set/clear registers
>
> I think the compatible value should refer to at least some more
> specific product that uses these: I would guess that there are
> some chips that spreadtrum has made that have clock gates
> which are not compatible with this.

All chips that Spreadtrum has made so far have the similar h/w design
on clock gates, only the meaning of each bit in their registers is a
little different.

The 'sc1000-gates-clock' has dedicated registers respectively used for
setting and clearing gate clocks.

Like documented in this binding, 1000 means the address of registers
for setting is the address of gate clock control register plus 1000,
and clearing registers plus 1000 * 2, the similar with
'sc100-gates-clock'.

>
> Can all three appear in the same chip, or would you always
> have only one of them?

All these three kinds of gates indeed are being used on SC9860.

>
>> +- reg: the first cell represents the address of this clock gate controller
>> +       register, the second cell implies how is the offset of set/clear
>> +       registers of this clock gate, like addressed in the head of this
>> +       file
>> +
>> +optional properties:
>> +
>> +- clock-indices:       If the identifying number for the clocks in the node
>> +                       is not linear from zero, this property is necessary
>> +
>> +Example:
>> +
>> +       clk_mpll_gates: clk at 402b00b0 {
>> +               compatible = "sprd,sc1000-gates-clock";
>> +               #clock-cells = <1>;
>> +               reg = <0 0x402b00b0 0 0x3000>;
>> +               clocks = <&ext_26m>;
>> +               clock-indices = <2>, <18>;
>> +               clock-output-names = "clk_mpll0_gate", "clk_mpll1_gate";
>> +       };
>>
>
> For clock-output-names, please drop the "clk_" prefix from each
> identifier, and maybe use '-' instead of '_' as the separator.

Ok, will address this.

Thanks for the review,
Chunyan

>
>        Arnd
