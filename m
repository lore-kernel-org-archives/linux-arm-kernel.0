From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 19 Jul 2017 14:42:28 +0300
Subject: [PATCH v3 4/8] staging: fsl-mc: fix compilation with non-generic msi
 domain ops
In-Reply-To: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
References: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
Message-ID: <20170719114232.8347-5-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The bus driver relies on generic msi domain ops.
Fix compilation for architectures that don't provide it (e.g. x86_64).

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Notes:
    -v3
      -no changes
    -v2
      -no changes

 drivers/staging/fsl-mc/bus/fsl-mc-msi.c                | 4 ++++
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
index ee6e3b7..18774ee 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
@@ -17,6 +17,7 @@
 #include <linux/msi.h>
 #include "fsl-mc-private.h"
 
+#ifdef GENERIC_MSI_DOMAIN_OPS
 /*
  * Generate a unique ID identifying the interrupt (only used within the MSI
  * irqdomain.  Combine the icid with the interrupt index.
@@ -38,6 +39,9 @@ static void fsl_mc_msi_set_desc(msi_alloc_info_t *arg,
 	arg->hwirq = fsl_mc_domain_calc_hwirq(to_fsl_mc_device(desc->dev),
 					      desc);
 }
+#else
+#define fsl_mc_msi_set_desc NULL
+#endif
 
 static void fsl_mc_msi_update_dom_ops(struct msi_domain_info *info)
 {
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index e798ea4..cd73c58 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -45,7 +45,9 @@ static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
 	 * NOTE: This device id corresponds to the IOMMU stream ID
 	 * associated with the DPRC object (ICID).
 	 */
+#ifdef GENERIC_MSI_DOMAIN_OPS
 	info->scratchpad[0].ul = mc_bus_dev->icid;
+#endif
 	msi_info = msi_get_domain_info(msi_domain->parent);
 	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
 }
-- 
2.9.4
