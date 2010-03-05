From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Mar 2010 20:43:07 +0000
Subject: [PATCH] ARM: Add Versatile Express CA9x4 processor support
In-Reply-To: <002101cabc5c$81fa5440$85eefcc0$@deacon@arm.com>
References: <git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
	<git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
	<002101cabc5c$81fa5440$85eefcc0$@deacon@arm.com>
Message-ID: <20100305204307.GB4885@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 05, 2010 at 12:08:02PM -0000, Will Deacon wrote:
> The only problem with adding the PMU interrupts here is that
> they are not visible to kernel/pmu.c, which includes <linux/interrupt.h>.
> Adding a conditional #include <mach/ct-ca9x4.h> worked, but it's not
> very nice. Would it be possible to include the tile IRQs in the
> include/mach/irqs.h?

Given that this platform can have multiple different tiles fitted, I
don't think it's correct to publicise the interrupt numbers globally.

Currently, we have the situation where 99.9% of the tile dependencies
are entirely separated from the motherboard - the only exception being
the base of the motherboard IRQ numbers, and the base addresses of
the motherboard CS regions.

It would be better if there was some way to allow board support to
register their individual details with the PMU code.  The fact that
the PMU interrupts on CA9x4 are 92-95 does not mean that on another
Versatile Express tile, they will be the same - and in that case if
you select the interrupts through ifdefs, you're tied to only one
platform inspite of the rest of the kernel image supporting multiple
platforms.
