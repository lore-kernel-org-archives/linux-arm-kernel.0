From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 18 Feb 2018 16:07:51 +0100
Subject: [PATCH] ARM: dts: porter: Add missing PMIC nodes
In-Reply-To: <20180217020756.21474-1-marek.vasut+renesas@gmail.com>
References: <20180217020756.21474-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdUiGAV7r55mqRH549BufDsh8_j8_S-BD_49sCM=aO9hZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

CC Steve Twiss

On Sat, Feb 17, 2018 at 3:07 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Add PMIC nodes to Porter and connect CPU DVFS supply. There is
> one DA9063 and one DA9210 on Porter, the only difference from
> the other boards is that DA9063 is at I2C address 0x5a rather
> than 0x58 .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r8a7791-porter.dts
> +++ b/arch/arm/boot/dts/r8a7791-porter.dts
> @@ -354,10 +354,47 @@
>         clock-frequency = <400000>;
>  };
>
> +&i2c6 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +
> +       pmic at 5a {
> +               compatible = "dlg,da9063";

Does it matter that this is a DA9063L ("Variant 6B")?
Do we need a new compatible value, or can this be detected at runtime?

> +               reg = <0x5a>;
> +               interrupt-parent = <&irqc0>;
> +               interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +               interrupt-controller;
> +
> +               rtc {
> +                       compatible = "dlg,da9063-rtc";
> +               };
> +
> +               wdt {
> +                       compatible = "dlg,da9063-watchdog";
> +               };
> +       };
> +
> +       vdd_dvfs: regulator at 68 {
> +               compatible = "dlg,da9210";
> +               reg = <0x68>;
> +               interrupt-parent = <&irqc0>;
> +               interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +
> +               regulator-min-microvolt = <1000000>;
> +               regulator-max-microvolt = <1000000>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };
> +};
> +
>  &sata0 {
>         status = "okay";
>  };
>
> +&cpu0 {
> +       cpu0-supply = <&vdd_dvfs>;
> +};
> +
>  /* composite video input */
>  &vin0 {
>         status = "okay";

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
