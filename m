From: bp@alien8.de (Borislav Petkov)
Date: Tue, 22 Sep 2015 18:37:05 +0200
Subject: [PATCH 5/5] EDAC, xgene: Convert to debugfs wrappers
In-Reply-To: <1442939825-13455-1-git-send-email-bp@alien8.de>
References: <20150922163405.GC3437@pd.tnic>
 <1442939825-13455-1-git-send-email-bp@alien8.de>
Message-ID: <1442939825-13455-5-git-send-email-bp@alien8.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Borislav Petkov <bp@suse.de>

Drop CONFIG_EDAC_DEBUG ifdeffery too, while at it.

Cc: Loc Ho <lho@apm.com>
Cc: linux-edac at vger.kernel.org
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/xgene_edac.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index ba06904af2e1..5ff42d5b019d 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -29,6 +29,7 @@
 #include <linux/regmap.h>
 
 #include "edac_core.h"
+#include "edac_module.h"
 
 #define EDAC_MOD_STR			"xgene_edac"
 
@@ -172,12 +173,12 @@ static void xgene_edac_mc_create_debugfs_node(struct mem_ctl_info *mci)
 {
 	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
 		return;
-#ifdef CONFIG_EDAC_DEBUG
+
 	if (!mci->debugfs)
 		return;
-	debugfs_create_file("inject_ctrl", S_IWUSR, mci->debugfs, mci,
-			    &xgene_edac_mc_debug_inject_fops);
-#endif
+
+	edac_debugfs_create_file("inject_ctrl", S_IWUSR, mci->debugfs, mci,
+				 &xgene_edac_mc_debug_inject_fops);
 }
 
 static void xgene_edac_mc_check(struct mem_ctl_info *mci)
@@ -881,7 +882,7 @@ static void xgene_edac_pmd_create_debugfs_nodes(
 	struct edac_device_ctl_info *edac_dev)
 {
 	struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
-	struct dentry *edac_debugfs;
+	struct dentry *dbgfs_dir;
 	char name[30];
 
 	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
@@ -892,20 +893,19 @@ static void xgene_edac_pmd_create_debugfs_nodes(
 	 *       when available.
 	 */
 	if (!ctx->edac->dfs) {
-		ctx->edac->dfs = debugfs_create_dir(edac_dev->dev->kobj.name,
-						    NULL);
+		ctx->edac->dfs = edac_debugfs_create_dir(edac_dev->dev->kobj.name);
 		if (!ctx->edac->dfs)
 			return;
 	}
 	sprintf(name, "PMD%d", ctx->pmd);
-	edac_debugfs = debugfs_create_dir(name, ctx->edac->dfs);
-	if (!edac_debugfs)
+	dbgfs_dir = edac_debugfs_create_dir_at(name, ctx->edac->dfs);
+	if (!dbgfs_dir)
 		return;
 
-	debugfs_create_file("l1_inject_ctrl", S_IWUSR, edac_debugfs, edac_dev,
-			    &xgene_edac_pmd_debug_inject_fops[0]);
-	debugfs_create_file("l2_inject_ctrl", S_IWUSR, edac_debugfs, edac_dev,
-			    &xgene_edac_pmd_debug_inject_fops[1]);
+	edac_debugfs_create_file("l1_inject_ctrl", S_IWUSR, dbgfs_dir, edac_dev,
+				 &xgene_edac_pmd_debug_inject_fops[0]);
+	edac_debugfs_create_file("l2_inject_ctrl", S_IWUSR, dbgfs_dir, edac_dev,
+				 &xgene_edac_pmd_debug_inject_fops[1]);
 }
 
 static int xgene_edac_pmd_available(u32 efuse, int pmd)
-- 
2.3.5
