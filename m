From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Jun 2018 15:03:30 +0200
Subject: [PATCH V3] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <fa4f843b-ae9d-fac2-77e2-b3ac1116f916@gmail.com>
References: <20180604175911.799-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdXG6mMfFTz+fdZQ53hLxYgVZPmsGpaRri8TesiruUNYUg@mail.gmail.com>
 <fa4f843b-ae9d-fac2-77e2-b3ac1116f916@gmail.com>
Message-ID: <CAMuHMdXw146fwm0tHS7CBAofDAgRgDD2tNqgEJwzx0Jm1xKCyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Jun 11, 2018 at 2:15 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 06/11/2018 11:56 AM, Geert Uytterhoeven wrote:
> > On Mon, Jun 4, 2018 at 7:59 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> >> Rather than hard-coding the quirk topology, which stopped scaling,
> >> parse the information from DT. The code looks for all compatible
> >> PMICs -- da9036 and da9210 -- and checks if their IRQ line is tied
> >
> > da9063
> >
> >> to the same pin. If so, the code sends a matching sequence to the
> >> PMIC to deassert the IRQ.

> >> @@ -122,7 +143,13 @@ static struct notifier_block regulator_quirk_nb = {
> >>
> >>  static int __init rcar_gen2_regulator_quirk(void)
> >>  {
> >> -       u32 mon;
> >> +       struct device_node *np;
> >> +       const struct of_device_id *id;
> >> +       struct regulator_quirk *quirk;
> >> +       struct regulator_quirk *pos;
> >> +       struct of_phandle_args *argsa, *argsb;
> >> +       u32 mon, addr;
> >> +       int ret;
> >
> > Some people prefer "Reverse Christmas Tree Ordering", i.e. longest line first.
> >
> >>
> >>         if (!of_machine_is_compatible("renesas,koelsch") &&
> >>             !of_machine_is_compatible("renesas,lager") &&
> >> @@ -130,6 +157,45 @@ static int __init rcar_gen2_regulator_quirk(void)
> >>             !of_machine_is_compatible("renesas,gose"))
> >>                 return -ENODEV;
> >
> > I think the board checks above can be removed. That will auto-enable the
> > fix on e.g. Porter (once its regulators have ended up in DTS, of course).
>
> Removing the check would also enable it on boards where we don't want
> this enabled, so I'd prefer to keep the check to avoid strange surprises.

Like, Porter? ;-)

> >> +               ret = of_property_read_u32(np, "reg", &addr);
> >> +               if (ret)
> >> +                       return ret;
> >
> > I think it's safer to skip this entry and continue, after calling
> > kfree(quirk), of course.
> >
> >> +
> >> +               quirk->id = id;
> >> +               quirk->i2c_msg.addr = addr;
> >> +               quirk->shared = false;
> >> +
> >> +               ret = of_irq_parse_one(np, 0, &quirk->irq_args);
> >> +               if (ret)
> >> +                       return ret;
> >
> > kfree(quirk) and continue...
>
> I wonder if it shouldn't rather free the entire list and abort ?

"Be strict when sending, be liberal when receiving."

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
