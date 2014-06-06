From: horms@verge.net.au (Simon Horman)
Date: Fri, 6 Jun 2014 19:14:22 +0900
Subject: [PATCH 00/08] ARM: shmobile: Rework include path (Try 2, Part 1)
In-Reply-To: <CAMuHMdWuaeZOAA-=k7nHQafxJh7h-jQqtfEGJKiEmraZXu2p+g@mail.gmail.com>
References: <20140520075949.13851.42995.sendpatchset@w520>
 <CAMuHMdWuaeZOAA-=k7nHQafxJh7h-jQqtfEGJKiEmraZXu2p+g@mail.gmail.com>
Message-ID: <20140606101421.GA7971@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 11:11:46AM +0200, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Tue, May 20, 2014 at 9:59 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > ARM: shmobile: Rework include path (Try 2, Part 1)
> >
> > [PATCH 01/08] ARM: shmobile: Move intc.h, cleanup sh_intc.h usage
> > [PATCH 02/08] ARM: shmobile: Move dma-register.h
> > [PATCH 03/08] ARM: shmobile: Move clock.h
> > [PATCH 04/08] ARM: shmobile: Move most of irqs.h, keep some for pinctl
> > [PATCH 05/08] ARM: shmobile: Move common.h
> > [PATCH 06/08] ARM: shmobile: Move pm-rmobile.h, cleanup sh73xx.h
> > [PATCH 07/08] ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
> > [PATCH 08/08] ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case
> >
> > Olof, here my latest take on the header move that you requested earlier.
> >
> > This particular series hopefully follows your proposed way and moves the
> > most common shared header files for mach-shmobile from <mach/foobar.h>
> > to "foobar.h" without any workaround. Left are still per-SoC header files
> > that will be moved once I know you are comformatble with this format.
> 
> Olof didn't scream, so I guess he's comfortable with it? :-)
> Olof?

I'd value a nod or otherwise from Olof before merging this.

> If the propagation part is an issue, what about Simon applying it to a separate
> branch, to be merged into both soc-for-v3.17 and boards-for-v3.17?

Yes, I think this will need to go into a cleanup branch
which soc-for-v3.17 and boards-for-v3.17? are rebased on top of.

I believe this is a project for which I will need strong coffee as an assistant.

> > Please note that these are only lightly compile tested with a handful
> > of defconfigs, but any potential issue should be trivial to fix.
> 
> Indeed. And it touches arch/arm/mach-shmobile only.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> > Also, there are certain bits of arch/arm/mach-shmobile/include/mach/
> > get included from places like arch/arm/boot/compressed/ (booting
> > legacy kernel directly from reset vector) and also from SoC specific
> > legacy code under drivers/pinctrl. My proposal is to keep those users
> > as-is until we phase out legacy board support (2-3 kernels?), let me
> > know if you would like to get rid of "include/mach" sooner!
> 
> It seems you forgot r7s72100.h, r8a73a4.h, and sh73a0.h?
> Can just be moved, with #include update.
> 
> Remaining are lots of files only used by arch/arm/boot, so I'd move those
> (mmc*, sdhi*, zboot*) into .../boot.
> 
> mach/system.h seems to be unused?
> 
> The parts of irqs.h needed for legacy pinctrl can be extracted into
> drivers/pinctrl/sh-pfc/irqs_legacy.h, to be removed later.
> After that irqs.h can move, too.
> 
> After that, we can see what's left...
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
