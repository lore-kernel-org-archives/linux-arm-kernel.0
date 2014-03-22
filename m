From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Mar 2014 10:27:09 +0100
Subject: [PATCH 10/62] ARM: efm32: select AUTO_ZRELADDR
In-Reply-To: <CAL_Jsq+vd6dqQgfJsS3sfCOhu7qCpPdcmrXPhC33zym2R9J=rQ@mail.gmail.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <20140321185430.GG23076@pengutronix.de>
 <CAL_Jsq+vd6dqQgfJsS3sfCOhu7qCpPdcmrXPhC33zym2R9J=rQ@mail.gmail.com>
Message-ID: <201403221027.10332.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014, Rob Herring wrote:
> On Fri, Mar 21, 2014 at 1:54 PM, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Mar 21, 2014 at 04:10:37PM +0100, Arnd Bergmann wrote:
> >> I don't see a reason to change the existing logic, it works for
> >> both MMU and NOMMU kernels, and you are talking about three instructions
> >> here.
> > it doesn't matter how many instructions are involved. The relevant
> > difference is that with my approach you fix the problem for all no-MMU
> > platforms, with yours you only fix efm32. (OK, I think there are not too
> > many no-MMU platforms, but still.) An even easier implementation would
> > be to add something like:
> >
> >         ifeq($(zreladdr-y)$(CONFIG_MMU),)
> >         zreladdr-y := CONFIG_PAGE_OFFSET + CONFIG_TEXT_OFFSET
> >         endif
> >
> > to arch/arm/boot/Makefile.

This makes sense, we can add it as soon as we have a use for it. At the
moment, the only problem we have is a randconfig build error, and the
obvious change I proposed should work just fine.

> > But I don't care much, if you still want to make EFM32 select
> > AUTO_ZRELADDR go ahead.
> 
> How about a kconfig fix:
> 
> bool "Auto calculation of the decompressed kernel image address" if MMU
> default y if !MMU

This however would break builds that today for some reason cannot use
AUTO_ZRELADDR on !MMU kernels, i.e. has a funny bootloader that
uses ZBOOT_ROM or other tricks. In principle any platform should
work with MMU disabled (although I'm sure there are tons of bugs),
and not every one uses AUTO_ZRELADDR today. Uwe's suggestion above
takes advantage of the fact that !MMU-kernels know what physical
address they run on.

	Arnd
