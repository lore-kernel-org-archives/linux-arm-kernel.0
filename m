From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Feb 2011 15:28:11 +0000
Subject: [PATCH 0/5] Migrate GIC to fasteoi flow control
Message-ID: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following patchset updates the GIC code to use fasteoi as the
method of flow control. This is important because it removes accesses
to the distributor (which are expensive in a virtualised system) from
the critical interrupt path.

Changing the GIC irq_chip structure means updating all of the chained
IRQ handlers which use the GIC as their primary controller. I believe
I've done that in the patches below, but I would appreciate feedback
and/or acked-bys from the platform people to confirm that I've got it
right. It's not easy code to follow and it looks like some of the
chained handlers are designed to work with multiple primary controllers.

Finally, if you think I've missed your platform then please shout!

Thanks,

Will


Will Deacon (5):
  ARM: gic: use handle_fasteoi_irq for SPIs
  ARM: omap: update GPIO chained IRQ handler to use EOI in parent chip
  ARM: tegra: update GPIO chained IRQ handler to use EOI in parent chip
  ARM: s5pv310: update IRQ combiner to use EOI in parent chip
  ARM: msm: update GPIO chained IRQ handler to use EOI in parent chip

 arch/arm/common/gic.c                |   23 +++++++++--------------
 arch/arm/mach-msm/gpio-v2.c          |    2 +-
 arch/arm/mach-s5pv310/irq-combiner.c |    7 ++-----
 arch/arm/mach-tegra/gpio.c           |   17 +----------------
 arch/arm/plat-omap/gpio.c            |    5 ++++-
 5 files changed, 17 insertions(+), 37 deletions(-)
