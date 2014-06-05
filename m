From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu,  5 Jun 2014 10:53:05 +0100
Subject: [RFC v3 0/9] kgdb: NMI/FIQ support for ARM
In-Reply-To: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes it possible to use the kgdb NMI infrastructure on
ARM platforms by providing a mutli-platform compatible means for drivers
to manage FIQ routings.

First a quick summary of how the mainline kgdb NMI infrastructure
(mostly found in drivers/tty/serial/kgdb_nmi.c) works. The kgdb
infrastructure will re-route the kgdb console UART's interrupt signal
from IRQ to FIQ. Naturally the UART will no longer function normally and
will instead be managed by kgdb using the polled I/O functions. Any
character delivered to the UART causes the kgdb handler function to be
called.

Note that, within this patchset a serial driver explicitly consents (or
not) to the abuse outlined above by calling the appropriate registration
during the .poll_init() callback.

The patch set is structured as follows:

  The first five patches modify the interrupt system to make it easier
  to describe FIQ. The key concept is that a call to enable_fiq() must
  modify the IRQ/FIQ routing to that the FIQ really is enabled (rather
  than spuriously delivering the signal on the IRQ). To achieve this
  each interrupt controller registers two virqs for each hwirq (allowing
  IRQ and FIQ to be readily distinguished) and registers the mappings
  using a new call, fiq_add_mapping().
  
  The next two patches (6 and 7) provide kgdb with a FIQ handler and
  a means for serial drivers to register their FIQ with kgdb.

  Finally two example serial drivers are modified in order to register
  their FIQs with kgdb.

Major remaining TODO item is to modify the code to halt the other CPUs;
at present this code sends IPIs (which use a normal IRQ) and busy waits
for the other CPUs to halt. This means the benefits of invoking the
debugger via NMI are not yet realized on SMP systems. However I plan
to tackle that later (i.e.  when there's some consensus on whether this
approach is the right way to handle FIQ).

Changes since v2:

* Use flexible mappings to link a normal virq to a FIQ virq. This
  replaces the device tree proposals from the previous RFC
  (thanks Russell King and Rob Herring).

* Reviewed all use of spin locks within .irq_eoi callbacks (and fixed
  the issue identified). Added comments to the FIQ registration
  functions making clear the requirements imposed on interrupt
  controller that call the FIQ API (thanks Russell King).

* Fixed a few whitespace issues (thanks Srinivas Kandagatla)

* ARM64/defconfig build tests (no problems found)

Changes since v1:

* Fully fledged multi-platform

* Tested for correct FIQ operation on STiH416/B2020 (Cortex A9),
  qemu/versatile and qemu/vexpress-a15 (with self-written mods to the
  GIC model to support FIQ).

* Regression tested (and resulting bugs fixed) on qemu/versatile+DT and
  qemu/integreatorcp.

Anton Vorontsov (2):
  ARM: Move some macros from entry-armv to entry-header
  ARM: Add KGDB/KDB FIQ debugger generic code

Daniel Thompson (7):
  arm: fiq: arbitrary mappings from IRQ to FIQ virqs
  arm: fiq: Allow EOI to be communicated to the intc
  irqchip: gic: Provide support for interrupt grouping
  irqchip: gic: Introduce shadow irqs for FIQ
  irqchip: vic: Introduce shadow irqs for FIQ
  serial: amba-pl011: Pass on FIQ information to KGDB.
  serial: asc: Add support for KGDB's FIQ/NMI mode

 arch/arm/Kconfig                            |   2 +
 arch/arm/Kconfig.debug                      |  18 +++
 arch/arm/include/asm/fiq.h                  |   4 +
 arch/arm/include/asm/kgdb.h                 |   7 ++
 arch/arm/kernel/Makefile                    |   1 +
 arch/arm/kernel/entry-armv.S                | 151 +------------------------
 arch/arm/kernel/entry-header.S              | 164 ++++++++++++++++++++++++++++
 arch/arm/kernel/fiq.c                       |  85 +++++++++++++-
 arch/arm/kernel/kgdb_fiq.c                  | 124 +++++++++++++++++++++
 arch/arm/kernel/kgdb_fiq_entry.S            |  87 +++++++++++++++
 arch/arm/mach-ep93xx/core.c                 |   6 +-
 arch/arm/mach-netx/generic.c                |   3 +-
 arch/arm/mach-s3c64xx/common.c              |   6 +-
 arch/arm/mach-versatile/core.c              |   9 +-
 arch/arm/mach-versatile/include/mach/irqs.h |   5 +-
 arch/arm/plat-samsung/s5p-irq.c             |   3 +-
 drivers/irqchip/irq-gic.c                   |  97 ++++++++++++++--
 drivers/irqchip/irq-vic.c                   | 102 ++++++++++++++---
 drivers/tty/serial/amba-pl011.c             |  99 ++++++++++-------
 drivers/tty/serial/st-asc.c                 |  23 ++++
 include/linux/irqchip/arm-gic.h             |   3 +
 include/linux/irqchip/arm-vic.h             |   8 +-
 22 files changed, 770 insertions(+), 237 deletions(-)
 create mode 100644 arch/arm/kernel/kgdb_fiq.c
 create mode 100644 arch/arm/kernel/kgdb_fiq_entry.S

-- 
1.9.0
