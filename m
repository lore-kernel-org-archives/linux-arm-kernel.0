From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 3 Aug 2011 22:49:21 +0530
Subject: [PATCH] mach-davinci: fix cache flush build error
In-Reply-To: <20110802160234.GH19079@n2100.arm.linux.org.uk>
References: <1312300118-9088-1-git-send-email-linus.walleij@stericsson.com>
	<20110802160234.GH19079@n2100.arm.linux.org.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DF05E85@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 21:32:34, Russell King - ARM Linux wrote:
> On Tue, Aug 02, 2011 at 05:48:38PM +0200, Linus Walleij wrote:
> > From: Linus Walleij <linus.walleij@linaro.org>
> > 
> > The TNET variant of DaVinci compiles some code that it shares
> > with other DaVinci variants, however it has a V6 CPU rather than
> > an ARM926T, thus the hardcoded call to arm926_flush_kern_cache_all()
> > in sleep.S will obviously fail, and we need to build with the
> > v6_flush_kern_cache_all() call instead. This was triggered by
> > manually altering the DaVinci config to build the TNET version.
> > 
> > Cc: Dave Martin <dave.martin@linaro.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > This is just an ifdef to get the DaVinci TNET variant to compile,
> > if there is a way to call out to some abstract flush function in a
> > MULTI CPU/cache configuration from _assembler_ code, please tell me,
> > 
> > I'm not all that happy about this since it blocks proper multiboard
> > support for DaVinci, would be nice to find a better solution.

This isn't the only thing that prevents building the TNET variant
with the rest of the DaVinci variants.

If you enable DM365 and TNETV107x together, you get errors:

  AS      arch/arm/kernel/entry-armv.o
arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:196: Error: selected processor does not support `strex r1,r2,[sp]'
arch/arm/kernel/entry-armv.S:228: Error: selected processor does not support `strex r1,r2,[sp]'
arch/arm/kernel/entry-armv.S:286: Error: selected processor does not support `strex r1,r2,[sp]'
arch/arm/kernel/entry-armv.S:323: Error: selected processor does not support `strex r1,r2,[sp]'

And from what I read[1], it is futile to try and make v5 and v6 architectures
build together.

> Davinci seems to be a special case where it somehow preserves all state
> even in deep sleep, which makes the generic cpu_suspend() not ideal for
> it.
> 
> Or maybe that's just an oversight in the existing code - I don't know
> so I haven't touched it.  I've been hoping that Davinci people can sort
> it out...

It is true that DaVinci does not lose state even in its lowest power
mode. There are no power domains to switch off in DaVinci. The deep
sleep mode just stops device clocks and on-chip oscillator is shutdown.

Considering this, Linus's patch looks fair to me. If there are no
objections, I will queue for v3.1-rc

Linus, in future can you please CC me and/or Kevin on DaVinci patches?

Thanks,
Sekhar

[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg43834.html
