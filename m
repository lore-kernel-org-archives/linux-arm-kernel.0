From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 23 Oct 2016 09:33:16 +0800
Subject: [linux-sunxi] [PATCH v5 4/7] ASoC: sunxi: Add sun8i I2S driver
In-Reply-To: <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
 <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
Message-ID: <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 21, 2016 at 4:36 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> This patch adds I2S support to sun8i SoCs as the A83T and H3.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> Note: This driver is closed to the sun4i-i2s except that:
> - it handles the H3

If it's close to sun4i-i2s, you should probably rework that one to support
the newer SoCs.

> - it creates the sound card (with sun4i-i2s, the sound card is created
>   by the CODECs)

I think this is wrong. I2S is only the DAI. You typically have a separate
platform driver for the whole card, or just use simple-card.

> ---
>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  38 +-
>  sound/soc/sunxi/Kconfig                            |   8 +
>  sound/soc/sunxi/Makefile                           |   3 +
>  sound/soc/sunxi/sun8i-i2s.c                        | 700 +++++++++++++++++++++
>  4 files changed, 744 insertions(+), 5 deletions(-)
>  create mode 100644 sound/soc/sunxi/sun8i-i2s.c
>
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> index 7b526ec..2fb0a7a 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -1,4 +1,4 @@
> -* Allwinner A10 I2S controller
> +* Allwinner A10/A38T/H3 I2S controller
>
>  The I2S bus (Inter-IC sound bus) is a serial link for digital
>  audio data transfer between devices in the system.
> @@ -6,20 +6,30 @@ audio data transfer between devices in the system.
>  Required properties:
>
>  - compatible: should be one of the followings
> -   - "allwinner,sun4i-a10-i2s"
> +  - "allwinner,sun4i-a10-i2s"
> +       "allwinner,sun8i-a83t-i2s"
> +       "allwinner,sun8i-h3-i2s"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
> -- interrupts: should contain the I2S interrupt.
>  - dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
>         Documentation/devicetree/bindings/dma/dma.txt
> -- dma-names: should include "tx" and "rx".
> +- dma-names: must include "tx" and/or "rx".
>  - clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
>  - clock-names: should contain followings:
>     - "apb" : clock for the I2S bus interface
>     - "mod" : module clock for the I2S controller
>  - #sound-dai-cells : Must be equal to 0
>
> -Example:
> +Optional properties:
> +
> +- interrupts: I2S interrupt
> +- resets: phandle to the reset of the device
> +
> +Required nodes:
> +
> + - port: link to the associated CODEC (DAC, HDMI...)

Note here you are changing an existing binding, adding a required node.
If it were truely different, you probably should've started a new binding.

Regards
ChenYu

> +
> +Example 1:
>
>  i2s0: i2s at 01c22400 {
>         #sound-dai-cells = <0>;
> @@ -32,3 +42,21 @@ i2s0: i2s at 01c22400 {
>                <&dma SUN4I_DMA_NORMAL 3>;
>         dma-names = "rx", "tx";
>  };
> +
> +Example 2:
> +
> +i2s2: i2s at 1c22800 {
> +       compatible = "allwinner,sun8i-a83t-i2s";
> +       reg = <0x01c22800 0x60>;
> +       clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
> +       clock-names = "apb", "mod";
> +       resets = <&ccu RST_I2S2>;
> +       dmas = <&dma 27>;
> +       dma-names = "tx";
> +       status = "disabled";
> +       port {
> +               i2s2_hdmi: endpoint {
> +                       remote-endpoint = <&hdmi_i2s2>;
> +               };
> +       };
> +};
