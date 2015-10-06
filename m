From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Oct 2015 18:36:13 +0100
Subject: [PATCH 00/16] Divorcing irqdomain and device_node
Message-ID: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[This patch series used to be called "Making the generic ACPI GSI
layer irqdomain aware", but as I've radically changed my approach to
this problem, I've decided to reset the counters...]

The irqdomain code is not entierely ACPI friendly, as it has some
built-in knowledge of the device-tree. Nothing too harmful, but enough
to scare the ARM ACPI developpers which end up with their own version
of the square wheel. And some of the ramifications actually run deeper
than initially expected.

This series adapts the irqdomain code to use 'struct fwnode_handle'
instead of 'struct device_node' as the identifier for a domain
(compatibility interfaces are of course added). It also introduces a
generic IRQ specifier that firmware interfaces (DT or ACPI) can
directly use to configure interrupts, and allow the ACPI GSI code to
be plugged into this.

As examples, we convert the ARM GIC ACPI support to use irqdomains as
originally intended, and rework the MSI code to also move away from
using device nodes when using irqdomains.

Overall, this gives us a way to use irqdomains on both DT and ACPI
enabled platforms, having very little changes made to the actual
drivers (other than the probing infrastructure). Because we keep the
flow of information between the various layers identical between ACPI
and DT, we immediately benefit from the existing infrastructure.

This has been test-booted on Juno, is based on 4.3-rc4, and available at:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irq-domain-fwnode-v1

Marc Zyngier (16):
  irqdomain: Use an accessor for the of_node field
  irqdomain: Convert irqdomain->of_node to fwnode
  irqdomain: Allow irq domain lookup by fwnode
  irqdomain: Introduce a firmware-specific IRQ specifier structure
  irqchip: Convert all alloc/xlate users from of_node to fwnode
  irqdomain: Introduce irq_create_fwspec_mapping
  irqdomain: Introduce irq_domain_create_{linear,tree}
  irqdomain: Add a fwnode_handle allocator
  acpi/gsi: Always perform an irq domain lookup
  acpi/gsi: Add acpi_set_irq_model to initialize the GSI layer
  irqchip/gic: Get rid of gic_init_bases()
  irqchip/gic: Switch ACPI support to stacked domains
  irqchip/gic: Kill the xlate method
  acpi/gsi: Cleanup acpi_register_gsi
  irqdomain: Introduce irq_domain_create_hierarchy
  irqdomain/msi: Use fwnode instead of of_node

 arch/arm/mach-exynos/suspend.c                |  55 ++++----
 arch/arm/mach-imx/gpc.c                       |  55 ++++----
 arch/arm/mach-omap2/omap-wakeupgen.c          |  55 ++++----
 arch/c6x/platforms/megamod-pic.c              |   2 +-
 arch/mips/cavium-octeon/octeon-irq.c          |   4 +-
 arch/powerpc/platforms/cell/axon_msi.c        |   2 +-
 arch/powerpc/platforms/cell/spider-pic.c      |   9 +-
 arch/powerpc/platforms/pasemi/msi.c           |   6 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c |   2 +-
 arch/powerpc/sysdev/ehv_pic.c                 |   3 +-
 arch/powerpc/sysdev/fsl_msi.c                 |   2 +-
 arch/powerpc/sysdev/i8259.c                   |   3 +-
 arch/powerpc/sysdev/ipic.c                    |   3 +-
 arch/powerpc/sysdev/mpic.c                    |   3 +-
 arch/powerpc/sysdev/mpic_msi.c                |   2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c            |   3 +-
 drivers/acpi/gsi.c                            |  54 ++++----
 drivers/base/platform-msi.c                   |   6 +-
 drivers/gpio/gpio-sodaville.c                 |   2 +-
 drivers/irqchip/exynos-combiner.c             |   2 +-
 drivers/irqchip/irq-atmel-aic-common.c        |   2 +-
 drivers/irqchip/irq-crossbar.c                |  62 ++++-----
 drivers/irqchip/irq-gic-v2m.c                 |  23 ++--
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |   3 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |   3 +-
 drivers/irqchip/irq-gic-v3-its.c              |  20 +--
 drivers/irqchip/irq-gic-v3.c                  |  49 ++++----
 drivers/irqchip/irq-gic.c                     |  94 ++++++++------
 drivers/irqchip/irq-hip04.c                   |   2 +-
 drivers/irqchip/irq-imx-gpcv2.c               |  64 +++++-----
 drivers/irqchip/irq-mtk-sysirq.c              |  49 ++++----
 drivers/irqchip/irq-nvic.c                    |  18 ++-
 drivers/irqchip/irq-s3c24xx.c                 |   4 +-
 drivers/irqchip/irq-tegra.c                   |  55 ++++----
 drivers/irqchip/irq-vf610-mscm-ir.c           |  45 ++++---
 drivers/pci/host/pci-xgene-msi.c              |   2 +-
 drivers/pci/msi.c                             |  14 +--
 drivers/spmi/spmi-pmic-arb.c                  |   2 +-
 include/linux/acpi.h                          |   3 +
 include/linux/fwnode.h                        |   1 +
 include/linux/irqchip/arm-gic.h               |   9 +-
 include/linux/irqdomain.h                     |  86 +++++++++++--
 include/linux/msi.h                           |   9 +-
 kernel/irq/irqdomain.c                        | 173 ++++++++++++++++++++------
 kernel/irq/msi.c                              |   8 +-
 45 files changed, 665 insertions(+), 408 deletions(-)

-- 
2.1.4
