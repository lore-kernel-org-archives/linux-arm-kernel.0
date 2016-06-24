From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Jun 2016 10:46:11 +0800
Subject: [PATCH 04/14] dt-bindings: document sun8i_ths
In-Reply-To: <20160623192104.18720-5-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-5-megous@megous.com>
Message-ID: <CAGb2v64f6DmagOJMbj9YiLU+umpZ2m8YzpQjA3RhoymjEf+5cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> This patch adds the binding documentation for the sun8i_ths driver
>
> Signed-off-by: Ond?ej Jirman <megous@megous.com>
> ---
>  .../devicetree/bindings/thermal/sun8i-ths.txt      | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt
>
> diff --git a/Documentation/devicetree/bindings/thermal/sun8i-ths.txt b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
> new file mode 100644
> index 0000000..826cd57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
> @@ -0,0 +1,31 @@
> +* sun8i THS

An explanation of the acronym would be nice, both in the docs,
and in the commit message.

> +
> +Required properties:
> +- compatible : "allwinner,sun8i-h3-ths"
> +- reg : Address range of the thermal registers and location of the calibration

                                        *sensor*

Also you only specify one address range in the example. The "location
of the calibration value" is handled by the nvram-* properties. Please
remove the description.

> +        value
> +- resets : Must contain an entry for each entry in reset-names.

This, and clocks below, should probably read "must contain phandles
to reset/clock controls matching the entries of the names".

Regards
ChenYu

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
> +       reg = <0x01c25000 0x400>;
> +       interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +       resets = <&bus_rst 136>;
> +       reset-names = "ahb";
> +       clocks = <&bus_gates 72>, <&ths_clk>;
> +       clock-names = "ahb", "ths";
> +       nvmem-cells = <&ths_calibration>;
> +       nvmem-cell-names = "calibration";
> +};
> --
> 2.9.0
>
