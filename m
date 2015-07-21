From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Jul 2015 11:07:55 +0100
Subject: [PATCH 0/5] Making the generic ACPI GSI layer irqdomain aware
Message-ID: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irqdomain code is not entierely really ACPI friendly, as it has
some built-in knowledge of the device-tree. Nothing too harmful, but
enough to scare the ARM ACPI developpers which end up with their own
version of the square wheel.

This small patch series adapt the irqdomain code to remove the hurdles
that prevent the full blown irqdomain subsystem to be used on ACPI,
creates an interface between the GSI layer and the irqdomain, and as
an example, convert the ARM GIC ACPI support to use irqdomains as
originally intended.

Overall, this gives us a way to use irqdomains on both DT and ACPI
enabled platforms, having very little changes made to the actual
drivers (other than the probing infrastructure). Because we keep the
flow of information between the various layers identical between ACPI
and DT, we immediately benefit from the existing infrastructure.

I'd really like to hear what people think of that approach, as it
looks to me a lot simpler than the other approaches currently put on
the list. The "convert the GSI information to be DT friendly" is
admitedly not very pretty, but I see it as a stepping stone towards
unifying the two structures.

This has been test-booted on Juno, and is based on my irq/ncpi-msi-2
branch.

Marc Zyngier (5):
  genirq: irqdomain: Use an accessor for the of_node field
  genirq: irqdomain: Remove irqdomain dependency on struct device_node
  genirq: irqdomain: Add irq_create_acpi_mappings
  acpi: gsi: Use acpi_gsi_descriptor to allocate interrupts
  irqchip: GIC: Switch ACPI support to stacked domains

 arch/mips/cavium-octeon/octeon-irq.c          |  4 +-
 arch/powerpc/platforms/cell/axon_msi.c        |  2 +-
 arch/powerpc/platforms/cell/spider-pic.c      |  9 ++-
 arch/powerpc/platforms/powernv/opal-irqchip.c |  2 +-
 arch/powerpc/sysdev/ehv_pic.c                 |  3 +-
 arch/powerpc/sysdev/fsl_msi.c                 |  2 +-
 arch/powerpc/sysdev/i8259.c                   |  3 +-
 arch/powerpc/sysdev/ipic.c                    |  3 +-
 arch/powerpc/sysdev/mpic.c                    |  3 +-
 arch/powerpc/sysdev/mpic_msi.c                |  2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c            |  3 +-
 drivers/acpi/gsi.c                            | 54 ++++++++++-----
 drivers/gpio/gpio-sodaville.c                 |  2 +-
 drivers/irqchip/exynos-combiner.c             |  2 +-
 drivers/irqchip/irq-atmel-aic-common.c        |  2 +-
 drivers/irqchip/irq-crossbar.c                |  4 +-
 drivers/irqchip/irq-gic-v2m.c                 |  2 +-
 drivers/irqchip/irq-gic-v3-its.c              |  2 +-
 drivers/irqchip/irq-gic-v3.c                  |  2 +-
 drivers/irqchip/irq-gic.c                     | 17 ++---
 drivers/irqchip/irq-hip04.c                   |  2 +-
 drivers/irqchip/irq-mtk-sysirq.c              |  2 +-
 drivers/irqchip/irq-s3c24xx.c                 |  4 +-
 drivers/irqchip/irq-tegra.c                   |  4 +-
 drivers/irqchip/irq-vf610-mscm-ir.c           |  5 +-
 drivers/spmi/spmi-pmic-arb.c                  |  2 +-
 include/linux/acpi.h                          |  9 +++
 include/linux/irqchip/arm-gic.h               |  2 +-
 include/linux/irqdomain.h                     | 67 +++++++++++--------
 kernel/irq/irqdomain.c                        | 95 +++++++++++++++++++++------
 30 files changed, 206 insertions(+), 109 deletions(-)

-- 
2.1.4
