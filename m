From: rabin@rab.in (Rabin Vincent)
Date: Sun, 25 Oct 2015 23:32:52 +0100
Subject: Build regressions/improvements in v4.3-rc7
In-Reply-To: <CAMuHMdUkNad7-zHSEfy__rPXKV2t0_7O+MtHiW1hUN=t30KWoA@mail.gmail.com>
References: <1445767971-22415-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdX9X8SRCA4K++LvRz1sK3Ewyj5wKbvrdAy06L6v2XTduA@mail.gmail.com>
 <CAMuHMdUkNad7-zHSEfy__rPXKV2t0_7O+MtHiW1hUN=t30KWoA@mail.gmail.com>
Message-ID: <20151025223252.GB5635@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2015 at 11:39:15AM +0100, Geert Uytterhoeven wrote:
> On Sun, Oct 25, 2015 at 11:18 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Sun, Oct 25, 2015 at 11:12 AM, Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >> JFYI, when comparing v4.3-rc7[1] to v4.3-rc6[3], the summaries are:
> >>   - build errors: +12/-4

>From the quoted lines above one I got the impression that this was a
regression from v4.3-rc6 to 4.3-rc7, but that's not the case.  The
failing config also fails with v4.3-rc6.  It is however a regression
from v4.2 to v4.3-rc1, and started failing after the changes in
a5f4c561b3b19a ("ARM: 8415/1: early fixmap support for earlycon").

> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_DIRTY' undeclared (first use in this function):  => 39:2
> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_MT_WRITEBACK' undeclared (first use in this function):  => 39:2
> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_PRESENT' undeclared (first use in this function):  => 39:2
> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_XN' undeclared (first use in this function):  => 39:2
> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_YOUNG' undeclared (first use in this function):  => 39:2
> 
> Caused by:
> 
> commit ab0615e2d6fb074764a3e4d05f1326fa2fdb4627
> Author: Rabin Vincent <rabin@rab.in>
> Date:   Thu Apr 24 23:28:57 2014 +0200
> 
>     arm: use fixmap for text patching when text is RO
> 
> Should the call to set_fixmap() in arch/arm/kernel/patch.c
> just be protected by #ifdef CONFIG_MMU?

Yes, and the call to clear_fixmap() too.  This part of the code will
never actually be called on !MMU because patch_map() will always exit
early with nothing to remap.  Will you send a patch?

(More code can be ifdef'd out to make a cleaner solution but I think that
 really needs a simplification of the locking to be done first, which is
 bit much for a late -rc.)
