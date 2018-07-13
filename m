From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Jul 2018 09:57:43 +0200
Subject: [PATCH/RFC] ARM: shmobile: Always enable ARCH_TIMER on SoCs with
 A7 and/or A15
In-Reply-To: <CANqRtoTuofutGtWycNcHq+rPzHqAsjy8ZY0W0k9m_SNWnOajVg@mail.gmail.com>
References: <20180712160857.31471-1-geert+renesas@glider.be>
 <CANqRtoTuofutGtWycNcHq+rPzHqAsjy8ZY0W0k9m_SNWnOajVg@mail.gmail.com>
Message-ID: <CAMuHMdVsASDbnk-8CtgZu6g5JYCVpj2eF4qFCy7q6bzBr1OEoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Fri, Jul 13, 2018 at 5:11 AM Magnus Damm <magnus.damm@gmail.com> wrote:
> On Fri, Jul 13, 2018 at 1:08 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > R-Mobile APE6, R-Car Gen2, and RZ/G1 SoCs have Cortex-A7 and/or
> > Cortex-A15 CPU cores, all of which have ARM architectured timers.
> >
> > Force use of the ARM architectured timer on these SoCs.
> > This allows to:
> >   - Remove the calls to shmobile_init_delay() from the corresponding
> >     machine vectors,
> >   - Remove a check in timer setup specific to R-Car Gen2,
> >   - Remove a check in shmobile_init_delay().
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > We still need shmobile_init_delay to setup loops-per-jiffies for the
> > other SoCs.  But perhaps we can use the Cortex-A9 global timer on those?
>
> Perhaps unrelated, but on older kernels with Cortex-A9 the TWD timer
> was only available when using SMP. So historically on our single-core
> systems (with CA8 or CA9 or when using CA9 multi core with maxcpus=1)
> we had no timer available unless we also used a CMT/TMU or similar.
>
> Exactly what the level of software support is available for the ARM
> timers at this point I'm not so sure about.

Using the TWD timer indeed has two issues:
  - It's available on multi-core Cortex-A9 SoCs only,
  - Its driver does not call register_current_timer_delay(), so it doesn't set
    up lpj_fine for skipping loop calibration.

The global timer driver does call register_current_timer_delay(), but so far no
Renesas SoCs describe its presence in DT.

At least SH-Mobile AG5 and R-Car M1A and H1 seem to have it.
RZ/A1 (and A2) and R-Mobile A1 don't seem to have it, though.
Perhaps the call to register_current_timer_delay() could be added to
the RZ/A OSTM driver?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
