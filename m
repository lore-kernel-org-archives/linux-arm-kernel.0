From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 10 Aug 2017 17:45:22 +0100
Subject: [PATCH] ACPI/IORT: Fix build regression without IOMMU
Message-ID: <20170810164522.25555-1-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

A recent change reintroduced a bug that had previously been
fixed by commit d49f2dedf33b ("ACPI/IORT: Fix CONFIG_IOMMU_API
dependency"):

drivers/acpi/arm64/iort.c: In function 'iort_iommu_configure':
drivers/acpi/arm64/iort.c:829:26: error: 'struct iommu_fwspec' has no member named 'ops'

Replace a direct reference to iommu_fwspec->ops with a helper function
call to fix the issue.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
---
Catalin, Will,

unfortunately it slipped our kconfig checks (and the kbuild bot) but
not Arnd's.

It applies to arm64 for-next/core on top of v4.14 queue. Please apply.

Apologies,
Lorenzo

 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 34972d7..736783c 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -773,7 +773,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 	 * add_device callback for dev, replay it to get things in order.
 	 */
 	if (!err) {
-		ops = dev->iommu_fwspec->ops;
+		ops = iort_fwspec_iommu_ops(dev->iommu_fwspec);
 		err = iort_add_device_replay(ops, dev);
 	}
 
-- 
2.10.0
