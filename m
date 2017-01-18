From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 18 Jan 2017 17:39:35 -0500
Subject: [PATCH 05/10] soc/qbman: Rework ioremap() calls for ARM/PPC
In-Reply-To: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1484779180-1344-6-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework ioremap() for PPC and ARM. The PPC devices require a
non-coherent mapping while ARM will work with a non-cachable/write
combine mapping.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/bman_portal.c |   16 +++++++++++++---
 drivers/soc/fsl/qbman/qman_portal.c |   16 +++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index 8354d4d..a661f30 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -125,7 +125,18 @@ static int bman_portal_probe(struct platform_device *pdev)
 	}
 	pcfg->irq = irq;
 
-	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
+#ifdef CONFIG_PPC
+	/* PPC requires a cacheable/non-coherent mapping of the portal */
+	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),
+			  (pgprot_val(PAGE_KERNEL) & ~_PAGE_COHERENT));
+#else
+	/*
+	 * For ARM we can use write combine mapping.  A cacheable/non shareable
+	 * mapping will perform better but equires additional platform
+	 * support which is not currently available
+	 */
+	va = ioremap_wc(addr_phys[0]->start, resource_size(addr_phys[0]));
+#endif
 	if (!va) {
 		dev_err(dev, "ioremap::CE failed\n");
 		goto err_ioremap1;
@@ -133,8 +144,7 @@ static int bman_portal_probe(struct platform_device *pdev)
 
 	pcfg->addr_virt[DPAA_PORTAL_CE] = va;
 
-	va = ioremap_prot(addr_phys[1]->start, resource_size(addr_phys[1]),
-			  _PAGE_GUARDED | _PAGE_NO_CACHE);
+	va = ioremap(addr_phys[1]->start, resource_size(addr_phys[1]));
 	if (!va) {
 		dev_err(dev, "ioremap::CI failed\n");
 		goto err_ioremap2;
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index adbaa30..e7a9eef 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -265,7 +265,18 @@ static int qman_portal_probe(struct platform_device *pdev)
 	}
 	pcfg->irq = irq;
 
-	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
+#ifdef CONFIG_PPC
+	/* PPC requires a cacheable/non-coherent mapping of the portal */
+	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),
+			  (pgprot_val(PAGE_KERNEL) & ~_PAGE_COHERENT));
+#else
+	/*
+	 * For ARM we can use write combine mapping.  A cacheable/non shareable
+	 * mapping will perform better but equires additional platform
+	 * support which is not currently available
+	 */
+	va = ioremap_wc(addr_phys[0]->start, resource_size(addr_phys[0]));
+#endif
 	if (!va) {
 		dev_err(dev, "ioremap::CE failed\n");
 		goto err_ioremap1;
@@ -273,8 +284,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 
 	pcfg->addr_virt[DPAA_PORTAL_CE] = va;
 
-	va = ioremap_prot(addr_phys[1]->start, resource_size(addr_phys[1]),
-			  _PAGE_GUARDED | _PAGE_NO_CACHE);
+	va = ioremap(addr_phys[1]->start, resource_size(addr_phys[1]));
 	if (!va) {
 		dev_err(dev, "ioremap::CI failed\n");
 		goto err_ioremap2;
-- 
1.7.9.5
