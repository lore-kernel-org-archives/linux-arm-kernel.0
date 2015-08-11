From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 11 Aug 2015 20:37:36 +0800
Subject: [PATCH v5 3/3] arm64: dts: Add spi bus dts
In-Reply-To: <1438931991-17044-4-git-send-email-leilk.liu@mediatek.com>
References: <1438931991-17044-1-git-send-email-leilk.liu@mediatek.com>
 <1438931991-17044-4-git-send-email-leilk.liu@mediatek.com>
Message-ID: <CAGS+omA0dabyGkCB2JYORn1CjXvgMs_3x7nqSOOJKMg4HRhCSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 7, 2015 at 3:19 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
> This patch adds MT8173 spi bus controllers into device tree.
>
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
> Change in this patch:
> 1. "pad-select" is a vendor property, so change it to "mediatek,pad-select".
> 2. modify the property of clocks and clock-names.
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index d18ee42..066bd6a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -220,6 +220,15 @@
>                                         bias-disable;
>                                 };
>                         };
> +
> +                       spi_pins_a: spi0 {
> +                               pins_spi {
> +                                       pinmux = <MT8173_PIN_69_SPI_CK__FUNC_SPI_CK_0_>,
> +                                               <MT8173_PIN_70_SPI_MI__FUNC_SPI_MI_0_>,
> +                                               <MT8173_PIN_71_SPI_MO__FUNC_SPI_MO_0_>,
> +                                               <MT8173_PIN_72_SPI_CS__FUNC_SPI_CS_0_>;
> +                               };
> +                       };
>                 };
>
>                 scpsys: scpsys at 10006000 {
> @@ -365,6 +374,20 @@
>                         status = "disabled";
>                 };
>
> +               spi: spi at 1100a000 {
> +                       compatible = "mediatek,mt8173-spi";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0 0x1100a000 0 0x1000>;
> +                       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks = <&topckgen CLK_TOP_SPI_SEL>, <&topckgen CLK_TOP_SYSPLL3_D2>;
> +                       clock-names = "spi-clk", "parent-clk";
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&spi_pins_a>;
> +                       mediatek,pad-select = <0>;

The pinctl and pad-select fields are board specific.
Please move to mt8173-evb.dtsi, along with status = "okay";

> +                       status = "disabled";
> +               };
> +
>                 i2c3: i2c3 at 11010000 {
>                         compatible = "mediatek,mt8173-i2c";
>                         reg = <0 0x11010000 0 0x70>,
> --
> 1.8.1.1.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
