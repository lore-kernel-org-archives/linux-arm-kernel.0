From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 23 Mar 2014 12:32:05 +0100
Subject: [PATCH 10/62] ARM: efm32: select AUTO_ZRELADDR
In-Reply-To: <201403221027.10332.arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <20140321185430.GG23076@pengutronix.de>
 <CAL_Jsq+vd6dqQgfJsS3sfCOhu7qCpPdcmrXPhC33zym2R9J=rQ@mail.gmail.com>
 <201403221027.10332.arnd@arndb.de>
Message-ID: <20140323113205.GI23076@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 10:27:09AM +0100, Arnd Bergmann wrote:
> On Friday 21 March 2014, Rob Herring wrote:
> > On Fri, Mar 21, 2014 at 1:54 PM, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Mar 21, 2014 at 04:10:37PM +0100, Arnd Bergmann wrote:
> > >> I don't see a reason to change the existing logic, it works for
> > >> both MMU and NOMMU kernels, and you are talking about three instructions
> > >> here.
> > > it doesn't matter how many instructions are involved. The relevant
> > > difference is that with my approach you fix the problem for all no-MMU
> > > platforms, with yours you only fix efm32. (OK, I think there are not too
> > > many no-MMU platforms, but still.) An even easier implementation would
> > > be to add something like:
> > >
> > >         ifeq($(zreladdr-y)$(CONFIG_MMU),)
> > >         zreladdr-y := CONFIG_PAGE_OFFSET + CONFIG_TEXT_OFFSET
> > >         endif
> > >
> > > to arch/arm/boot/Makefile.
> 
> This makes sense, we can add it as soon as we have a use for it. At the
> moment, the only problem we have is a randconfig build error, and the
> obvious change I proposed should work just fine.
My suggestion is an alternative fix for the randconfig error you see, so
there is a use already now. I fail to compile a zImage for different
reasons on top of next, but maybe this works instead of your patch:

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index ec2f8065f955..2d935dd098e5 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -15,6 +15,10 @@ ifneq ($(MACHINE),)
 include $(srctree)/$(MACHINE)/Makefile.boot
 endif
 
+ifeq ($(zreladdr-y)$(CONFIG_MMU),)
+zreladdr-y := $(CONFIG_PAGE_OFFSET)+$(TEXT_OFFSET)
+endif
+
 # Note: the following conditions must always be true:
 #   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
 #   PARAMS_PHYS must be within 4MB of ZRELADDR

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
