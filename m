From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 22 Jun 2018 08:27:46 +0200
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <TY1PR01MB1562B232625397CCACD5931A8A760@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
 <nycvar.YSQ.7.76.1806211212010.16670@knanqh.ubzr>
 <TY1PR01MB1562B232625397CCACD5931A8A760@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Message-ID: <CAMuHMdXPiDGg+S3VQutSYSBwBbjW_wV+nTSBHuu7a3VNTghm1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Thu, Jun 21, 2018 at 6:45 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Thursday, June 21, 2018 1, Nicolas Pitre wrote:
> > > I've just sent a patch to do that.
> >
> > Your patch isn't wrong per se.  But it is not enough. The issue here
> > would be easily fixed with some kconfig extension so that:
> >
> > - If XIP or NOMMU is selected then only one target in the multiplatform
> >   set can be selected, basically turning it into a choice menu.
> >
> > - If more than one multiplatform targets is selected then XIP and NOMMU
> >   can no longere be selected.
>
> Over the years I tried to tackle this issue in multiple different ways,
> while still staying in the limitations of kbuild.
> Basically, everything was shot down for one reason or another (or the
> only way to do it is really ugly...so I didn't even ask).
>
> kbuild doesn't really have a mutually exclusive property that can be
> dynamically set/cleared.
>
> In the end, I saw only 2 paths for adding XIP to ARM MMU builds:
>
> 1) Modify kbuild to give the ability as stated above.

Would that actually help, or would it only give you a false feeling of safety?
Most "multiplatform" sub-architectures (like iMX or "shmobile") still have
multiple families and SoCs, so you have to repeat the exercise at that level.

Still, even when configuring a kernel for a single SoC, the final board
selection is at the DTS level.

Conclusion: If you want NOMMU and/or XIP, you have to know what you're doing,
and hand-holding at whatever level may not save you from making mistakes.

> 2) Make XIP builds somehow be able to run at multiple physical address
> by modifying the binaries post-build (Arnd's suggestion).

That's actually an interesting one: no manual configuration (iff parameters
would be extracted from the DTB), so nothing can go wrong ;-)
I guess it applies to NOMMU, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
