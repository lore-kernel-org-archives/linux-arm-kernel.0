From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 15 Feb 2018 11:14:33 +0100
Subject: [PATCH V2] ARM: shmobile: stout: enable R-Car Gen2 regulator quirk
In-Reply-To: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
References: <20180215100208.24646-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdVO7sxRjj7h=ar+bA8B3Art=Yyyr66cRqC30pw3Zz+Vag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Feb 15, 2018 at 11:02 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Regulator setup is suboptimal on H2 Stout too. The Stout newly has
> two DA9210 regulators, so the quirk is extended to handle another
> DA9210 at i2c address 0x70.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> V2: - Handle another DA9210 at 0x70
>     - Drop explicit board list from the leading comment in the file

Thanks for the update!

> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> @@ -1,9 +1,9 @@
>  /*
>   * R-Car Generation 2 da9063/da9210 regulator quirk
>   *
> - * The r8a7790/lager and r8a7791/koelsch development boards have da9063 and
> - * da9210 regulators.  Both regulators have their interrupt request lines tied
> - * to the same interrupt pin (IRQ2) on the SoC.
> + * Certain Gen2 development boards have an da9063 and one or more da9210
> + * regulators. All of these regulators have their interrupt request lines
> + * tied to the same interrupt pin (IRQ2) on the SoC.
>   *
>   * After cold boot or da9063-induced restart, both the da9063 and da9210 seem
>   * to assert their interrupt request lines.  Hence as soon as one driver
> @@ -59,6 +59,10 @@ static struct i2c_msg da9xxx_msgs[2] = {
                                                      ^^^

>                 .addr = 0x68,
>                 .len = ARRAY_SIZE(da9210_irq_clr),
>                 .buf = da9210_irq_clr,
> +       }, {
> +               .addr = 0x70,
> +               .len = ARRAY_SIZE(da9210_irq_clr),
> +               .buf = da9210_irq_clr,

Does this really work, without increasing the array size from [2] to [3]?

> @@ -85,7 +89,8 @@ static int regulator_quirk_notify(struct notifier_block *nb,
>         dev_dbg(dev, "Detected %s\n", client->name);
>
>         if ((client->addr == 0x58 && !strcmp(client->name, "da9063")) ||
> -           (client->addr == 0x68 && !strcmp(client->name, "da9210"))) {
> +           (client->addr == 0x68 && !strcmp(client->name, "da9210")) ||
> +           (client->addr == 0x70 && !strcmp(client->name, "da9210"))) {
>                 int ret;
>
>                 dev_info(&client->dev, "clearing da9063/da9210 interrupts\n");

As the code now always sends 3 i2c msgs to all 3 possible regulators, we
may accidentally talk to another device at 0x70 on other boards than Stout.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
