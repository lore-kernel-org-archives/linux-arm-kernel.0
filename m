From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 26 Mar 2018 15:05:31 -0400
Subject: [PATCH v3 1/4] drivers/staging/fsl-mc: Use memremap for DPIO cache
 enabled area
In-Reply-To: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
References: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1522091134-24646-2-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the mapping of the QBMan cache enabled area from using ioremap_wc()
to memremap(). This allows the __iomem attribute to be removed from the
pointer (which makes sense as accesses try this as cacheable memory not
IO memory).  These changes allow sparse checks to pass.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c  | 8 +++++---
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h | 4 ++--
 drivers/staging/fsl-mc/include/dpaa2-io.h      | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index 182b384..e00f473 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -13,6 +13,7 @@
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 
 #include <linux/fsl/mc.h>
 #include "../../include/dpaa2-io.h"
@@ -146,10 +147,11 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	 * Set the CENA regs to be the cache inhibited area of the portal to
 	 * avoid coherency issues if a user migrates to another core.
 	 */
-	desc.regs_cena = ioremap_wc(dpio_dev->regions[1].start,
-		resource_size(&dpio_dev->regions[1]));
+	desc.regs_cena = memremap(dpio_dev->regions[1].start,
+				  resource_size(&dpio_dev->regions[1]),
+				  MEMREMAP_WC);
 	desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
-		resource_size(&dpio_dev->regions[1]));
+				 resource_size(&dpio_dev->regions[1]));
 
 	err = fsl_mc_allocate_irqs(dpio_dev);
 	if (err) {
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
index 4488a44..69db3c8 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
@@ -15,7 +15,7 @@ struct qbman_swp;
 /* qbman software portal descriptor structure */
 struct qbman_swp_desc {
 	void *cena_bar; /* Cache-enabled portal base address */
-	void *cinh_bar; /* Cache-inhibited portal base address */
+	void __iomem *cinh_bar; /* Cache-inhibited portal base address */
 	u32 qman_version;
 };
 
@@ -102,7 +102,7 @@ struct qbman_release_desc {
 /* portal data structure */
 struct qbman_swp {
 	const struct qbman_swp_desc *desc;
-	void __iomem *addr_cena;
+	void *addr_cena;
 	void __iomem *addr_cinh;
 
 	/* Management commands */
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/drivers/staging/fsl-mc/include/dpaa2-io.h
index f71227d..ab51e40 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-io.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-io.h
@@ -52,7 +52,7 @@ struct dpaa2_io_desc {
 	int has_8prio;
 	int cpu;
 	void *regs_cena;
-	void *regs_cinh;
+	void __iomem *regs_cinh;
 	int dpio_id;
 	u32 qman_version;
 };
-- 
2.7.4
