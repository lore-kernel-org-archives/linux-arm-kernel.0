From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 11 Aug 2016 12:55:11 +0100
Subject: [PATCH 4.8-rc1 v23 0/4] irq/arm: Use FIQ for NMI backtrace (when
 possible)
In-Reply-To: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
References: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1470916515-28510-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset modifies the GIC driver to allow it, on supported
platforms, to route IPI interrupts to FIQ. It then uses this
feature to allow the NMI backtrace code on arm to be implemented
using FIQ.

Other than the rebase the patchset is unchanged since previous posting.

The patches have been runtime tested on the following systems, covering
both arm and arm64 systems and those with and without FIQ support:

* Freescale i.MX6 (arm, gicv1, supports FIQ)
* qemu-system-arm -M vexpress-a9 -cpu cortex-a9 (arm, gicv1, does not
  support FIQ)
* qemu-system-arm -M vexpress-a15 -cpu cortex-a15 (arm, gicv2, supports
  FIQ)
* Qualcomm Snapdragon 600 (arm, gicv2, does not support FIQ)
* Hisilicon 6220 (arm64, gicv2, does not support FIQ)

v23:

* Fixed build on systems without CONFIG_MULTI_IRQ_HANDLER (0-day test
  robot)
* Rebased on v4.7-rc3 and added the Acked-by:s from v22 and v23.
* Remove the double register write when raising an SGI by created local
  shadow of the SGI group bits (Marc Zyngier)
* Fixed an out-by-one error in one of the WARNings (Marc Zygnier)
* Added logic to cache whether or not the GIC support interrupt grouping
  (Marc Zygnier)
* Added a comment to explain an unexpected #ifdef CONFIG_ARM and applied
  the magic nit comb (Marc Zygnier)

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
 arch/arm/kernel/traps.c         |  11 +-
 drivers/irqchip/irq-gic.c       | 252 ++++++++++++++++++++++++++++++++++++----
 include/linux/irqchip/arm-gic.h |   6 +
 5 files changed, 263 insertions(+), 21 deletions(-)

--
2.7.4
