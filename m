From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Nov 2015 17:47:11 +0800
Subject: [PATCH v2 4/5] dt-bindings: document sun8i_ths
In-Reply-To: <20e229f191031b0b0bff96dee118d1f2d988d7b3.1448263428.git.atx@atx.name>
References: <cover.1448263428.git.atx@atx.name>
 <20e229f191031b0b0bff96dee118d1f2d988d7b3.1448263428.git.atx@atx.name>
Message-ID: <CAGb2v675YHYR=eNczrP8srPr5aYG+8eK9GPA7vevsxjsHEW1RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 4:02 PM, Josef Gajdusek <atx@atx.name> wrote:
> This patch adds the binding documentation for the sun8i_ths driver
>
> Signed-off-by: Josef Gajdusek <atx@atx.name>
> ---
>  .../devicetree/bindings/thermal/sun8i-ths.txt      | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/sun8i-ths.txt b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
> new file mode 100644
> index 0000000..67056bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
> @@ -0,0 +1,31 @@
> +* sun8i THS
> +
> +Required properties:
> +- compatible : "allwinner,sun8i-h3-ths"
> +- reg : Address range of the thermal registers and location of the calibration
> +        value

You are now using nvmem for the calibration data. You don't need the second
entry.

> +- resets : Must contain an entry for each entry in reset-names.
> +           see ../reset/reset.txt for details
> +- reset-names : Must include the name "ahb"
> +- clocks : Must contain an entry for each entry in clock-names.
> +- clock-names : Must contain "ahb" for the bus gate and "ths" for the THS
> +  clock
> +
> +Optional properties:
> +- nvmem-cells : Must contain an entry for each entry in nvmem-cell-names
> +- nvmem-cell-names : Must contain "calibration" for the cell containing the
> +  temperature calibration cell, if available
> +
> +Example:
> +ths: ths at 01c25000 {
> +       #thermal-sensor-cells = <0>;
> +       compatible = "allwinner,sun8i-h3-ths";
> +       reg = <0x01c25000 0x88>, <0x01c14234 0x4>;

Same here.

ChenYu

> +       interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +       resets = <&bus_rst 136>;
> +       reset-names = "ahb";
> +       clocks = <&bus_gates 72>, <&ths_clk>;
> +       clock-names = "ahb", "ths";
> +       nvmem-cells = <&ths_calibration>;
> +       nvmem-cell-names = "calibration";
> +};
> --
> 2.4.10
>
