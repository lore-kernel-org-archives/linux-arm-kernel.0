From: shameerali.kolothum.thodi@huawei.com (Shameer Kolothum)
Date: Tue, 1 Aug 2017 11:49:13 +0100
Subject: [PATCH v5 2/2] iommu/dma: Add HW MSI address regions reservation
In-Reply-To: <20170801104913.71912-1-shameerali.kolothum.thodi@huawei.com>
References: <20170801104913.71912-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20170801104913.71912-3-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modified iommu_dma_get_resv_regions() to include HW MSI
(ARM GICv3 ITS MSI) specific reservations if available.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe..44eca1e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/gfp.h>
@@ -167,13 +168,18 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
  *
  * IOMMU drivers can use this to implement their .get_resv_regions callback
  * for general non-IOMMU-specific reservations. Currently, this covers host
- * bridge windows for PCI devices.
+ * bridge windows for PCI devices and HW MSI(ARM GICv3 ITS MSI) region
+ * reservations if available.
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	struct pci_host_bridge *bridge;
 	struct resource_entry *window;
 
+	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
+		iort_iommu_its_get_resv_regions(dev, list) < 0)
+		return;
+
 	if (!dev_is_pci(dev))
 		return;
 
-- 
1.9.1
