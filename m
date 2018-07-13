From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Jul 2018 14:32:46 +0200
Subject: [PATCH/RFC] ARM: shmobile: Always enable ARCH_TIMER on SoCs with
 A7 and/or A15
In-Reply-To: <TY1PR01MB1562D500B559B159DA971B998A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180712160857.31471-1-geert+renesas@glider.be>
 <CANqRtoTuofutGtWycNcHq+rPzHqAsjy8ZY0W0k9m_SNWnOajVg@mail.gmail.com>
 <CAMuHMdVsASDbnk-8CtgZu6g5JYCVpj2eF4qFCy7q6bzBr1OEoA@mail.gmail.com>
 <TY1PR01MB1562D500B559B159DA971B998A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Message-ID: <CAMuHMdVNvOP7NymwuiJ0fZdzCF9ijKzhm2sfgptOOiHBj2SCWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Fri, Jul 13, 2018 at 2:22 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Friday, July 13, 2018, linux-renesas-soc-owner at vger.kernel.org wrote:
> > > Exactly what the level of software support is available for the ARM
> > > timers at this point I'm not so sure about.
> >
> > Using the TWD timer indeed has two issues:
> >   - It's available on multi-core Cortex-A9 SoCs only,
> >   - Its driver does not call register_current_timer_delay(), so it doesn't
> > set
> >     up lpj_fine for skipping loop calibration.
> >
> > The global timer driver does call register_current_timer_delay(), but so
> > far no
> > Renesas SoCs describe its presence in DT.
> >
> > At least SH-Mobile AG5 and R-Car M1A and H1 seem to have it.
> > RZ/A1 (and A2) and R-Mobile A1 don't seem to have it, though.
> > Perhaps the call to register_current_timer_delay() could be added to
> > the RZ/A OSTM driver?
>
> For RZ/A1, technically you could use MTU2 or OSTM as your system timer.
> However, no one would every use MTU2 because OSTM is way more accurate.
>
> Regardless, would we always call register_current_timer_delay() from the
> OSTM driver?
> Note that there are 2 OSTM channels on RZ/A1. The first one is loaded as
> a clocksource, the second is used as an event counter. Would we call
> register_current_timer_delay() for both instances?

For the clocksource only.
Note that register_current_timer_delay() has some protection against
multiple callers, and picks up the best timer found.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
