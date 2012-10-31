From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Oct 2012 15:54:25 +0000
Subject: [PATCH v2 3/5] irqchip: Move ARM GIC to drivers/irqchip
In-Reply-To: <509146B8.2000305@gmail.com>
References: <1351695517-5636-1-git-send-email-robherring2@gmail.com>
 <1351695517-5636-4-git-send-email-robherring2@gmail.com>
 <20121031150954.GN21164@n2100.arm.linux.org.uk> <509146B8.2000305@gmail.com>
Message-ID: <20121031155425.GP21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 10:41:44AM -0500, Rob Herring wrote:
> On 10/31/2012 10:09 AM, Russell King - ARM Linux wrote:
> > On Wed, Oct 31, 2012 at 09:58:35AM -0500, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> Now that we have drivers/irqchip, move GIC irqchip to drivers/irqchip. This
> >> is necessary to share the GIC with arm and arm64.
> >>
> >> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> ---
> >>  arch/arm/common/Kconfig                            |    8 --------
> >>  arch/arm/common/Makefile                           |    1 -
> >>  drivers/irqchip/Kconfig                            |    8 ++++++++
> >>  drivers/irqchip/Makefile                           |    1 +
> >>  arch/arm/common/gic.c => drivers/irqchip/irq-gic.c |    0
> >>  drivers/irqchip/irqchip.c                          |   10 ++++++++++
> >>  drivers/irqchip/irqchip.h                          |    1 +
> >>  7 files changed, 20 insertions(+), 9 deletions(-)
> >>  rename arch/arm/common/gic.c => drivers/irqchip/irq-gic.c (100%)
> > 
> > What about its dependent arch/arm/include/asm/hardware/gic.h header,
> > which I believe after patch 1 becomes just a bunch of function calls,
> > and so no longer has any right to be in asm/hardware.
> > 
> > Nothing should be moved out of arch/arm without its associated header
> > file also moving with it.
> 
> What is left is only used within arch/arm and I expect we will get rid
> of the remaining users. So I didn't want to encourage any additional
> users by moving to include/linux.
> 
> gic_secondary_init and gic_cascade_irq could be function ptrs.

gic_secondary_init() can be, but I don't see how why you think it would
be a good idea to turn gic_casade_irq() into a function pointer.  That
makes zero sense to me what so ever.  As I've already pointed out,
gic_cascade_irq() is only used by a minority of platforms where there
are two cascaded GICs.  That being Realview, where you have a SMP tile
with its own GIC on top of the motherboard with a motherboard GIC.

Moreover, what gic_cascade_irq() is doing is can't really be turned
into something generic; it's setting up genirq for the chained GIC,
which requires GIC specific data.

You can't get around the fact that this function is attaching a
secondary GIC to an upstream IRQ.  That's already as generic as it
can be.

And finally the exercise of turning that into a function pointer is
pure code obfuscation with zero benefit what so ever.  The fact is
these platforms _definitely_ have a GIC present, and as the driver
needs to be built into the kernel for these platforms to function
there is no point what so ever in having a direct function call into
the GIC code.

To think otherwise... your off your rocker IMHO.

> gic_of_init can be removed once users are converted to call irqchip_init
> instead. That leaves gic_init which are all the non-DT converted GIC
> users and will take some time to convert. I am puzzled by tegra and zynq
> which should be DT only already.

Still, my point stands.  After this change this header file has no
business being in asm/hardware.  At all.  It needs to move as a result
of this change.
