From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  6 Jul 2015 14:13:52 +0100
Subject: [PATCH 4.2-rc1 v21 0/6] irq/arm: Implement
 arch_trigger_all_cpu_backtrace
Message-ID: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset modifies the GIC driver to allow it, on supported
platforms, to route IPI interrupts to FIQ. It then uses this
feature to implement arch_trigger_all_cpu_backtrace for arm.
In order to neatly deliver the changes for the arm we also
rearrange some of the existing x86 NMI code to make it architecture
neutral.

The patches have been runtime tested on both a system capable of
supporting FIQ (Freescale i.MX6) and one that cannot (Qualcomm
Snapdragon 600). In addition older versions of this patchset
have been tested on STiH416 and vexpress-a9. The changes to the x86
logic were tested using qemu.

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
  then the interface is brought down.

For changes in v20 and earlier see:
  http://thread.gmane.org/gmane.linux.kernel/1928465


Daniel Thompson (6):
  irqchip: gic: Optimize locking in gic_raise_softirq
  irqchip: gic: Make gic_raise_softirq FIQ-safe
  irqchip: gic: Introduce plumbing for IPI FIQ
  printk: Simple implementation for NMI backtracing
  x86/nmi: Use common printk functions
  ARM: Add support for on-demand backtrace of other CPUs

 arch/arm/Kconfig                |   1 +
 arch/arm/include/asm/hardirq.h  |   2 +-
 arch/arm/include/asm/irq.h      |   5 +
 arch/arm/include/asm/smp.h      |   3 +
 arch/arm/kernel/smp.c           |  82 +++++++++++++++
 arch/arm/kernel/traps.c         |  13 ++-
 arch/x86/Kconfig                |   1 +
 arch/x86/kernel/apic/hw_nmi.c   | 104 ++-----------------
 drivers/irqchip/irq-gic.c       | 220 +++++++++++++++++++++++++++++++++++++---
 include/linux/irqchip/arm-gic.h |   6 ++
 include/linux/printk.h          |  20 ++++
 init/Kconfig                    |   3 +
 kernel/printk/Makefile          |   1 +
 kernel/printk/nmi_backtrace.c   | 147 +++++++++++++++++++++++++++
 14 files changed, 495 insertions(+), 113 deletions(-)
 create mode 100644 kernel/printk/nmi_backtrace.c

--
2.4.3
