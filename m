From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Mar 2011 17:13:18 +0000
Subject: [PATCH v3 0/7] Migrate GIC to fasteoi flow control
Message-ID: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 3 of the patch series originally posted here:

v1.) http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/043083.html
v2.) http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/043984.html

Changes since v2:

	* Added chained_irq_{enter,exit} functions to work with chained
	  handlers that support multiple primary chips and to aid in
	  bisectibility
	* Based on 2.6.38-rc8

As a result of these changes, all of the BSP code has been reworked so
I'm afraid I need some fresh acks and tested-bys because the old ones
are no longer valid.

I appreciate there is some debate concerning the sanity of chained
handlers with potentially multiple primary chips, but I can't think of
a way to fix these without considering the handlers on a case-by-case
basis which is not the intent of this patch series.

Cheers,

Will


Will Deacon (7):
  ARM: irq: introduce entry and exit functions for chained handlers
  ARM: omap: update GPIO chained IRQ handler to use entry/exit
    functions
  ARM: tegra: update GPIO chained IRQ handler to use entry/exit
    functions
  ARM: s5pv310: update IRQ combiner to use chained entry/exit functions
  ARM: msm: update GPIO chained IRQ handler to use entry/exit functions
  ARM: nmk: update GPIO chained IRQ handler to entry/exit functions
  ARM: gic: use handle_fasteoi_irq for SPIs

 arch/arm/common/gic.c                |   22 +++++++++-------------
 arch/arm/include/asm/mach/irq.h      |   27 +++++++++++++++++++++++++++
 arch/arm/mach-msm/gpio-v2.c          |    6 +++++-
 arch/arm/mach-s5pv310/irq-combiner.c |    6 ++----
 arch/arm/mach-tegra/gpio.c           |    7 ++++---
 arch/arm/plat-nomadik/gpio.c         |   10 ++--------
 arch/arm/plat-omap/gpio.c            |    7 ++++---
 7 files changed, 53 insertions(+), 32 deletions(-)
