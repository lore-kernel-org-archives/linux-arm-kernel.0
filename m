From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Aug 2018 10:16:16 +0200
Subject: [PATCH V2] ARM: dts: silk: Add DA9063 PMIC node
In-Reply-To: <20180804163818.23360-1-marek.vasut+renesas@gmail.com>
References: <20180804163818.23360-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdU8=pb1V9gPxTe6JX5waXr0aRg5PW6t_bDY2fij0PVr5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sat, Aug 4, 2018 at 6:38 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> Add DA9063 PMIC node to the I2C bus.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc at vger.kernel.org
> ---
> V2: - Replace shmobile with dts since it's a DT patch in subject
>     - Connect the 9063_IRQ# line to GP3_31
>     - Since the DA9063 is connected to both i2c1 and i2c7, connect
>       it to i2c7, which is the dedicated dvfs i2c.

Thanks for the update!

> --- a/arch/arm/boot/dts/r8a7794-silk.dts
> +++ b/arch/arm/boot/dts/r8a7794-silk.dts
> @@ -405,6 +405,23 @@
>         clock-frequency = <400000>;
>  };
>
> +&i2c7 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +
> +       pmic at 58 {
> +               compatible = "dlg,da9063";
> +               reg = <0x58>;
> +               interrupt-parent = <&gpio3>;
> +               interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
> +               interrupt-controller;
> +
> +               wdt {
> +                       compatible = "dlg,da9063-watchdog";
> +               };

Given Silk has the full da9063 (unlike the "L" version on Porter), shouldn't
you add an rtc subnode?

Oh, Silk also has the onkey pin wired, so perhaps you want to add an onkey
subnode, too? Does that feature work?

BTW, Stout also has the onkey wired, but lacks the onkey subnode.

> +       };
> +};
> +

Nevertheless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
