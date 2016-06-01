From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 1 Jun 2016 11:23:48 +0200
Subject: [PATCH 07/13] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
Message-ID: <CAMuHMdW2T=UzciTPkU7AwWTBr_iHO3NXfe1BfpPDQbVwjEmbwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2016 at 12:24 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The initial R8A7792 SoC device tree including 2 CPU cores, GIC, timer, SYSC,
> and the required  clock descriptions.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/boot/dts/r8a7792.dtsi |  423 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 423 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm/boot/dts/r8a7792.dtsi
> @@ -0,0 +1,423 @@
> +/*
> + * Device Tree Source for the r8a7792 SoC
> + *
> + * Copyright (C) 2016 Cogent Embedded Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/clock/r8a7792-clock.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>

#include <dt-bindings/interrupt-controller/irq.h> is included
implicitly by the above.

> +#include <dt-bindings/power/r8a7792-sysc.h>
> +
> +/ {
> +       compatible = "renesas,r8a7792";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu at 0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a15";
> +                       reg = <0>;
> +                       clock-frequency = <1000000000>;
> +                       clocks = <&cpg_clocks R8A7792_CLK_Z>;
> +                       power-domains = <&sysc R8A7792_PD_CA15_CPU0>;
> +                       next-level-cache = <&L2_CA15>;
> +               };
> +
> +               cpu1: cpu at 1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a15";
> +                       reg = <1>;
> +                       clock-frequency = <1000000000>;
> +                       power-domains = <&sysc R8A7792_PD_CA15_CPU1>;
> +                       next-level-cache = <&L2_CA15>;
> +               };
> +
> +               L2_CA15: cache-controller at 0 {
> +                       compatible = "cache";
> +                       reg = <0>;
> +                       cache-unified;
> +                       cache-level = <2>;
> +                       power-domains = <&sysc R8A7792_PD_CA15_SCU>;
> +               };
> +       };
> +
> +       gic: interrupt-controller at f1001000 {

It would be good to group all on-SoC devices under an "soc" node, like we
started doing for r8a7795.

> +       clocks {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               /* External root clock */
> +               extal_clk: extal {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       /* This value must be overridden by the board. */
> +                       clock-frequency = <0>;
> +               };

The fixed clocks should be at the root level these days.

> +               /* Special CPG clocks */
> +               cpg_clocks: cpg_clocks at e6150000 {
> +                       compatible = "renesas,r8a7792-cpg-clocks",
> +                                    "renesas,rcar-gen2-cpg-clocks";
> +                       reg = <0 0xe6150000 0 0x1000>;
> +                       clocks = <&extal_clk>;
> +                       #clock-cells = <1>;
> +                       clock-output-names = "main", "pll0", "pll1", "pll3",
> +                                            "lb", "qspi", "sdh", "sd0", "sd1",
> +                                            "z";

"sdh", "sd0", and "sd1" do not exist. Please remove them.

> +               z2_clk: z2 {
> +                       compatible = "fixed-factor-clock";
> +                       clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
> +                       #clock-cells = <0>;
> +                       clock-div = <2>;
> +                       clock-mult = <1>;
> +               };

V2H doesn't have Z2.

> +               i_clk: i {
> +                       compatible = "fixed-factor-clock";
> +                       clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
> +                       #clock-cells = <0>;
> +                       clock-div = <2>;
> +                       clock-mult = <1>;
> +               };

clock-div = <3>;

> +               cp_clk: cp {
> +                       compatible = "fixed-factor-clock";
> +                       clocks = <&extal_clk>;
> +                       #clock-cells = <0>;
> +                       clock-div = <2>;
> +                       clock-mult = <1>;
> +               };

On V2H, CP is derived from PLL1, cfr. CL.
The clock derived from EXTAL is called CPEX.

> +               mstp1_clks: mstp1_clks at e6150134 {
> +                       compatible = "renesas,r8a7792-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
> +                       clocks = <&p_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>,
> +                                <&cp_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7792_CLK_TMU1 R8A7792_CLK_TMU3
> +                               R8A7792_CLK_TMU2 R8A7792_CLK_CMT0
> +                               R8A7792_CLK_TMU0 R8A7792_CLK_VSP1DU1
> +                               R8A7792_CLK_VSP1DU0 R8A7792_CLK_VSP1_SY
> +                       >;
> +                       clock-output-names = "tmu1", "tmu3", "tmu2", "cmt0",
> +                                            "tmu0", "vsp1du1", "vsp1du0",

These are called "vsp1-du1", "vsp1-du0" in all other R-Car Gen2 dtsis.

> +                                            "vsp1-sy";
> +               };
> +               mstp2_clks: mstp2_clks at e6150138 {
> +                       compatible = "renesas,r8a7792-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
> +                       clocks = <&mp_clk>, <&zs_clk>, <&zs_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7792_CLK_MSIOF1
> +                               R8A7792_CLK_SYS_DMAC0 R8A7792_CLK_SYS_DMAC1

Wrong order of the DMACs.

> +                       >;
> +                       clock-output-names = "msiof1", "sys-dmac0", "sys-dmac1";

Wrong order of the DMACs.

> +               };
> +               mstp3_clks: mstp3_clks at e615013c {
> +                       compatible = "renesas,r8a7792-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
> +                       clocks = <&cp_clk>, <&cpg_clocks R8A7792_CLK_SD0>,

As there's no SD0, this can't be correct.

> +                                <&rclk_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7792_CLK_TPU0 R8A7792_CLK_SDHI0
> +                               R8A7792_CLK_CMT1
> +                       >;
> +                       clock-output-names = "tpu0", "sdhi0", "cmt1";
> +               };

> +               mstp5_clks: mstp5_clks at e6150144 {
> +                       compatible = "renesas,r8a7792-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
> +                       clocks = <&hp_clk>, <&extal_clk>, <&p_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7792_CLK_AUDIO_DMAC0
> +                               R8A7792_CLK_THERMAL R8A7792_CLK_PWM
> +                       >;
> +                       clock-output-names = "thermal", "pwm", "audmac0";

clock-output-names = "audmac0", "thermal", "pwm";

> +               };


> +               mstp9_clks: mstp9_clks at e6150994 {
> +                       compatible = "renesas,r8a7792-mstp-clocks",
> +                                    "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
> +                       clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
> +                                <&cp_clk>, <&cp_clk>, <&cp_clk>, <&cp_clk>,
> +                                <&cp_clk>, <&cp_clk>, <&p_clk>, <&p_clk>,
> +                                <&cpg_clocks R8A7792_CLK_QSPI>, <&cp_clk>,
> +                                <&cp_clk>, <&hp_clk>, <&cp_clk>, <&hp_clk>,
> +                                <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
> +                       #clock-cells = <1>;
> +                       clock-indices = <
> +                               R8A7792_CLK_GPIO7 R8A7792_CLK_GPIO6
> +                               R8A7792_CLK_GPIO5 R8A7792_CLK_GPIO4
> +                               R8A7792_CLK_GPIO3 R8A7792_CLK_GPIO2
> +                               R8A7792_CLK_GPIO1 R8A7792_CLK_GPIO0
> +                               R8A7792_CLK_GPIO11 R8A7792_CLK_GPIO10
> +                               R8A7792_CLK_CAN1 R8A7792_CLK_CAN0
> +                               R8A7792_CLK_QSPI_MOD R8A7792_CLK_GPIO9
> +                               R8A7792_CLK_GPIO8 R8A7792_CLK_I2C5
> +                               R8A7792_CLK_IICDVFS R8A7792_CLK_I2C4
> +                               R8A7792_CLK_I2C3 R8A7792_CLK_I2C2
> +                               R8A7792_CLK_I2C1 R8A7792_CLK_I2C0
> +                       >;
> +                       clock-output-names = "gpio7", "gpio6", "gpio5", "gpio4",
> +                                            "gpio3", "gpio2", "gpio1", "gpio0",
> +                                            "gpio11", "gpio10", "can1", "can0",

These are called "rcan1", "rcan0" in other dtsis.

> +                                            "qspi_mod", "gpio9", "gpio8",
> +                                            "i2c5", "iic3", "i2c4", "i2c3",
> +                                            "i2c2", "i2c1", "i2c0";
> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
