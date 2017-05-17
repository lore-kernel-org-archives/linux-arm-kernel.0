From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 May 2017 21:43:26 +0200
Subject: [PATCH 2/3] Documentation: add sprd clock bindings
In-Reply-To: <20170515083502.4492-3-chunyan.zhang@spreadtrum.com>
References: <20170515083502.4492-1-chunyan.zhang@spreadtrum.com>
 <20170515083502.4492-3-chunyan.zhang@spreadtrum.com>
Message-ID: <CAK8P3a0M6M9fUTpdnW+Eso0+HKD-MF-fKPmvj+wN8GBdzu_u8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 10:35 AM, Chunyan Zhang
<chunyan.zhang@spreadtrum.com> wrote:
> This patch adds a new directory under the 'clock' for Spreadtrum platform,
> also bindings which document compatible strings and properties used for
> devicetree node of clocks on Spreadtrum SoCs.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  .../clock/sprd/sprd,adjustable-pll-clock.txt       | 17 +++++
>  .../bindings/clock/sprd/sprd,composite-clock.txt   | 28 +++++++++
>  .../bindings/clock/sprd/sprd,divider-clock.txt     | 24 +++++++
>  .../bindings/clock/sprd/sprd,gates-clock.txt       | 73 ++++++++++++++++++++++
>  .../bindings/clock/sprd/sprd,muxed-clock.txt       | 23 +++++++
>  5 files changed, 165 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,divider-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd/sprd,muxed-clock.txt
>
> diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
> new file mode 100644
> index 0000000..476e315
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd/sprd,adjustable-pll-clock.txt
> @@ -0,0 +1,17 @@
> +Spreadtrum adjustable pll clock driver
> +
> +Required properties:
> +
> +- compatible : must be one of:
> +       "sprd,sc9836-adjustable-pll-clock"
> +       "sprd,sc9860-adjustable-pll-clock"
> +
> +Example:
> +       clk_mpll0: clk at 40400024 {
> +               compatible = "sprd,sc9860-adjustable-pll-clock";
> +               #clock-cells = <0>;
> +               reg = <0 0x40400024 0 0x4>,
> +                     <0 0x40400028 0 0x4>;
> +               clocks = <&clk_mpll_gates 2>;
> +               clock-output-names = "clk_mpll0";
> +       };

The properties listed in the example must all be either
defined as "required" or "optional" properties and have a
description.

The reg property here is a bit odd, as it lists two consecutive
4-byte areas, and both are suspiciously close to a round
address (0x40400000), so I would guess that they are
in fact part of a clock controller with several registers.

If so, please define a node for the entire clock controller,
the DT description should reflect the design of the hardware
rather than the design of your device driver.

> diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
> new file mode 100644
> index 0000000..a476eb6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd/sprd,composite-clock.txt
> @@ -0,0 +1,28 @@
> +Spreadtrum composite clock driver.
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +
> +- compatible:  should be "sprd,composite-clock"
> +
> +- sprd,mux-msk:        arbitrary bitmask for selecting clock input

"arbitrary" is not a good word to use in a specification document ;-)

Are there no constraints whatsoever on the allowed values? How
many bits are there?

> +- sprd,div-msk:        arbitrary bitmask for programming the divider,
> +               denominator of divider is the value consisted
> +               of these bits plus 1

This sounds like it should just be the denominator, you can add
or subtract one in the driver.

> diff --git a/Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt b/Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
> new file mode 100644
> index 0000000..f23ecb6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd/sprd,gates-clock.txt
> @@ -0,0 +1,73 @@
> +Spreadtrum gate clock driver
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Spreadtrum's SoCs often use one register to control more than one gate clocks.
> +Clock consumers can use index to get the correct gate clock.
> +
> +In Spreadtrum platform, some of gate clocks have three registers, respectively
> +used for controlling, setting and clearing gate clock, the addresses of
> +these three registers generally are <start>, <start + offset>, and
> +<start + offset * 2>, and offset would be 0x1000 or 0x100, so the register
> +size of gate clocks is either 0x3000 or 0x300. While for some historical issue
> +there also are some clocks which don't have independent set/clear registers.
> +Please see bellow for more specific information.
> +
> +Required properties:
> +
> +- compatible:  should be one of the following:
> +               "sprd,sc1000-gates-clock"
> +               - offset of the registers for setting gate is 0x1000
> +
> +               "sprd,sc100-gates-clock"
> +               - offset of the registers for setting gate is 0x100
> +
> +               "sprd,gates-clock"
> +               - for clocks without independent set/clear registers

I think the compatible value should refer to at least some more
specific product that uses these: I would guess that there are
some chips that spreadtrum has made that have clock gates
which are not compatible with this.

Can all three appear in the same chip, or would you always
have only one of them?

> +- reg: the first cell represents the address of this clock gate controller
> +       register, the second cell implies how is the offset of set/clear
> +       registers of this clock gate, like addressed in the head of this
> +       file
> +
> +optional properties:
> +
> +- clock-indices:       If the identifying number for the clocks in the node
> +                       is not linear from zero, this property is necessary
> +
> +Example:
> +
> +       clk_mpll_gates: clk at 402b00b0 {
> +               compatible = "sprd,sc1000-gates-clock";
> +               #clock-cells = <1>;
> +               reg = <0 0x402b00b0 0 0x3000>;
> +               clocks = <&ext_26m>;
> +               clock-indices = <2>, <18>;
> +               clock-output-names = "clk_mpll0_gate", "clk_mpll1_gate";
> +       };
>

For clock-output-names, please drop the "clk_" prefix from each
identifier, and maybe use '-' instead of '_' as the separator.

       Arnd
