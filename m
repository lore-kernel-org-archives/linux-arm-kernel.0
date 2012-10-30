From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Oct 2012 22:47:03 +0000
Subject: [PATCH 1/3] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <50900C90.7070101@gmail.com>
References: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
 <1351608860-24617-2-git-send-email-robherring2@gmail.com>
 <20121030160129.7e39619b@skate> <508FFADC.3080506@gmail.com>
 <50900C90.7070101@gmail.com>
Message-ID: <20121030224703.GI21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 12:21:20PM -0500, Rob Herring wrote:
> Looking at this some more, arm64 doesn't need most of what's in gic.h.
> The register defines should be moved into the .c file. The remaining
> function declarations either are not needed (i.e. gic_init) or should
> should be done like the handle_irq function pointer init. We don't want
> to have platform code calling gic_cascade_irq or gic_raise_softirq
> directly.

Softirqs are about the SPIs which are used for SMP IPIs and platform
specific wakeup of CPUs.  And platform code _needs_ to specify the
way IPIs are delivered on the platform.  irqchip can't do that because
irqchip knows nothing about SPIs (neither does genirq.)

The thing about gic_cascade_irq() is that it's to do with handling the
(rare) case of having a system with two GICs cascaded together.  There's
only one set of platforms I know of which has that kind of madness and
it's the ARM development platforms, where the baseboard has a GIC, and
the SMP tile has its own GIC as part of the SMP implementation.

Apart from that, gic_cascade_irq() should not be used - it should
probably be ifdef'd out when not on one of the ARM dev platforms which
suffer this weirdness.
