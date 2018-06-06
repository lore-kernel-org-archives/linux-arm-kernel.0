From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 6 Jun 2018 09:46:30 +0200
Subject: [PATCH 2/2] arm64: dts: renesas: condor: add I2C0 support
In-Reply-To: <61f6f4a4-e55c-06e0-cba1-7d90a556950a@cogentembedded.com>
References: <e9c94553-be9d-0eec-a1ee-1713bb97fbab@cogentembedded.com>
 <61f6f4a4-e55c-06e0-cba1-7d90a556950a@cogentembedded.com>
Message-ID: <CAMuHMdVRTCOmVz2wkq5SnqEUH4PAdAEp8PVj06JxgC2zLs=wow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, May 28, 2018 at 10:14 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the Condor board dependent part of the I2C0 device node.
>
> The I2C0 bus is populated by 2 ON Semiconductor PCA9654 I/O expanders
> and Analog Devices  ADV7511W HDMI transmitter (but we're only describing
> the former chips now).
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Suggestion for future improvement below.

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
> @@ -80,6 +80,28 @@
>         clock-frequency = <32768>;
>  };
>
> +&i2c0 {
> +       pinctrl-0 = <&i2c0_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       io_expander0: gpio at 20 {
> +               compatible = "onnn,pca9654";
> +               reg = <0x20>;
> +               gpio-controller;
> +               #gpio-cells = <2>;

The bindings don't mention this (the example does have it) the optional
interrupts prototype. As this is wired to INTC-EX IRQ4, you may want to
add that. Perhaps later, as r8a77980.dtsi doesn't have INTC-EX yet.

> +       };
> +
> +       io_expander1: gpio at 21 {
> +               compatible = "onnn,pca9654";
> +               reg = <0x21>;
> +               gpio-controller;
> +               #gpio-cells = <2>;

Same for IRQ5.

> +       };
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
