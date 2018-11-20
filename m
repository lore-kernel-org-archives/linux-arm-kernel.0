From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Nov 2018 11:16:00 +0100
Subject: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
In-Reply-To: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdWQYt4nrjBeQnWcZ+OOT+UX=9KTu3Lki7aS=n3n8FczZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Nov 6, 2018 at 9:46 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds SDHI{0,1,3} device nodes for the r8a77990 SoC
> and enables SD card slot connected to SDHI0, micro SD card slot
> connected to SDHI1 and eMMC connected to SDHI3 on the Ebisu board
> using the R8A77990 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

> --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> @@ -129,6 +129,15 @@
>                 };
>         };
>
> +       reg_1p8v: regulator0 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "fixed-1.8V";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +
>         reg_3p3v: regulator1 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "fixed-3.3V";
> @@ -180,6 +189,54 @@
>                 #clock-cells = <0>;
>                 clock-frequency = <74250000>;
>         };
> +
> +       vcc_sdhi0: regulator-vcc-sdhi0 {
> +               compatible = "regulator-fixed";
> +
> +               regulator-name = "SDHI0 Vcc";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpio = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       vccq_sdhi0: regulator-vccq-sdhi0 {
> +               compatible = "regulator-gpio";
> +
> +               regulator-name = "SDHI0 VccQ";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
> +               gpios-states = <1>;
> +               states = <3300000 1
> +                         1800000 0>;

I know this is how it's done in the example in
Documentation/devicetree/bindings/regulator/gpio-regulator.txt,
but usually brackets are used to group tuples, like:

    states = <3300000 1>, <1800000 0>;

Perhaps the example should be changed?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
