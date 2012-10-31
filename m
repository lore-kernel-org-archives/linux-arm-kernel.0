From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Oct 2012 09:05:09 +0000
Subject: [PATCH 1/3] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <50906B16.8060204@gmail.com>
References: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
 <1351608860-24617-2-git-send-email-robherring2@gmail.com>
 <20121030160129.7e39619b@skate> <508FFADC.3080506@gmail.com>
 <50900C90.7070101@gmail.com> <20121030224703.GI21164@n2100.arm.linux.org.uk>
 <50906B16.8060204@gmail.com>
Message-ID: <20121031090508.GJ21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 07:04:38PM -0500, Rob Herring wrote:
> On 10/30/2012 05:47 PM, Russell King - ARM Linux wrote:
> > On Tue, Oct 30, 2012 at 12:21:20PM -0500, Rob Herring wrote:
> >> Looking at this some more, arm64 doesn't need most of what's in gic.h.
> >> The register defines should be moved into the .c file. The remaining
> >> function declarations either are not needed (i.e. gic_init) or should
> >> should be done like the handle_irq function pointer init. We don't want
> >> to have platform code calling gic_cascade_irq or gic_raise_softirq
> >> directly.
> > 
> > Softirqs are about the SPIs which are used for SMP IPIs and platform
> > specific wakeup of CPUs.  And platform code _needs_ to specify the
> > way IPIs are delivered on the platform.  irqchip can't do that because
> > irqchip knows nothing about SPIs (neither does genirq.)
> 
> Right. v7 is unchanged, so the question is really only about how v8 will
> do this. Hopefully, ARM is standardizing this for v8. We probably want
> the gic (or other irqchip) to setup a raise_softirq function ptr on init
> rather than having a direct call to gic_raise_softirq.

We already have that, except it's up to platforms to setup that pointer
via a function call into the SMP code - it's called set_smp_cross_call().
We could move that into the GIC code, as we don't have anyone with a GIC
which doesn't use gic_raise_softirq.

The only thing to remember is that there's non-SMP platforms with GICs.
