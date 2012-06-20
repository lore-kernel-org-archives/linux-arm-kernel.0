From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:39 +0100
Subject: [PATCH 03/15] mfd: Make MFD core code Device Tree and IRQ domain aware
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During Device Tree enablement of the ab8500 and db8500-prcmu drivers,
a decision was made to omit registration through the MFD API and use
Device Tree directly. However, because MFD devices have a different
address space and the ab8500 and db8500 both use I2C to communicate,
this causes issues with address translation during execution of
of_platform_populate(). So the solution is to make the MFD core aware
of Device Tree and have it assign the correct node pointers instead.

To make this work the MFD core also needs to be awere of IRQ domains,
as Device Tree insists on IRQ domain compatibility. So, instead of
providing an irq-base via platform code, in the DT case we simply
look up the IRQ domain and map to the correct virtual IRQ.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c   |   31 +++++++++++++++++++++++++++----
 include/linux/mfd/core.h |    1 +
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index ffc3d48..effc4f5 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -18,6 +18,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
 
 int mfd_cell_enable(struct platform_device *pdev)
 {
@@ -76,6 +78,8 @@ static int mfd_add_device(struct device *parent, int id,
 {
 	struct resource *res;
 	struct platform_device *pdev;
+	struct device_node *np = NULL;
+	struct irq_domain *domain = NULL;
 	int ret = -ENOMEM;
 	int r;
 
@@ -89,6 +93,18 @@ static int mfd_add_device(struct device *parent, int id,
 
 	pdev->dev.parent = parent;
 
+	if (parent->of_node) {
+		if (cell->of_compatible) {
+			for_each_child_of_node(parent->of_node, np) {
+				if (of_device_is_compatible(np, cell->of_compatible)) {
+					pdev->dev.of_node = np;
+					domain = irq_find_host(parent->of_node);
+					break;
+				}
+			}
+		}
+	}
+
 	if (cell->pdata_size) {
 		ret = platform_device_add_data(pdev,
 					cell->platform_data, cell->pdata_size);
@@ -112,10 +128,17 @@ static int mfd_add_device(struct device *parent, int id,
 			res[r].end = mem_base->start +
 				cell->resources[r].end;
 		} else if (cell->resources[r].flags & IORESOURCE_IRQ) {
-			res[r].start = irq_base +
-				cell->resources[r].start;
-			res[r].end   = irq_base +
-				cell->resources[r].end;
+			if (domain) {
+				/* Unable to create mappings for IRQ ranges. */
+				WARN_ON(cell->resources[r].start != cell->resources[r].end);
+				res[r].start = res[r].end = irq_create_mapping(
+					domain, cell->resources[r].start);
+			} else {
+				res[r].start = irq_base +
+					cell->resources[r].start;
+				res[r].end   = irq_base +
+					cell->resources[r].end;
+			}
 		} else {
 			res[r].parent = cell->resources[r].parent;
 			res[r].start = cell->resources[r].start;
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 4e76163..99b7eb1 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -36,6 +36,7 @@ struct mfd_cell {
 	/* platform data passed to the sub devices drivers */
 	void			*platform_data;
 	size_t			pdata_size;
+	const char		*of_compatible;
 
 	/*
 	 * These resources can be specified relative to the parent device.
-- 
1.7.9.5
