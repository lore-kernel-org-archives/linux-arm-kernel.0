From: eric.auger@redhat.com (Eric Auger)
Date: Tue,  2 Aug 2016 17:23:37 +0000
Subject: [PATCH v12 11/11] genirq/msi: Use the MSI doorbell's IOVA when
 requested
In-Reply-To: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1470158617-7022-12-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the msi_compose() uses the doorbell's physical address.

However in case the MSI doorbell is accessed through an IOMMU that
does not bypass the MSI transactions we need to use an IOVA instead.

iommu_msi_msg_pa_to_va helper, part of the iommu-msi API, detects
the above case and swaps the MSI doorbell physical address with a
pre-allocated/mapped IOVA.

That way the device will send the MSI with this IOVA and the address
will be translated by the IOMMU into the target MSI doorbell PA.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v11 -> v12:
- remove WARN_ON. iommu domain cannot dissapear while msi still are enabled
  so the userspace cannot induce a kernel panic.

v8 -> v9:
- Braces on both sides of the 'else' in msi_compose

v7 -> v8:
- use iommu_msi_msg_pa_to_va
- add WARN_ON

v6 -> v7:
- allocation/mapping is done at an earlier stage. We now just perform
  the iova lookup. So it is safe now to be called in a code that cannot
  sleep. iommu_msi_set_doorbell_iova is moved in the dma-reserved-iommu
  API: I think it cleans things up with respect to various #ifdef CONFIGS.

v5:
- use macros to increase the readability
- add comments
- fix a typo that caused a compilation error if CONFIG_IOMMU_API
  is not set
---
 kernel/irq/msi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 6a3cb14..02c1c71 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -63,10 +63,18 @@ static int msi_compose(struct irq_data *irq_data,
 {
 	int ret = 0;
 
-	if (erase)
+	if (erase) {
 		memset(msg, 0, sizeof(*msg));
-	else
+	} else {
+		struct device *dev;
+
 		ret = irq_chip_compose_msi_msg(irq_data, msg);
+		if (ret)
+			return ret;
+
+		dev = msi_desc_to_dev(irq_data_get_msi_desc(irq_data));
+		ret = iommu_msi_msg_pa_to_va(dev, msg);
+	}
 
 	return ret;
 }
-- 
1.9.1
