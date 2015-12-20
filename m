From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sun, 20 Dec 2015 20:52:33 +0000
Subject: [PATCH 4.4-rc5 v22 0/4] irq/arm: Use FIQ for NMI backtrace (when
 possible)
Message-ID: <1450644757-18734-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset modifies the GIC driver to allow it, on supported
platforms, to route IPI interrupts to FIQ. It then uses this
feature to allow the NMI backtrace code on arm to be implemented
using FIQ.

The patches have been runtime tested on the following systems, covering
both arm and arm64 systems and those with and without FIQ support:

* Freescale i.MX6 (arm, gicv1, supports FIQ)
* Qualcomm Snapdragon 600 (arm, gicv2, does not support FIQ)
* Hisilicon 6220 (arm64, gicv2, does not support FIQ)


v22:

* Rebase on v4.4-rc5 to adopt the new NMI backtrace code from Russell
  King.

* Polished a few comments and reorganised the patches very slightly
  (shifted a couple of arm changes to patch 4).

* Fixed bug in the way gic_handle_fiq() checks whether it is safe for
  it to read IAR.

v21:

* Change the way SGIs are raised to try to increase robustness starting
  secondary cores. This is a theoretic fix for a regression reported
  by Mark Rutland on vexpress-tc2 but it also allows us to remove
  igroup0_shadow entirely since it is no longer needed.

* Fix a couple of variable names and add comments to describe the
  hardware behavior better (Mark Rutland).

* Improved MULTI_IRQ_HANDLER support by clearing FIQs using
  handle_arch_irq (Marc Zygnier).

* Fix gic_cpu_if_down() to ensure group 1 interrupts are disabled
  when the interface is brought down.

For changes in v20 and earlier see:
  http://thread.gmane.org/gmane.linux.kernel/1928465


Daniel Thompson (4):
  irqchip: gic: Optimize locking in gic_raise_softirq
  irqchip: gic: Make gic_raise_softirq FIQ-safe
  irqchip: gic: Introduce plumbing for IPI FIQ
  ARM: Allow IPI_CPU_BACKTRACE to exploit FIQ

 arch/arm/include/asm/smp.h      |   9 ++
 arch/arm/kernel/smp.c           |   6 +
 arch/arm/kernel/traps.c         |   9 +-
 drivers/irqchip/irq-gic.c       | 235 ++++++++++++++++++++++++++++++++++++----
 include/linux/irqchip/arm-gic.h |   6 +
 5 files changed, 245 insertions(+), 20 deletions(-)

--
2.5.0
