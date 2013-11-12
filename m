From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 14:47:56 +0100
Subject: [PATCH 0/7] ARM: sa1100: IRQ/GPIO refactoring
Message-ID: <1384264076-6210-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This modernize the IRQ implementation for the SA1100 a bit by
switching it to MULTI_IRQ_HANDLER, collecting all the runtime
data in a single struct, and using irqdomain to map all IRQs.

This was tested on the H3630 iPAQ by getting the system up
(normal IRQs) and power and action button (low respective
high GPIO IRQs), more testing is welcomed.

Unfortunaley Dmitry was working on something similar in
the patches:

"ARM: sa1100: add irq handler to prepare MULTI_IRQ_HANDLER"
"ARM: sa1100: enable MULTI_IRQ_HANDLER for all boards"
"ARM: sa1100: drop entry-macro.S"

however his patches 1-3 corresponds to path 1/7 in this
series which does a whole lot more.

Linus Walleij (7):
  ARM: sa1100: switch to MULTI_IRQ_HANDLER
  ARM: sa1100: use an irqdomain for the high GPIO IRQs
  ARM: sa1100: refer to hardware IRQs step 1
  ARM: sa1100: use hardware IRQ bit masks
  ARM: sa1100: move GPIO masks to state container
  ARM: sa1100: rewrite the high GPIO IRQ handler
  ARM: sa1100: move state to the overall container

 arch/arm/Kconfig                                |   2 +
 arch/arm/mach-sa1100/assabet.c                  |   1 +
 arch/arm/mach-sa1100/badge4.c                   |   1 +
 arch/arm/mach-sa1100/cerf.c                     |   1 +
 arch/arm/mach-sa1100/collie.c                   |   1 +
 arch/arm/mach-sa1100/generic.h                  |   3 +
 arch/arm/mach-sa1100/h3100.c                    |   1 +
 arch/arm/mach-sa1100/h3600.c                    |   1 +
 arch/arm/mach-sa1100/hackkit.c                  |   1 +
 arch/arm/mach-sa1100/include/mach/entry-macro.S |  41 ---
 arch/arm/mach-sa1100/irq.c                      | 344 +++++++++++++-----------
 arch/arm/mach-sa1100/jornada720.c               |   1 +
 arch/arm/mach-sa1100/lart.c                     |   1 +
 arch/arm/mach-sa1100/nanoengine.c               |   1 +
 arch/arm/mach-sa1100/pleb.c                     |   1 +
 arch/arm/mach-sa1100/shannon.c                  |   1 +
 arch/arm/mach-sa1100/simpad.c                   |   1 +
 17 files changed, 210 insertions(+), 193 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/entry-macro.S

-- 
1.8.3.1
