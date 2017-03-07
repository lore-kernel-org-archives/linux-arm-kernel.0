From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 7 Mar 2017 20:39:55 +0800
Subject: [PATCH v9 00/15] ACPI platform MSI support and its example mbigen
Message-ID: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

With platform msi support landed in the kernel, and the introduction
of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
is ready, this patch set add few patches to enable the ACPI platform
msi support.

For platform device connecting to ITS on arm platform, we have IORT
table with the named componant node to describe the mappings of paltform
device and ITS, so we can retrieve the dev id and find its parent
irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).

v8 -> v9:
	- Rebased on top of 4.11-rc1 and retest;
	- Some of patch's commit message was updated by Lorenzo and
	  it's clearer (thanks!)

No update in the code, hope it's the final revision.

v7 -> v8:
	- Using _CRS instead of _PRS for Interrupt resources for mbigen

	- reshuffle the patch slightly to introduce iort_node_map_platform_id()
	  first and then retrieve the dev id for platform MSI, no functional
	  change

	- Fix the compile error with patch "irqchip: gicv3-its: platform-msi:
	  scan MADT to create platform msi domain", which forgot to add 
	  <include/acpi_iort.h> (added in later patches in last version).

	- renew some commit message which suggested by Lorenzo

	- address some othe minor issues which commented by Lorenzo

	- Add review and test tag as it's no functional change except
	  the last patch of mbigen

	- rebase on top of 4.10-rc4 and test it on x86, ia64 and ARM64
	  platforms (also with Agustin's patch [1-2/3] "[PATCH V9 0/3] irqchip: qcom:
          Add IRQ combiner driver" and Lorenzo's patch
          https://patchwork.kernel.org/patch/9507041/)

v6 -> v7: 
	- Introduce iort_node_map_platform_id() to retrieve the
	  dev id for both NC (named component) -> ITS/SMMU and
	  NC -> SMMU -> ITS cases, suggested by Lorenzo;

	- Reorder the patches and rewrite some commit message;

	- Remove the test tags because it has major changes
	  to retrieve the dev id, Sinan, Majun, Xinwei, could
	  you please test them again on your platform?

	- rebased on top of 4.10-rc3 and Lorenzo's patch
          https://patchwork.kernel.org/patch/9507041/

	- Tested against Agustin's patch [1-2/3] "[PATCH V9 0/3] irqchip: qcom:
          Add IRQ combiner driver"

v5 -> v6:
        - Call acpi_configure_pmsi_domain() for platform devices in
          acpi_platform_notify() as it's cleaner (suggested by Rafael)
        - Remove the "u8 type" for iort_id_map() because it's unused
        - Rebase on top of 4.10-rc2
        - Collect test and review tags

v4 -> v5:
        - Add mbigen support back with tested on with Agustin's patchset,
          and it's a good example of how ACPI platform MSI works
        - rebased on top of lastest Linus tree (commit 52bce91 splice: reinstate SIGPIPE/EPIPE handling)

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

Hanjun Guo (13):
  ACPI/IORT: Fix the indentation in iort_scan_node()
  ACPI/IORT: Add missing comment for iort_dev_find_its_id()
  ACPI/IORT: Rework iort_match_node_callback() return value handling
  irqchip: gic-v3-its: keep the include header files in alphabetic
    order
  irqchip: gicv3-its: platform-msi: refactor its_pmsi_prepare()
  irqchip: gicv3-its: platform-msi: refactor its_pmsi_init() to prepare
    for ACPI
  irqchip: gicv3-its: platform-msi: scan MADT to create platform msi
    domain
  ACPI/IORT: Rename iort_node_map_rid() to make it generic
  ACPI/IORT: Introduce iort_node_map_platform_id() to retrieve dev id
  ACPI: platform-msi: retrieve dev id from IORT
  ACPI: platform: setup MSI domain for ACPI based platform device
  msi: platform: make platform_msi_create_device_domain() ACPI aware
  irqchip: mbigen: Add ACPI support

Kefeng Wang (2):
  irqchip: mbigen: drop module owner
  irqchip: mbigen: introduce mbigen_of_create_domain()

 drivers/acpi/arm64/iort.c                     | 158 +++++++++++++++++++++-----
 drivers/acpi/glue.c                           |   6 +
 drivers/base/platform-msi.c                   |   3 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 106 +++++++++++++----
 drivers/irqchip/irq-gic-v3-its.c              |   2 +-
 drivers/irqchip/irq-mbigen.c                  | 110 +++++++++++++++---
 include/linux/acpi_iort.h                     |   8 ++
 7 files changed, 317 insertions(+), 76 deletions(-)

-- 
1.7.12.4
