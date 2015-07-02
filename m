From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 2 Jul 2015 11:04:55 +0800
Subject: [PATCH v2 2/4] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for spi bus
In-Reply-To: <1435583070-9600-3-git-send-email-leilk.liu@mediatek.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
 <1435583070-9600-3-git-send-email-leilk.liu@mediatek.com>
Message-ID: <CAGS+omBLNWUnNCt5XEAAqiCxzCZOsNQOXSK0ij13Wxro+Q9qLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 9:04 PM, Leilk Liu <leilk.liu@mediatek.com> wrote:
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../devicetree/bindings/spi/spi-mt65xx.txt         | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> new file mode 100644
> index 0000000..04c28fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
> @@ -0,0 +1,32 @@
> +MTK SPI device
> +
> +Required properties:
> +- compatible: should be one of the following.
> +    - mediatek,mt8173-spi: for mt8173 platforms
> +    - mediatek,mt8135-spi: for mt8135 platforms
> +    - mediatek,mt6589-spi: for mt6589 platforms
> +
> +- reg: Address and length of the register set for the device
> +
> +- interrupts: Should contain spi interrupt
> +
> +- clock-names: tuple listing input clock names.
> +       Required elements: "main"
> +
> +- clocks: phandles to input clocks.
> +
> +- pad-select: should specify spi pad used, only required for MT8173.
> +       This value should be 0~3.
> +
> +Example:
> +
> +- SoC Specific Portion:
> +spi: spi at 1100a000 {
> +       compatible = "mediatek,mt8173-spi";
> +       reg = <0 0x1100a000 0 0x1000>;
> +       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> +       clocks = <&pericfg PERI_SPI0>;

CLK_PERI_SPI0

> +       clock-names = "main";
> +       pad-select = <1>;

According to [0], a SPI bus should also specify
address-cells/size-cells to allow SPI bus devices to specify a chip
select.
[0] Documentation/devicetree/bindings/spi/spi-bus.txt

- #address-cells  - number of cells required to define a chip select
address on the SPI bus.
- #size-cells     - should be zero.

The spi-bus document even describes how to mix "native" and gpio CS lines.


I am still not sure what to do with the "pad-select" feature.
Does "pad-select" just select one of 4 dedicated chip select lines?
Or, does it also change which CK/MOSI/MISO lines are used?

Ideally, the same CK/MOSI/MISO signals are sent on all CK/MOSI/MISO
lines enabled by pinctrl, and "pad-select" just chooses which CS_N
line to use.
In this case, we can use the SPI slave device reg value to select
which CS_N to use for any given device.
Furthermore, we can also support using additional cs-gpios.

However, if the pad-select also specifies which CK/MOSI/MISO pins are
used for a given transaction, then supporting cs-gpios becomes a bit
trickier, since the spi slave device would need to specify both which
gpio-cs to use, as well as which SPI pad it is connected to.

-Dan


> +       status = "disabled";
> +};
> --
> 1.8.1.1.dirty
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
