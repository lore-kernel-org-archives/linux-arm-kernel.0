From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Oct 2015 18:23:57 +0000
Subject: Build regressions/improvements in v4.3-rc7
In-Reply-To: <CAMuHMdVdSa2899nEYq4dg_WghdCWgj4jZqnd_8FE7_221O0CFQ@mail.gmail.com>
References: <1445767971-22415-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdX9X8SRCA4K++LvRz1sK3Ewyj5wKbvrdAy06L6v2XTduA@mail.gmail.com>
 <CAMuHMdUkNad7-zHSEfy__rPXKV2t0_7O+MtHiW1hUN=t30KWoA@mail.gmail.com>
 <20151025140822.GA32532@n2100.arm.linux.org.uk>
 <CAMuHMdVdSa2899nEYq4dg_WghdCWgj4jZqnd_8FE7_221O0CFQ@mail.gmail.com>
Message-ID: <20151025182357.GB32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2015 at 06:38:18PM +0100, Geert Uytterhoeven wrote:
> On Sun, Oct 25, 2015 at 3:08 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sun, Oct 25, 2015 at 11:39:15AM +0100, Geert Uytterhoeven wrote:
> >> On Sun, Oct 25, 2015 at 11:18 AM, Geert Uytterhoeven
> >> <geert@linux-m68k.org> wrote:
> >> > On Sun, Oct 25, 2015 at 11:12 AM, Geert Uytterhoeven
> >> > <geert@linux-m68k.org> wrote:
> >> >> JFYI, when comparing v4.3-rc7[1] to v4.3-rc6[3], the summaries are:
> >> >>   - build errors: +12/-4
> >>
> >> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_DIRTY' undeclared (first use in this function):  => 39:2
> >> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_MT_WRITEBACK' undeclared (first use in this function):  => 39:2
> >> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_PRESENT' undeclared (first use in this function):  => 39:2
> >> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_XN' undeclared (first use in this function):  => 39:2
> >> >   + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_YOUNG' undeclared (first use in this function):  => 39:2
> >>
> >> Caused by:
> >>
> >> commit ab0615e2d6fb074764a3e4d05f1326fa2fdb4627
> >> Author: Rabin Vincent <rabin@rab.in>
> >> Date:   Thu Apr 24 23:28:57 2014 +0200
> >>
> >>     arm: use fixmap for text patching when text is RO
> >>
> >> Should the call to set_fixmap() in arch/arm/kernel/patch.c
> >> just be protected by #ifdef CONFIG_MMU?
> >
> > What this shows, time and time again, is that we need better testing for
> > !MMU platforms - we need !MMU platforms in the mainline kernel which
> > people actually have.
> >
> > I have an OKI 67001 board (from Simtec), which is the older generation of
> > !MMU system, and I have code for it, but arm-soc won't let me put it in
> > the mainline kernel - even though it would give me a platform which I can
> > add to the boot farm to build and boot a test kernel for.
> >
> > Consequently, I've little motivation to catch !MMU regressions before
> > they hit mainline.
> >
> > Should we accept old !MMU code into mainline for platforms which kernel
> > developers have, in order to aid testing, even though it isn't modern
> > platforms and doesn't conform to the latest way of doing stuff.
> 
> I think we should have at least one arm-nommu platform in the upstream kernel,
> with a suitable defconfig, so 0build will catch regressions.

Does it?  Plainly not, because we've had this "noMMU has broken in
mainline" problem many times without it being flagged up before it hits
mainline.

> Alternative, can any of the existing supported arm-mmu platform be used
> with a nommu kernel?

Your choices in my test farm are: OMAP4430 SDP, OMAP3430 LDP, Versatile
Express, and Juno.  I don't think any of these currently have working
noMMU support.

For the OKI, we're talking about this much code in the branch right
now:

 arch/arm/Kconfig                                  |  12 +
 arch/arm/Makefile                                 |   1 +
 arch/arm/boot/bootp/init.S                        |   9 +-
 arch/arm/boot/compressed/misc.c                   |   3 +-
 arch/arm/mach-okiml67x/Kconfig                    |   0
 arch/arm/mach-okiml67x/Makefile                   |   1 +
 arch/arm/mach-okiml67x/Makefile.boot              |   3 +
 arch/arm/mach-okiml67x/core.c                     | 346 ++++++++++++++++++
 arch/arm/mach-okiml67x/core.h                     |   6 +
 arch/arm/mach-okiml67x/include/mach/debug-macro.S |   4 +
 arch/arm/mach-okiml67x/include/mach/entry-macro.S |  21 ++
 arch/arm/mach-okiml67x/include/mach/io.h          |  11 +
 arch/arm/mach-okiml67x/include/mach/irqs.h        |   6 +
 arch/arm/mach-okiml67x/include/mach/memory.h      |   6 +
 arch/arm/mach-okiml67x/include/mach/oki-irq.h     |  21 ++
 arch/arm/mach-okiml67x/include/mach/oki.h         |  56 +++
 arch/arm/mach-okiml67x/include/mach/timex.h       |   6 +
 arch/arm/mach-okiml67x/include/mach/uncompress.h  |   5 +
 drivers/i2c/busses/Kconfig                        |   7 +
 drivers/i2c/busses/Makefile                       |   1 +
 drivers/i2c/busses/i2c-okiml67x.c                 | 268 ++++++++++++++
 drivers/spi/Kconfig                               |   7 +
 drivers/spi/Makefile                              |   1 +
 drivers/spi/spi-okiml67x.c                        | 414 ++++++++++++++++++++++
 24 files changed, 1213 insertions(+), 2 deletions(-)

Drop the I2C and SPI drivers out, and it's under half that - 515 lines.
515 lines to get a noMMU system into my build farm.  Is that really too
expensive if it then provides nightly build coverage and boot testing
for an area of the kernel which keeps getting broken without us
realising before it's hit mainline?

There's a few small fixes that will be required elsewhere (I'm just
building it now) to make buildable with existing mainline - mostly
updates to it's code for recent changes (set_irq_flags conversion,
and fixing a previous commit which removed the #ifndef TASK_SIZE...
#endif around the definition there) and fixing a number of link time
errors around ioport_unmap, ioport_map, and ioport_unmap.

There's an old saying: scratch my back, and I'll scratch your back.
No one's willing to do the little bit which helps to avoid these
build errors happening, so... well, I guess they'll just keep on
happening until people change their minds.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
