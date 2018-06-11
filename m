From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Jun 2018 11:56:14 +0200
Subject: [PATCH V3] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <20180604175911.799-1-marek.vasut+renesas@gmail.com>
References: <20180604175911.799-1-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdXG6mMfFTz+fdZQ53hLxYgVZPmsGpaRri8TesiruUNYUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Jun 4, 2018 at 7:59 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> Rather than hard-coding the quirk topology, which stopped scaling,
> parse the information from DT. The code looks for all compatible
> PMICs -- da9036 and da9210 -- and checks if their IRQ line is tied

da9063

> to the same pin. If so, the code sends a matching sequence to the
> PMIC to deassert the IRQ.

Note that not all R-Car Gen2 boards have all regulators described in DT yet.
E.g. gose lacks da9210. So that has to be fixed first.

>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc at vger.kernel.org
> ---
> V2: - Replace the DT shared IRQ check loop with memcmp()
>     - Send the I2C message to deassert the IRQ line to all PMICs
>       in the list with shared IRQ line instead of just one
>     - Add comment that this works only in case all the PMICs are
>       on the same I2C bus
> V3: - Drop the addr = 0x00 init
>     - Drop reinit of argsa in rcar_gen2_regulator_quirk

Thanks for the update!

> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c

> @@ -44,34 +46,45 @@
>  /* start of DA9210 System Control and Event Registers */
>  #define DA9210_REG_MASK_A              0x54
>
> +struct regulator_quirk {
> +       struct list_head                list;
> +       const struct of_device_id       *id;
> +       struct of_phandle_args          irq_args;
> +       struct i2c_msg                  i2c_msg;
> +       bool                            shared; /* IRQ line is shared */
> +};
> +
> +static LIST_HEAD(quirk_list);
>  static void __iomem *irqc;
>
>  /* first byte sets the memory pointer, following are consecutive reg values */
>  static u8 da9063_irq_clr[] = { DA9063_REG_IRQ_MASK_A, 0xff, 0xff, 0xff, 0xff };
>  static u8 da9210_irq_clr[] = { DA9210_REG_MASK_A, 0xff, 0xff };
>
> -static struct i2c_msg da9xxx_msgs[3] = {
> -       {
> -               .addr = 0x58,
> -               .len = ARRAY_SIZE(da9063_irq_clr),
> -               .buf = da9063_irq_clr,
> -       }, {
> -               .addr = 0x68,
> -               .len = ARRAY_SIZE(da9210_irq_clr),
> -               .buf = da9210_irq_clr,
> -       }, {
> -               .addr = 0x70,
> -               .len = ARRAY_SIZE(da9210_irq_clr),
> -               .buf = da9210_irq_clr,
> -       },
> +static struct i2c_msg da9063_msgs = {

da9063_msg? (it's a single message)

> +       .len = ARRAY_SIZE(da9063_irq_clr),
> +       .buf = da9063_irq_clr,
> +};
> +
> +static struct i2c_msg da9210_msgs = {

da9210_msg?

> +       .len = ARRAY_SIZE(da9210_irq_clr),
> +       .buf = da9210_irq_clr,
> +};

> @@ -122,7 +143,13 @@ static struct notifier_block regulator_quirk_nb = {
>
>  static int __init rcar_gen2_regulator_quirk(void)
>  {
> -       u32 mon;
> +       struct device_node *np;
> +       const struct of_device_id *id;
> +       struct regulator_quirk *quirk;
> +       struct regulator_quirk *pos;
> +       struct of_phandle_args *argsa, *argsb;
> +       u32 mon, addr;
> +       int ret;

Some people prefer "Reverse Christmas Tree Ordering", i.e. longest line first.

>
>         if (!of_machine_is_compatible("renesas,koelsch") &&
>             !of_machine_is_compatible("renesas,lager") &&
> @@ -130,6 +157,45 @@ static int __init rcar_gen2_regulator_quirk(void)
>             !of_machine_is_compatible("renesas,gose"))
>                 return -ENODEV;

I think the board checks above can be removed. That will auto-enable the
fix on e.g. Porter (once its regulators have ended up in DTS, of course).

>
> +       for_each_matching_node_and_match(np, rcar_gen2_quirk_match, &id) {
> +               if (!np || !of_device_is_available(np))

!np cannot happen

> +                       break;
> +
> +               quirk = kzalloc(sizeof(*quirk), GFP_KERNEL);

Missing NULL check

> +
> +               argsa = &quirk->irq_args;
> +               memcpy(&quirk->i2c_msg, id->data, sizeof(quirk->i2c_msg));
> +
> +               ret = of_property_read_u32(np, "reg", &addr);
> +               if (ret)
> +                       return ret;

I think it's safer to skip this entry and continue, after calling
kfree(quirk), of course.

> +
> +               quirk->id = id;
> +               quirk->i2c_msg.addr = addr;
> +               quirk->shared = false;

No need to clear shared, it was cleared by kzalloc().

> +
> +               ret = of_irq_parse_one(np, 0, &quirk->irq_args);
> +               if (ret)
> +                       return ret;

kfree(quirk) and continue...

Works fine on Koelsch, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
