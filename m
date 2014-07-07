From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Jul 2014 15:41:47 +0800
Subject: [PATCH v2 1/8] dma: sun4i: Add support for the DMA engine on
 sun[457]i SoCs
In-Reply-To: <1404619518-7592-2-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAGb2v654qBUDCHFNuNVkt4AcwmjCCckHD5_M1iPNmmQFXA8vpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 6, 2014 at 12:05 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> This patch adds support for the DMA engine present on Allwinner A10,
> A13, A10S and A20 SoCs. This engine has two kinds of channels: normal
> and dedicated. The main difference is in the mode of operation;
> while a single normal channel may be operating at any given time,
> dedicated channels may operate simultaneously provided there is no
> overlap of source or destination.
>
> Hardware documentation can be found on A10 User Manual (section 12), A13
> User Manual (section 14) and A20 User Manual (section 1.12)
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>
> Changes from v1:
>  * address comments from Chen-Yu and Maxime
>  * fix issue converting bus width
>  * switch to using a threaded IRQ instead of a tasklet on
>    recommendation from Maxime
>  * fix issue setting magic timing parameter for SPI transfers
>  * fix an issue with list handling reported by the kbuild 0-DAY robot (thanks!)
>  * drop a lot of unused #define
>  * probably some more stuff I'm forgetting
>
>  .../devicetree/bindings/dma/sun4i-dma.txt          |   45 +
>  drivers/dma/Kconfig                                |   10 +
>  drivers/dma/Makefile                               |    1 +
>  drivers/dma/sun4i-dma.c                            | 1025 ++++++++++++++++++++
>  4 files changed, 1081 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
>  create mode 100644 drivers/dma/sun4i-dma.c
>
> diff --git a/Documentation/devicetree/bindings/dma/sun4i-dma.txt b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
> new file mode 100644
> index 0000000..f5661a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
> @@ -0,0 +1,45 @@
> +Allwinner A10 DMA Controller
> +
> +This driver follows the generic DMA bindings defined in dma.txt.
> +
> +Required properties:
> +
> +- compatible:  Must be "allwinner,sun4i-a10-dma"
> +- reg:         Should contain the registers base address and length
> +- interrupts:  Should contain a reference to the interrupt used by this device
> +- clocks:      Should contain a reference to the parent AHB clock
> +- #dma-cells : Should be 1, a single cell holding a line request number

Oops, we missed this one. Should be 2, first cell denoting normal or
dedicated dma, second cell holding the request line number.

> +
> +Example:
> +       dma: dma-controller at 01c02000 {
> +               compatible = "allwinner,sun4i-a10-dma";
> +               reg = <0x01c02000 0x1000>;
> +               interrupts = <27>;
> +               clocks = <&ahb_gates 6>;
> +               #dma-cells = <1>;

This should match the change above.

> +       };
> +
> +Clients:
> +
> +DMA clients connected to the Allwinner A10 DMA controller must use the
> +format described in the dma.txt file, using a three-cell specifier for
> +each channel: a phandle plus two integer cells.
> +The three cells in order are:
> +
> +1. A phandle pointing to the DMA controller.
> +2. Whether it is using normal (0) or dedicated (1) channels
> +2. The port ID as specified in the datasheet

3.?

> +
> +Example:
> +       spi2: spi at 01c17000 {
> +               compatible = "allwinner,sun4i-a10-spi";
> +               reg = <0x01c17000 0x1000>;
> +               interrupts = <0 12 4>;
> +               clocks = <&ahb_gates 22>, <&spi2_clk>;
> +               clock-names = "ahb", "mod";
> +               dmas = <&dma 1 29>, <&dma 1 28>;
> +               dma-names = "rx", "tx";
> +               status = "disabled";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };

[...]

Thanks again!


Cheers
ChenYu
