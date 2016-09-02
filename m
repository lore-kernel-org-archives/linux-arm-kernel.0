From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 2 Sep 2016 14:28:54 +0800
Subject: [PATCH 5/7] ARM: sun8i: a33: Add display pipeline
In-Reply-To: <20160901153204.11217-6-maxime.ripard@free-electrons.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-6-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66F+i=8SxrCN2+HNrjo5d=zXpCmbe9R=BT2sBxDXXXquw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 1, 2016 at 11:32 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Add all the needed blocks to the A33 DTSI.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi | 184 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 184 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
> index deb0cd613e97..5f9dbd17eb50 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -64,6 +64,42 @@
>         };
>
>         soc at 01c00000 {
> +               tcon0: lcd-controller at 01c0c000 {
> +                       compatible = "allwinner,sun8i-a23-tcon";
> +                       reg = <0x01c0c000 0x1000>;
> +                       interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_LCD>,
> +                                <&ccu CLK_LCD_CH0>;
> +                       clock-names = "ahb",
> +                                     "tcon-ch0";
> +                       clock-output-names = "tcon-pixel-clock";
> +                       resets = <&ccu RST_BUS_LCD>;
> +                       reset-names = "lcd";
> +                       status = "disabled";
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
> +                                       tcon0_in_drc0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&drc0_out_tcon0>;
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
>                 crypto: crypto-engine at 01c15000 {
>                         compatible = "allwinner,sun4i-a10-crypto";
>                         reg = <0x01c15000 0x1000>;
> @@ -104,6 +140,154 @@
>                         status = "disabled";
>                         #phy-cells = <1>;
>                 };
> +
> +               fe0: display-frontend at 01e00000 {
> +                       compatible = "allwinner,sun8i-a33-display-frontend";
> +                       reg = <0x01e00000 0x20000>;
> +                       interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_DE_FE>, <&ccu CLK_DE_FE>,
> +                                <&ccu CLK_DRAM_DE_FE>;
> +                       clock-names = "ahb", "mod",
> +                                     "ram";
> +                       resets = <&ccu RST_BUS_DE_FE>;
> +                       status = "disabled";
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               fe0_out: port at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <1>;
> +
> +                                       fe0_out_sat0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&sat0_in_fe0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               be0: display-backend at 01e60000 {
> +                       compatible = "allwinner,sun8i-a33-display-backend";
> +                       reg = <0x01e60000 0x10000>;

Please also list the interrupt, even though we don't use it yet.
The manual says it's 127 - 32 = 95.

> +                       clocks = <&ccu CLK_BUS_DE_BE>, <&ccu CLK_DE_BE>,
> +                                <&ccu CLK_DRAM_DE_BE>;
> +                       clock-names = "ahb", "mod",
> +                                     "ram";
> +                       resets = <&ccu RST_BUS_DE_BE>;
> +
> +                       assigned-clocks = <&ccu CLK_DE_BE>;
> +                       assigned-clock-rates = <300000000>;
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               be0_in: port at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0>;
> +
> +                                       be0_in_sat0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&sat0_out_be0>;
> +                                       };
> +                               };
> +
> +                               be0_out: port at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <1>;
> +
> +                                       be0_out_drc0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&drc0_in_be0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               drc0: drc at 01e70000 {
> +                       compatible = "allwinner,sun8i-a33-drc";
> +                       reg = <0x01e70000 0x10000>;
> +                       interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_DRC>, <&ccu CLK_DRC>,
> +                                <&ccu CLK_DRAM_DRC>;
> +                       clock-names = "ahb", "mod", "ram";
> +                       resets = <&ccu RST_BUS_DRC>;
> +
> +                       assigned-clocks = <&ccu CLK_DRC>;
> +                       assigned-clock-rates = <300000000>;
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               drc0_in: port at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0>;
> +
> +                                       drc0_in_be0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&be0_out_drc0>;
> +                                       };
> +                               };
> +
> +                               drc0_out: port at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <1>;
> +
> +                                       drc0_out_tcon0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&tcon0_in_drc0>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
> +               sat0: sat at 01e80000 {
> +                       compatible = "allwinner,sun8i-a33-sat";
> +                       reg = <0x01e80000 0x1000>;
> +                       clocks = <&ccu CLK_BUS_SAT>;
> +                       resets = <&ccu RST_BUS_SAT>;
> +
> +                       ports {
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +
> +                               sat0_in: port at 0 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <0>;
> +
> +                                       sat0_in_fe0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&fe0_out_sat0>;
> +                                       };
> +                               };
> +
> +                               sat0_out: port at 1 {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +                                       reg = <1>;
> +
> +                                       sat0_out_be0: endpoint at 0 {
> +                                               reg = <0>;
> +                                               remote-endpoint = <&be0_in_sat0>;
> +                                       };
> +                               };

I'm worried about the representation here.

In the user manuals, the SAT is shown as part of the BE.
Look at it this way: if it did come before the BE and is
independent, we shouldn't have to bring the SAT out of
reset for simplefb to work.

For comparison, a similar function unit called "CMU" found on
the other post-sun6i SoCs has the same function description as
SAT on the A33. It uses the reserved registers at the beginning
of the BE address space.

> +                       };
> +               };
> +       };
> +
> +       de: display-engine {
> +               compatible = "allwinner,sun8i-a33-display-engine";
> +               allwinner,pipelines = <&fe0>;
> +               status = "disabled";
>         };

Put this node above soc@? Properly sorted that is.

Everything else looks good.

Regards
ChenYu


>  };
>
> --
> 2.9.2
>
