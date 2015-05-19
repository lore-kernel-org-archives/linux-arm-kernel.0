From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 13:50:05 +0200
Subject: [PATCH v7 08/13] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <bb773210f5f7068a8cba2c283422676c@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
 <20150519101615.GA2067@n2100.arm.linux.org.uk>
 <bb773210f5f7068a8cba2c283422676c@agner.ch>
Message-ID: <2419398.cbLWQC7K5f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 13:23:22 Stefan Agner wrote:
> On 2015-05-19 12:16, Russell King - ARM Linux wrote:
> > On Tue, May 19, 2015 at 01:35:03PM +0800, Shawn Guo wrote:
> >> On Mon, May 18, 2015 at 05:36:43PM +0200, Thomas Gleixner wrote:
> >> > On Sun, 17 May 2015, Thomas Gleixner wrote:
> >> > > I'm going to apply the irq core and chip driver modifications to a
> >> > > separate branch later today, so you or ARM-SOC folks can pull that
> >> > > in. Will send you a mail where it can be found.
> >> >
> >> >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-arm
> >> >
> >> > That contains the first 5 patches which touch kernel/irq/ and
> >> > drivers/irqchip/
> >>
> >> Russell, Arnd,
> >>
> >> I guess the easiest way to merge rest of the series is to have them go
> >> via i.MX tree with your nods?

Yes, that would be good.

> > I don't know, I've not looked at the remainder of the patches.  Having
> > looked briefly at them, it looks like they touch EFM32 as well, so I'm
> > not sure having them all go through iMX is the right approach either.
> > 
> > Looking at the EFM32 patch, it looks like we've adopted my suggestion
> > (discussed with Arnd in the previous month) wrt noMMU, so I'll post a
> > couple of patches in a moment which fix Integrator for this as well.
> > Integrator is independent of this series, and it fixes real problems
> > caused by the single zImage stuff for noMMU there.
> > 
> > It makes sense for these to all go through arm-soc - but the question
> > is how do we get them all into arm-soc...
> 
> Sorry for the mess, I see, I should have tried split it in pieces which
> match the subsystems.
> 
> Patch 06 defines a smaller vector table size, which is by default too
> large. Hence this patch is quite independent, the rest of the patch set
> works flawless without that patch. However, that patch relies on 8340/1
> being applied ("ARM: ARMv7-M: Enlarge vector table up to 256 entries").
> If this is ok for you Russel, I would submit that to your patch system.
> 
> Patch 07 defines dependencies a bit more explicitly, however, with the
> current Kconfig symbol setup, both should be selected by other config
> symbols (CLKSRC_OF by ARM_SINGLE_ARMV7M and CLKSRC_MMIO by ARCH_MXC).
> Hence this can go independently through clocksource trees
> (Daniel/Thomas?)
> 
> Not sure how we can deal with the EFM32 vs. IMX changes... Patches 08-10
> has no dependencies on the clock changes which Thomas merged. They could
> go through whatever EFM32 is merged normally (last time Arnd directly
> merged from Uwe), and then Shawn could base the rest of the changes on
> that too?

Do you have a dependency on patch 10 (the one for EFM32) in your later
patches?

If not, you can send the other ones to Shawn, so I pull them as
a branch, and then I apply that on top of the merges. I have also
merged two other ARMv7M platforms for 4.2 now (both in next/soc),
so we should do the same change for those as well, and I'd rather
apply a patch for that, than merge a branch that is based on
next/soc.

	Arnd
