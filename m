From: s-anna@ti.com (Suman Anna)
Date: Thu, 13 Feb 2014 12:15:37 -0600
Subject: [PATCHv2 06/16] iommu/omap: allocate archdata on the fly for DT-based
 devices
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Message-ID: <1392315347-32967-7-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The OMAP IOMMU driver locates the IOMMU associated to a device using the
IOMMU name stored in the device archdata iommu field. That field is
expected to be populated by platform code and is left unset for DT-based
devices. This results in a crash when the IOMMU driver attaches a domain
to a device.

Fix this by allocating the archdata iommu structure when devices are
added and freeing when they are removed. Devices without an OF node, and
devices without an iommus property in their OF node are ignored. The
iommu name is initialized from the IOMMU device node name.

This should be simplified when removing non-DT support completely from
the IOMMU users as the IOMMU name won't be needed anymore, and the
IOMMU device pointer could then be stored in the archdata iommu field
directly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[s-anna at ti.com: updated to use device name instead of OF name]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e64025a..f6afe8f 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1256,6 +1256,49 @@ static int omap_iommu_domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
+static int omap_iommu_add_device(struct device *dev)
+{
+	struct omap_iommu_arch_data *arch_data;
+	struct device_node *np;
+
+	/*
+	 * Allocate the archdata iommu structure for DT-based devices.
+	 *
+	 * TODO: Simplify this when removing non-DT support completely from the
+	 * IOMMU users.
+	 */
+	if (!dev->of_node)
+		return 0;
+
+	np = of_parse_phandle(dev->of_node, "iommus", 0);
+	if (!np)
+		return 0;
+
+	arch_data = kzalloc(sizeof(*arch_data), GFP_KERNEL);
+	if (!arch_data) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	arch_data->name = kstrdup(dev_name(dev), GFP_KERNEL);
+	dev->archdata.iommu = arch_data;
+
+	of_node_put(np);
+
+	return 0;
+}
+
+static void omap_iommu_remove_device(struct device *dev)
+{
+	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
+
+	if (!dev->of_node || !arch_data)
+		return;
+
+	kfree(arch_data->name);
+	kfree(arch_data);
+}
+
 static struct iommu_ops omap_iommu_ops = {
 	.domain_init	= omap_iommu_domain_init,
 	.domain_destroy	= omap_iommu_domain_destroy,
@@ -1265,6 +1308,8 @@ static struct iommu_ops omap_iommu_ops = {
 	.unmap		= omap_iommu_unmap,
 	.iova_to_phys	= omap_iommu_iova_to_phys,
 	.domain_has_cap	= omap_iommu_domain_has_cap,
+	.add_device	= omap_iommu_add_device,
+	.remove_device	= omap_iommu_remove_device,
 	.pgsize_bitmap	= OMAP_IOMMU_PGSIZES,
 };
 
-- 
1.8.5.3
