From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Oct 2017 18:48:20 +0800
Subject: [PATCH 17/23] arm: dts: sun8i: a83t: Add display pipeline
In-Reply-To: <d83c9cb9a88677c97272e2b8c08d8f15a33391b7.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <d83c9cb9a88677c97272e2b8c08d8f15a33391b7.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64sqC40-nA41012+MukuO6RF6G7uP32T9mMqH3=rQYVmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The display pipeline on the A83T is mainly composed of the mixers and
> TCONs, plus various encoders.
>
> Let's add the mixers and TCONs to the DTSI.

You are only adding half of them, i.e. only the first pipeline.
Please mention why.

>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 80 ++++++++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index ce6e887c8938..57feeb6fee8b 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -151,6 +151,12 @@
>                 };
>         };
>
> +       de: display-engine {
> +               compatible = "allwinner,sun8i-a83t-display-engine";
> +               allwinner,pipelines = <&mixer0>;
> +               status = "disabled";
> +       };
> +
>         memory {
>                 reg = <0x40000000 0x80000000>;
>                 device_type = "memory";
> @@ -162,6 +168,46 @@
>                 #size-cells = <1>;
>                 ranges;
>
> +               display_clocks: clock at 1000000 {
> +                       compatible = "allwinner,sun8i-a83t-de2-clk";
> +                       reg = <0x01000000 0x100000>;
> +                       clocks = <&ccu CLK_PLL_DE>,
> +                                <&ccu CLK_BUS_DE>;
> +                       clock-names = "mod",
> +                                     "bus";
> +                       resets = <&ccu RST_BUS_DE>;
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +               };
> +
> +               mixer0: mixer at 1100000 {
> +                       compatible = "allwinner,sun8i-a83t-de2-mixer";
> +                       reg = <0x01100000 0x100000>;
> +                       clocks = <&display_clocks 0>,
> +                                <&display_clocks 6>;
> +                       clock-names = "bus",
> +                                     "mod";
> +                       resets = <&display_clocks 0>;
> +                       assigned-clocks = <&display_clocks 6>;

You can use the header file macros now.

> +                       assigned-clock-rates = <150000000>;
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               mixer0_out: port at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <1>;
> +
> +                                       mixer0_out_tcon0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&tcon0_in_mixer0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
>                 syscon: syscon at 1c00000 {
>                         compatible = "allwinner,sun8i-a83t-system-controller",
>                                 "syscon";
> @@ -177,6 +223,40 @@
>                         #dma-cells = <1>;
>                 };
>
> +               tcon0: lcd-controller at 1c0c000 {
> +                       compatible = "allwinner,sun8i-a83t-tcon";
> +                       reg = <0x01c0c000 0x1000>;
> +                       interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
> +                       clock-names = "ahb", "tcon-ch0";

So I spotted that LVDS can use either TCON0 or MIPI-PLL as its clock parent.
See register TCON0_LVDS_IF_REG @ 0x084. Any chance this makes it into the
binding and device trees?

> +                       clock-output-names = "tcon-pixel-clock";
> +                       resets = <&ccu RST_BUS_TCON0>, <&ccu RST_BUS_LVDS>;
> +                       reset-names = "lcd", "lvds";
> +                       status = "disabled";

Any reason not to have this enabled by default?

ChenYu

> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               tcon0_in: port at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0>;
> +
> +                                       tcon0_in_mixer0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&mixer0_out_tcon0>;
> +                                       };
> +                               };
> +
> +                               tcon0_out: port at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <1>;
> +                               };
> +                       };
> +               };
> +
>                 mmc0: mmc at 1c0f000 {
>                         compatible = "allwinner,sun8i-a83t-mmc",
>                                      "allwinner,sun7i-a20-mmc";
> --
> git-series 0.9.1
