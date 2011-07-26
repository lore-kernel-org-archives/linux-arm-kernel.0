From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jul 2011 19:39:58 +0100
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH
	2/2] GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO
	controller)
In-Reply-To: <CAMbhsRRr5FPtu-kUbcLO56=rsHkb2XNDf21-G3pymPBTcmYmRQ@mail.gmail.com>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<1311667993-27189-3-git-send-email-bs14@csr.com>
	<20110726100928.GO9653@n2100.arm.linux.org.uk>
	<20110726104628.GP9653@n2100.arm.linux.org.uk>
	<CAMbhsRRr5FPtu-kUbcLO56=rsHkb2XNDf21-G3pymPBTcmYmRQ@mail.gmail.com>
Message-ID: <20110726183958.GG1655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 11:32:22AM -0700, Colin Cross wrote:
> On Tue, Jul 26, 2011 at 3:46 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jul 26, 2011 at 11:09:28AM +0100, Russell King - ARM Linux wrote:
> >> Hmm, yet another trivial gpio implementation. ?We have 24 others just like
> >> this. ?Well, mainline does... I have just one. ?Patches after the merge
> >> window closes.
> >
> > As an additional note to this: we _really_ need to get on top of the
> > includes of mach/gpio.h rather than linux/gpio.h - there are around 139
> > files in mainline (this morning) which include mach/gpio.h directly.
> >
> > There's one which includes both asm/gpio.h and mach/gpio.h, which is
> > silly when you look at what asm/gpio.h contains - maybe one attempt
> > to include mach/gpio.h wasn't enough!
> >
> > These includes get in the way of consolidating stuff out of mach/gpio.h
> > into asm/gpio.h - moving stuff out of mach/gpio.h could take it out of
> > view of these files, thereby causing build errors.
> >
> > What is even less clear is whether changing these mach/gpio.h includes
> > to linux/gpio.h is correct or not.
> >
> > So, what I'd like all platform and all soc maintainers to do is to:
> >
> > ? ? ? ?grep -rl '<mach/gpio.h>' arch/arm drivers
> >
> > and investigate their files from that list which they're responsible for,
> > and submit patches to _me_ to fix these includes up (preferably to use
> > linux/gpio.h). ?I'd also like them to do a better job at spotting these
> > while reviewing patches on the list to help reduce new occurances of
> > this.
> >
> > Thanks.
> 
> Tegra has four uses of mach/gpio.h:
> arch/arm/mach-tegra/board-trimslice-pinmux.c
> arch/arm/mach-tegra/board-paz00.c
> arch/arm/mach-tegra/board-trimslice.c
> drivers/mmc/host/sdhci-tegra.c
> 
> Each of these files calls tegra_gpio_enable/tegra_gpio_disable, which
> flip the pin in/out of gpio mode.  Including linux/gpio.h and
> mach/gpio.h was deliberate, so that when linux/gpio.h stops causing
> mach/gpio.h to be included, the tegra gpio apis are still available.
> Should I move the tegra gpio apis to a separate include and drop
> mach/gpio.h?

I don't think there's any plans to break the:

linux/gpio.h -> asm/gpio.h -> mach/gpio.h

include path at the moment, as platforms do define ARCH_NR_GPIO,
which has to be done before asm-generic/gpiolib.h is included.

The problem which is there at the moment is that moving stuff out of
mach/gpio.h is *dangerous* because soo much stuff includes mach/gpio.h,
it's impossible to tell whether moving stuff like gpio_set_value,
gpio_get_value, etc into asm/gpio.h is going to break anything - and
there's no way I can get sufficient coverage to check that.

So, the only way I can think of sorting this out is to forcefully
change all mach/gpio.h to be linux/gpio.h first, before starting
to migrate stuff out of mach/gpio.h.

What we may do later is make the include of mach/gpio.h conditional,
and those platforms with their own specific stuff would continue to
include that.  Those which don't need mach/gpio.h can then live on
without it.
