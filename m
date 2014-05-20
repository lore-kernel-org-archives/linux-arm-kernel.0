From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 20 May 2014 15:11:20 +0900
Subject: [PATCH 3/3] Documentation: gpio: Add APM X-Gene SoC GPIO
 controller DTS binding
In-Reply-To: <1400263432-922-4-git-send-email-fkan@apm.com>
References: <1400263432-922-1-git-send-email-fkan@apm.com>
 <1400263432-922-4-git-send-email-fkan@apm.com>
Message-ID: <CAAVeFuLjv2uu_jm84CwCOMLZwFc3c8Vbof4GW21pLpQdh3syvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 3:03 AM, Feng Kan <fkan@apm.com> wrote:
> Documentation for APM X-Gene SoC GPIO controller DTS binding.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  .../devicetree/bindings/gpio/gpio-xgene.txt        | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-xgene.txt
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene.txt
> new file mode 100644
> index 0000000..e19eb5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-xgene.txt
> @@ -0,0 +1,57 @@
> +APM X-Gene SoC GPIO controller bindings
> +
> +This is a gpio controller that is part of the flash controller.
> +All registers are 32bit and in little endian format.
> +
> +Required properties:
> +- compatible: "apm,xgene-gpio" for X-Gene GPIO controller
> +- reg: Physical base address and length of the controller's registers
> +
> +The gpio controller has multiple banks, each bank will have 16 or less
> +gpio pins. All cfg field will be little endian and least significant
> +bit indicate lowest number of gpio.
> +
> +Required properties:
> +- #gpio-cells: Should be two.
> +       - first cell is the pin number
> +       - second cell is used to specify optional parameters (unused)
> +- gpio-controller: Marks the device node as a GPIO controller.

Shouldnt these properties be part of the parent instead of being
repeated for each bank?

> +- bank:  This is to specifiy which gpio bank the dts node is describing.

I suspect you could use the reg property for this, as it seems like
you would need it for DT compliance anyway (but I'm not 100% sure
here).

> +
> +Optional properties:
> +- ngpio: Specify the number of GPIOs per bank. It is defaulted to 16
> +        if not specified. Number of gpio can't be greater than 16 or
> +        0.
> +- odcfg: This is gpio open drain/normal configuration. It is a 16 bit
> +        field, setting 1 will mean the pin is set in open drain
> +        configuration, 0 will mean normal configuration. Default will
> +        be normal configuration.
> +
> +Example:
> +       gpio: gpio at 1701c000 {
> +               compatible = "apm,xgene-gpio";
> +               reg = <0x0 0x1701c000 0x0 0x1000>;
> +
> +               banka: gpio-controller at 0 {
> +                       compatible = "apm,xgene-gpio-port";

This property is not documented. Besides I don't see it anywhere in
your driver implementation so I would say it is probably not needed at
all.

> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       ngpios = <16>;
> +                       bank = <0>;
> +                       odcfg = <0xffff>;   /* Optional */
> +               };
> +               bankb: gpio-controller at 1 {
> +                       compatible = "apm,xgene-gpio-port";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       ngpios = <16>;
> +                       bank = <1>;
> +               };
> +               bankc: gpio-controller at 2 {
> +                       compatible = "apm,xgene-gpio-port";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       ngpios = <16>;
> +                       bank = <2>;
> +               };
> +       };
> --
> 1.9.1
>
