From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 29 Nov 2016 21:39:28 +0800
Subject: [PATCH v4 00/11] ACPI platform MSI support
Message-ID: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

v3 -> v4:
	- Drop mbi-gen patches to just submit platform msi support because
	  will rebase mbi-gen patches on top of Agustin's patchset, and discusion
	  is going there.
	- Add a patch to support device topology such as NC(named componant, paltform device)
	  ->SMMU->ITS which suggested by Lorenzo;
	- rebased on top of Lorenzo's v9 of ACPI IORT ARM SMMU support;
	- rebased on top of 4.9-rc7

v2 -> v3:
        - Drop RFC tag
        - Rebase against v4.9-rc2 and Lorenzo's v6 of ACPI IORT ARM SMMU support [1]
        - Add 3 cleanup patches (patch 1, 2, 3)
        - Drop arch_init call patch from last version
        - Introduce a callback for platform device to set msi domain
        - Introduce a new API to get paltform device's domain instead of
          reusing the PCI one in previous version
        - Add a patch to rework iort_node_get_id()

[1]: http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1251993.html

v1 -> v2:
        - Fix the bug of if multi Interrupt() resoures in single _PRS,
          we need to calculate all the irq numbers (I missed it in previous
          version);
        - Rebased on Marc's irq/irqchip-4.9 branch and Lorenzo's v5
          SMMU patches (also Robin's SMMu patches)
        - Add patch irqchip: mbigen: promote mbigen init.

With platform msi support landed in the kernel, and the introduction
of IORT for GICv3 ITS (PCI MSI), the framework for platform msi
is ready, this patch set add few patches to enable the ACPI platform
msi support.

For platform device connecting to ITS on arm platform, we have IORT
table with the named componant node to describe the mappings of paltform
device and ITS, so we can retrieve the dev id and find its parent
irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).

The fisrt 3 patches are cleanups;

Patch 4,5 are refactoring its_pmsi_prepare() for both DT and ACPI
then retrieve the dev id from iort;

Patch 6,7 to create platform msi domain to ACPI case which scanned
the MADT table;

Patch 8,9,10,11 to setup the msi domain for platform device based
on IORT table.

Teasted on Hisilicon D03.

Thanks
Hanjun

Hanjun Guo (11):
  ACPI: ARM64: IORT: minor cleanup for iort_match_node_callback()
  irqchip: gic-v3-its: keep the head file include in alphabetic order
  ACPI: ARM64: IORT: add missing comment for iort_dev_find_its_id()
  irqchip: gicv3-its: platform-msi: refactor its_pmsi_prepare()
  ACPI: platform-msi: retrieve dev id from IORT
  irqchip: gicv3-its: platform-msi: refactor its_pmsi_init() to prepare
    for ACPI
  irqchip: gicv3-its: platform-msi: scan MADT to create platform msi
    domain
  ACPI: ARM64: IORT: rework iort_node_get_id()
  ACPI: platform: setup MSI domain for ACPI based platform device
  ACPI: ARM64: IORT: rework iort_node_get_id() for NC->SMMU->ITS case
  msi: platform: make platform_msi_create_device_domain() ACPI aware

 drivers/acpi/acpi_platform.c                  |  11 ++
 drivers/acpi/arm64/iort.c                     | 138 ++++++++++++++++++++------
 drivers/base/platform-msi.c                   |   3 +-
 drivers/base/platform.c                       |   3 +
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 106 +++++++++++++++-----
 drivers/irqchip/irq-gic-v3-its.c              |   3 +-
 include/linux/acpi_iort.h                     |  11 ++
 include/linux/platform_device.h               |   3 +
 8 files changed, 217 insertions(+), 61 deletions(-)

-- 
1.7.12.4
