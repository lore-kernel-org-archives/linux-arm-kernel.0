From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Jun 2018 15:49:45 +0200
Subject: [PATCH V3] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <967b800e-c935-aa35-da5a-ca3672fd18c2@gmail.com>
References: <20180604175911.799-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdXG6mMfFTz+fdZQ53hLxYgVZPmsGpaRri8TesiruUNYUg@mail.gmail.com>
 <fa4f843b-ae9d-fac2-77e2-b3ac1116f916@gmail.com>
 <CAMuHMdXw146fwm0tHS7CBAofDAgRgDD2tNqgEJwzx0Jm1xKCyw@mail.gmail.com>
 <967b800e-c935-aa35-da5a-ca3672fd18c2@gmail.com>
Message-ID: <CAMuHMdVJ+ad-kr0iYuoaH3chJ49_g6yjEb8PHmTpwjFdYcG4=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Jun 11, 2018 at 3:39 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 06/11/2018 03:03 PM, Geert Uytterhoeven wrote:
> > On Mon, Jun 11, 2018 at 2:15 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> >> On 06/11/2018 11:56 AM, Geert Uytterhoeven wrote:
> >>> On Mon, Jun 4, 2018 at 7:59 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> >>>> Rather than hard-coding the quirk topology, which stopped scaling,
> >>>> parse the information from DT. The code looks for all compatible
> >>>> PMICs -- da9036 and da9210 -- and checks if their IRQ line is tied
> >>>> to the same pin. If so, the code sends a matching sequence to the
> >>>> PMIC to deassert the IRQ.

> >>>> +               ret = of_property_read_u32(np, "reg", &addr);
> >>>> +               if (ret)
> >>>> +                       return ret;
> >>>
> >>> I think it's safer to skip this entry and continue, after calling
> >>> kfree(quirk), of course.
> >>>
> >>>> +
> >>>> +               quirk->id = id;
> >>>> +               quirk->i2c_msg.addr = addr;
> >>>> +               quirk->shared = false;
> >>>> +
> >>>> +               ret = of_irq_parse_one(np, 0, &quirk->irq_args);
> >>>> +               if (ret)
> >>>> +                       return ret;
> >>>
> >>> kfree(quirk) and continue...
> >>
> >> I wonder if it shouldn't rather free the entire list and abort ?
> >
> > "Be strict when sending, be liberal when receiving."
>
> Meaning ? I think "the language barrier is protecting me" (TM)

Do the best you can, given the buggy DT you received.
I.e. don't fail completely, just ignore the bad device node, and continue.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
