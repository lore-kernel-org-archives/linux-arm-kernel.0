From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 15 Oct 2012 14:49:54 -0700
Subject: [PATCH resend 0/10] Get rid of FIQ_START/enable/disable_fiq() + some
 FIQ cleanups
Message-ID: <20121015214954.GA3352@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

As the merge window is over, and hopefully there are no more serious
regressions in the ARM land :-), maybe you'll find time to look into these
small cleanups...

The rationale is the same:

During KDB FIQ patches review you mentioned that I should not introduce
another FIQ_START. It seems that in v3.6-rc the FIQ_START issue was
somewhat band-aided, i.e. machines don't necessary need to define this
stuff any longer, but I also read the background of the issue, and you
once said that you don't want the FIQ subsystem to mess with genirq.

It is surely makes sense as FIQs are arch-specific, plus FIQs are special
in that way that platform makers are free to connects device directly
to the FIQ line, avoiding IC routing, and then enable_fiq(<IRQ>) would
look awkward, at the best.

So, given that, it seems that the only entity that knows for sure how
the particular FIQ is routed is whoever claims the FIQ and fills-in the
fiq_handler struct. It might make sense to introduce disable/enable
callbacks in the fiq_handler struct, and then prototypes for disable/
enable FIQ calls would look like this:

	enable_fiq(struct fiq_handler *fh);
	disable_fiq(struct fiq_handler *fh);

I.e. completely abstracted from the genirq.

Although, to not duplicate IC code, I think it's pretty legitimate to
call genirq functions iff the caller knows for sure that FIQ comes from
IRQ line and it is is routed through the well-known platform IC.

In that case (which is a majority), the typical user would do this:

	static int irq_line;

	void foo_enable_fiq(struct fiq_handler *fh)
	{
		enable_irq(irq_line);
	}

	static struct fiq_handler foo_fiq = {
		.name = "foo",
		.enable_fiq = foo_enable_fiq,
	};

	claim_fiq(&foo_fiq);
	enable_fiq(&foo_fiq);

Obviously, it's needless indirection, so I don't do this. If we ever
pass 'foo_fiq' to some device, which does not know all the routing
details, then it would make sense to introduce it, but not now.

So, the patch set is pretty straightforward:

- Get rid of FIQ_START. Nobody but platform-specific code (and drivers)
  should know the details about which interrupt can be routed to FIQ
  and which cannot;

- Remove disable/enable_fiq() calls from the FIQ subsys (the calls can
  be reintroduced w/ new prototypes when/if needed).

Does the approach make sense?

Thanks!

--
 arch/arm/include/asm/fiq.h                    |  2 -
 arch/arm/include/asm/mach/irq.h               |  7 +++-
 arch/arm/kernel/fiq.c                         | 37 +++++--------------
 arch/arm/kernel/irq.c                         |  2 -
 arch/arm/mach-omap1/include/mach/irqs.h       |  4 --
 arch/arm/mach-rpc/dma.c                       |  4 +-
 arch/arm/mach-rpc/include/mach/irqs.h         |  8 ++--
 arch/arm/mach-rpc/irq.c                       | 21 ++---------
 arch/arm/mach-s3c24xx/include/mach/irqs.h     |  3 --
 arch/arm/plat-mxc/avic.c                      |  5 ---
 arch/arm/plat-mxc/include/mach/irqs.h         |  2 -
 arch/arm/plat-mxc/tzic.c                      |  5 ---
 arch/arm/plat-s3c24xx/irq.c                   |  6 +--
 .../media/platform/soc_camera/mx1_camera.c    |  6 +--
 sound/soc/fsl/imx-pcm-fiq.c                   |  4 +-
 15 files changed, 31 insertions(+), 85 deletions(-)
