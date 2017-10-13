From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 13 Oct 2017 15:09:46 +0800
Subject: [PATCH v2 0/4] IORT SMMUv3 MSI support
Message-ID: <1507878590-51066-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

IORT revision C introduced SMMUv3 MSI support for control interrupts,
which introduced a device ID mapping index to retrieve the dev ID
and ITS parent, adding its support in this patch set, please refer
to each patch for detail commit message.

This patch set is based on Lorenzo's v2 clearup/rework for iort:
https://www.spinics.net/lists/arm-kernel/msg611089.html

Tested on D05 without breakage, and SMMU msi function is OK
on hip08 platform, this version is intented for merge.

v1 -> v2:
 - Rewrote commit message by Lorenzo to remove some wrong
   message;
 - Split patch 3/4 in v1 into two by Lorenzo to make the logic
   clearer;
 - Drop acpica patch but use the ACPICA version as a guard
   for function iort_get_id_mapping_index() in case acpica for
   linux kernel is not ready (patch for acpica iasl was merged
   already).

RFC v2 -> v1:
 - Drop RFC tag;
 - return the index value directly from iort_get_id_mapping_index()
   then make the logic simple in iort_node_map_id();
 - To make sure ID mapping index is only ignored if all interrupts are
   GSIV based
 - Sqursh part of the patch 4 to patch 3

RFC v1 -> RFC v2:
 - Introduce a new API iort_set_device_domain() to find the MSI domain
   for an SMMUv3 (or any other IORT table node) to reduce the complex
   of doing that via acpi_configure_pmsi_domain().

Hanjun Guo (3):
  ACPI/IORT: Look up IORT node through struct fwnode_handle pointer
  ACPI/IORT: Enable special index ITS group mappings for IORT nodes
  ACPI/IORT: Add SMMUv3 specific special index mapping handling

Lorenzo Pieralisi (1):
  ACPI/IORT: Enable SMMUv3/PMCG IORT MSI domain set-up

 drivers/acpi/arm64/iort.c | 159 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 153 insertions(+), 6 deletions(-)

-- 
1.7.12.4
