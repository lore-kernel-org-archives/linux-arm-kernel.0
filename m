From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 31 Oct 2012 11:56:29 +0000
Subject: [PATCH 1/3] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <50906B16.8060204@gmail.com>
References: <1351608860-24617-1-git-send-email-robherring2@gmail.com>
 <1351608860-24617-2-git-send-email-robherring2@gmail.com>
 <20121030160129.7e39619b@skate> <508FFADC.3080506@gmail.com>
 <50900C90.7070101@gmail.com>
 <20121030224703.GI21164@n2100.arm.linux.org.uk>
 <50906B16.8060204@gmail.com>
Message-ID: <20121031115627.GA9123@localhost.conference>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 12:04:38AM +0000, Rob Herring wrote:
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

In my sample ARMv8 model code I have an older version of gic.c moved to
drivers/irqchip and modified just for the arm64 needs. The gic_of_init()
function calls set_smp_cross_call(git_raise_softirq).

http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-aarch64.git;a=commitdiff;h=5cd20480f4d7b56160b3312df14fba3b2bda6798

The gic_secondary_init() is done from a CPU notifier as I wanted to
separate this from the SoC code (even on arch/arm, all the calls to
gic_secondary_init() are the same, so it could be factored out to a
notifier or some function pointer set by gic.c).

And let's assume there is no need for gic_cascade_irq().

-- 
Catalin
