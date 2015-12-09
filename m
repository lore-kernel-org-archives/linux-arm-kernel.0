From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 9 Dec 2015 11:24:30 -0800
Subject: [PATCH v6 0/4] gicv2m: acpi: Add ACPI support for GICv2m MSI
Message-ID: <1449689074-30609-1-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series has been forked from the following patch series since
it no longer depends on the rest of the patches.

  [PATCH v4 00/10] ACPI GIC Self-probing, GICv2m and GICv3 support
  https://lkml.org/lkml/2015/7/29/234

It has been ported to use the newly introduced device fwnode_handle 
for ACPI irqdmain introduced by Marc in the following patch series:

  [PATCH v2 00/17] Divorcing irqdomain and device_node

The following git branch contains the submitted patches along with
the pre-requsite patches (mainly for ARM64 PCI support for ACPI).

  https://github.com/ssuthiku/linux.git	v2m-multiframe-v6

This has been tested on AMD Seattle (Overdrive) RevB system. 

NOTE: I have not tested ACPI GICv2m multiframe support since
I don't have access to such system. Any helps are appreciated.

Thanks,
Suravee

Changes from V5: (https://lkml.org/lkml/2015/12/08/763)
  - Remove previous patch 3
  - Clean up based on Marc's review (patch 1.4)
  - Add Ackedb-by and Reviewed-by (Patch 1,2,3)
  - Expose single gicv2m_init() function for both OF and ACPI
    (per Marc's suggestion)
  - Remove gicv2m name from pr_info since this is no longer useful
    (in patch 3) (per Marc's suggestion)

Changes from V4: (https://lkml.org/lkml/2015/12/08/613)
  - Fix build error when not specifying CONFIG_IRQ_DOMAIN.

Changes from V3: (https://lkml.org/lkml/2015/10/21/691)
  - Merged patch 2 into 1, and got rid off pci_msi_get_fwnode()
    since only ACPI will likely use this. (per Marc suggestion)
  - Rebased to 4.4.0-rc4

Changes from V2: (https://lkml.org/lkml/2015/10/14/1010)
  - Minor clean up from Tomasz review comment in patch 6/6.

Changes from V1: (https://lkml.org/lkml/2015/10/13/859)
  - Rebase on top of Marc's patch to addng support for multiple MSI frames
    (https://lkml.org/lkml/2015/10/14/271)
  - Adding fwnode convenient functions (patch 3 and 4)

Suravee Suthikulpanit (4):
  acpi: pci: Setup MSI domain for ACPI based pci devices
  irqdomain: introduce is_fwnode_irqchip helper
  gicv2m: Refactor to prepare for ACPI support
  gicv2m: acpi: Introducing GICv2m ACPI support

 drivers/irqchip/irq-gic-v2m.c   | 167 ++++++++++++++++++++++++++++++++++------
 drivers/irqchip/irq-gic.c       |   8 +-
 drivers/pci/pci-acpi.c          |  42 ++++++++++
 drivers/pci/probe.c             |   2 +
 include/linux/irqchip/arm-gic.h |   3 +-
 include/linux/irqdomain.h       |  10 +++
 include/linux/pci.h             |  10 +++
 kernel/irq/irqdomain.c          |   2 +-
 8 files changed, 218 insertions(+), 26 deletions(-)

-- 
2.1.0
