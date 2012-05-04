From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 18:56:08 +0000
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <4FA40642.5040203@gmail.com>
References: <201205031350.35476.arnd@arndb.de>
 <201205041220.24747.arnd@arndb.de> <4FA40642.5040203@gmail.com>
Message-ID: <201205041856.08413.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Rob Herring wrote:
> On 05/04/2012 07:20 AM, Arnd Bergmann wrote:
> > On Thursday 03 May 2012, Russell King - ARM Linux wrote:

> > My plan is to have multiplatform kernels in parallel with what we have now,
> > so we can avoid breaking working machines but also play with multiplatform
> > configurations at the same time for a subset of the platforms and with
> > certain restrictions (not all board files, not all drivers, no generic
> > early printk, ...).
> > 
> 
> Many of the headers are simply platform_data structs which may still be
> needed on DT platforms, but could be moved elsewhere

Yes, as Russell pointed out, these really should go to
include/linux/platform_data/. My patchset take a few shortcuts there right
now, adding an ugly hack to redirect the header files from their current
locations so I can avoid all the hard work to do that.

> > 
> >> We still have irqs.h being SoC dependent, and we still haven't taken
> >> debug-macros.S far enough along to get rid of that.
> > 
> > I believe the irqs.h conflict is only for the NR_IRQS constant, all other
> > defines in there should only be used inside of the mach-* directory,
> > or not at all for fully DT-based platforms.
> 
> A DT-enabled platform does not need irqs.h or NR_IRQS. SPARSE_IRQ should
> be selected for DT. However, some DT enabled platforms don't have all
> irq chips converted to domains and may still need to set the mach .nr_irqs.

Ah, good to know. I hadn't realized that the #include <mach/irqs.h> in asm/irq.h
is already conditional.

	Arnd
