From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 15:49:11 +0100
Subject: [PATCH v3 0/7] Early ACPI probing infrastructure
Message-ID: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IRQ controllers and timers are the two types of device the kernel
requires before being able to use the device driver model.

The Device Tree infrastructure makes it very easy to make these
discoverable by the rest of the kernel. For example, each interrupt
controller driver has at least one entry like this:

IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);

which says: if you find a node having "arm,gic-400" as a compatible
string in the device tree, then call gic_of_init with this node as a
parameter. The probing itself is done by the OF layer when the
architecture code calls of_irq_init() (usually via irqchip_init).

This has a number of benefits:

- The irqchip code is self-contained. No architecture specific entry
point, no exposed symbols. Just a standard interface.

- The low-level architecture code doesn't have to know about which
interrupt controller is present. It just calls into the firmware
interface (of_irq_init) which is going to sort things out.

Similar infrastructure is provided for the timers/clock sources. Note
that this is not a replacement for the device model, but acts as a
probing infrastructure for things that are required too early for the
device infrastructure to be available.

What I'm aiming for is to introduce the same level of abstraction for
ACPI, or at least for the few bits that are required before a full blown
ACPI/device model can be used. For this, I introduce something vaguely
similar:

IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
		     gic_validate_dist, ACPI_MADT_GIC_VERSION_V2,
		     gic_v2_acpi_init);

which says: if you find a ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR entry in
MADT (implied by the macro), and that entry is of type
ACPI_MADT_GIC_VERSION_V2 (as checked by gic_validate_dist), then call
gic_v2_acpi_init with the entry as a parameter. A bit more convoluted,
but still without any special entry point.

The various interrupt controller drivers can then implement the above,
and the arch code can use a firmware-specific call to get the probing
done, still oblivious to what interrupt controller is being used. It
also makes the adaptation of a DT driver to ACPI easier.

It turns out that providing such a probing infrastructure is rather
easy, and provides a much deserved cleanup in both the arch code, the
GIC driver, and the architected timer driver. An additional (and very
much optional) patch renames files and symbols to make it obvious that
the infrastructure is not just for DT anymore.

I'm sure there is some more code to be deleted, and one can only
wonder why this wasn't done before the arm64 code was initially merged
(the diffstat says it all...).

Patches are against Rafael's bleeding-edge branch, and a branch is
available at

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git acpi/device-probing-v3

* From v2:
  - Addressed Rafael's comments (title for patch #1, macro/field names)
  - New config symbols for clocksources
  - Additional and optional last patch to get rid of the apparent
    dependency between the probing infrastructure and DT.

* From the initial version:
  - Make the infrastructure more DT like by providing an
    acpi_probe_entry array per "device type" (one for irqchips, one
    for clocksources). This means that entries can depend on any ACPI
    static table.
  - Use some cpp magic to reduce the amount of code added to an
    absolute minimum.
  - Rebased on v4.3-rc1

Marc Zyngier (7):
  acpi: Add early device probing infrastructure
  irqchip/acpi: Add probing infrastructure for ACPI-based irqchips
  irqchip/gic: Convert the GIC driver to ACPI probing
  clocksource/acpi: Add probing infrastructure for ACPI-based
    clocksources
  clocksource: Add new CLKSRC_{PROBE,ACPI} config symbols
  clocksource/arm_arch_timer: Convert to ACPI probing
  clocksource: cosmetic: Drop OF 'dependency' from symbols

 arch/arm/kernel/time.c                             |  2 +-
 arch/arm/mach-omap2/timer.c                        |  4 +-
 arch/arm/mach-rockchip/rockchip.c                  |  2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |  2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |  2 +-
 arch/arm/mach-spear/spear13xx.c                    |  2 +-
 arch/arm/mach-sunxi/sunxi.c                        |  2 +-
 arch/arm/mach-u300/core.c                          |  2 +-
 arch/arm/mach-ux500/timer.c                        |  2 +-
 arch/arm/mach-zynq/common.c                        |  2 +-
 arch/arm64/include/asm/acpi.h                      |  1 -
 arch/arm64/include/asm/irq.h                       | 13 ----
 arch/arm64/kernel/acpi.c                           | 25 --------
 arch/arm64/kernel/time.c                           |  8 +--
 arch/microblaze/kernel/setup.c                     |  2 +-
 arch/mips/pistachio/time.c                         |  2 +-
 arch/mips/ralink/clk.c                             |  2 +-
 arch/nios2/kernel/time.c                           |  2 +-
 arch/xtensa/kernel/time.c                          |  2 +-
 drivers/acpi/scan.c                                | 39 ++++++++++++
 drivers/clocksource/Kconfig                        |  9 +++
 drivers/clocksource/Makefile                       |  2 +-
 drivers/clocksource/arm_arch_timer.c               | 10 +---
 .../clocksource/{clksrc-of.c => clksrc-probe.c}    |  6 +-
 drivers/irqchip/irq-gic.c                          | 69 +++++++++++-----------
 drivers/irqchip/irqchip.c                          |  5 +-
 include/asm-generic/vmlinux.lds.h                  | 12 ++++
 include/linux/acpi.h                               | 66 +++++++++++++++++++++
 include/linux/acpi_irq.h                           | 10 ----
 include/linux/clocksource.h                        | 13 ++--
 include/linux/irqchip.h                            | 17 ++++++
 include/linux/irqchip/arm-gic-acpi.h               | 31 ----------
 32 files changed, 209 insertions(+), 159 deletions(-)
 rename drivers/clocksource/{clksrc-of.c => clksrc-probe.c} (91%)
 delete mode 100644 include/linux/acpi_irq.h
 delete mode 100644 include/linux/irqchip/arm-gic-acpi.h

-- 
2.1.4
