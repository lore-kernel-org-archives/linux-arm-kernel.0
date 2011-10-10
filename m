From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 10 Oct 2011 12:52:05 +0100
Subject: [PATCH 2/9] ARM: SPMP8000: Add machine base files
In-Reply-To: <CAGVye5NYE+CUbAAtwuP6JWG3HDP-bYs2dVqkuX_iYVGmKq6aWA@mail.gmail.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-3-git-send-email-zoss@devai.org>
	<20111009172232.GB18424@gallagher>
	<CAGVye5NYE+CUbAAtwuP6JWG3HDP-bYs2dVqkuX_iYVGmKq6aWA@mail.gmail.com>
Message-ID: <20111010115205.GG2561@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 01:36:09PM +0200, Zoltan Devai wrote:
> 2011/10/9 Jamie Iles <jamie@jamieiles.com>:
> > A couple of minor comments inline but this looks really good!
> Thanks for reviewing! Comments inline.
> 
> > On Sun, Oct 09, 2011 at 06:36:05PM +0200, Zoltan Devai wrote:
[...]
> >> +#ifdef CONFIG_DEBUG_LL
> >> + ? ? {
> >> + ? ? ? ? ? ? .virtual ? ? ? ?= IO_ADDRESS(SPMP8000_UARTC0_BASE),
> >> + ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(SPMP8000_UARTC0_BASE),
> >> + ? ? ? ? ? ? .length ? ? ? ? = SPMP8000_UARTC0_SIZE,
> >> + ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
> >> + ? ? },
> >> +#endif
> >> +};
> >> +
> >> +#define IO_PTR(x) ? ?((void __iomem *)IO_ADDRESS(x))
> >
> > Generally IO_ADDRESS returns a void __iomem pointer so it would be
> > easier if you could have the cast in there (though it may need to be
> > enclosed in #ifndef __ASSEMBLY__ conditionals).
> Every instance I've seen returns an int, mainly because it's used for
> the static mappings above.
> So, if I make IO_ADDRESS return void __iomem, I'd have to make
> a macro for casting it back to int, and we'd be where we started.

Yes, you're quite right!

[...]
> >> +
> >> +#ifndef __MACH_SPMP8000_DMA_H__
> >> +#define __MACH_SPMP8000_DMA_H__
> >> +
> >> +enum spmp8000_dma_controller {
> >> + ? ? SPMP8000_APBDMA_A ? ? ? = 0,
> >> + ? ? SPMP8000_APBDMA_C,
> >> +};
> >> +
> >> +extern char *spmp8000_dma_controller_names[];
> >> +
> >> +struct spmp8000_dma_params {
> >> + ? ? char ? ? ? ? ? ? ? ? ? ? ? ? ? ?*dma_controller;
> >> + ? ? dma_addr_t ? ? ? ? ? ? ? ? ? ? ?dma_address;
> >> + ? ? enum dma_slave_buswidth ? ? ? ? dma_width;
> >> + ? ? int ? ? ? ? ? ? ? ? ? ? ? ? ? ? maxburst;
> >> +};
> >
> > dmaengine has dma_slave_config that could be used for this, but I don't
> > see any of this file being used in this series so perhaps it's worth
> > adding in after the core stuff has been merged?
> Will split.
> This struct is used by the i2s driver to pass info to the pcm driver on how
> to set up the dma controller. Seems to be the way to do.

OK, so this is platform data for the i2s driver?

> Which tree and branch should I base my work on ?
> I'm quite confused by the all the options, and it seems like
> if I choose some devel-stable tree, then I don't get the new
> features and my work is outdated from the beginning,
> but for-next branches are quite diverged.
> Is there a good strategy ?

That's a tricky one.  I have a similar problem, and rightly or wrongly I 
generally put most of the stuff I can based of off an -rc tag from 
Linus' tree then merge in the others during testing.  As long as those 
get merged first you don't need to do anything else, but it does get a 
bit fiddly.

> >> diff --git a/arch/arm/mach-spmp8000/include/mach/system.h
> >> b/arch/arm/mach-spmp8000/include/mach/system.h
> >> new file mode 100644
> >> index 0000000..be53ff3
> >> --- /dev/null
> >> +++ b/arch/arm/mach-spmp8000/include/mach/system.h
> >> @@ -0,0 +1,45 @@
> >> +/*
> >> + * SPMP8000 system.h
> >> + *
> >> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
> >> + *
> >> + * This file is licensed under the terms of the GNU General Public
> >> + * License version 2. This program is licensed "as is" without any
> >> + * warranty of any kind, whether express or implied.
> >> + */
> >> +
> >> +#ifndef __MACH_SPMP8000_SYSTEM_H__
> >> +#define __MACH_SPMP8000_SYSTEM_H__
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/io.h>
> >> +
> >> +#define SPMP8000_WDT_BASE ? ?0x90001000
> >> +#define SPMP8000_WDT_SIZE ? ?0x1000
> >> +
> >> +#define SPMP8000_WDT_CTR ? ? 0x00
> >> +#define SPMP8000_WDT_CTR_TE ?BIT(0)
> >> +#define SPMP8000_WDT_CTR_RE ?BIT(3)
> >> +
> >> +static inline void arch_idle(void)
> >> +{
> >> + ? ? cpu_do_idle();
> >> +}
> >> +
> >> +static inline void arch_reset(char mode, const char *cmd)
> >> +{
> >> + ? ? void *base;
> >> +
> >> + ? ? base = ioremap(SPMP8000_WDT_BASE, SPMP8000_WDT_SIZE);
> >> + ? ? if (!base) {
> >> + ? ? ? ? ? ? pr_err("spmp8000: Can't ioremap watchdog regs for reset. "
> >> + ? ? ? ? ? ? ? ? ? ? "Halt.");
> >> + ? ? ? ? ? ? while (1);
> >> + ? ? }
> >
> > It may be worth doing the ioremap earlier when the system is in a known
> > good state with all functions available rather than at reset time.
> Any suggestion where the best place would be ?
> I can only think of either the timer init or the board init, but neither seemed
> to be appropriate.

Personally I think having a soc init function that does this sort of 
stuff and gets called from the board init would be suitable for this 
sort of thing.  If the ioremap() fails you could always fall back to a 
soft reset.

Jamie
