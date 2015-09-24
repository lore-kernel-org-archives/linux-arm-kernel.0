From: lho@apm.com (Loc Ho)
Date: Thu, 24 Sep 2015 10:38:07 -0700
Subject: [PATCH] edac: xgene: Fix possible sprintf overflow issue
Message-ID: <1443116287-11752-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace sprintf with snprintf to avoid possible string array overflow.

Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/edac/xgene_edac.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 37121e8..dfa13bb 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -879,7 +879,7 @@ xgene_edac_pmd_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
 	if (!IS_ENABLED(CONFIG_EDAC_DEBUG) || !ctx->edac->dfs)
 		return;
 
-	sprintf(name, "PMD%d", ctx->pmd);
+	snprintf(name, sizeof(name), "PMD%d", ctx->pmd);
 	dbgfs_dir = edac_debugfs_create_dir_at(name, ctx->edac->dfs);
 	if (!dbgfs_dir)
 		return;
@@ -923,7 +923,7 @@ static int xgene_edac_pmd_add(struct xgene_edac *edac, struct device_node *np,
 		goto err_group;
 	}
 
-	sprintf(edac_name, "l2c%d", pmd);
+	snprintf(edac_name, sizeof(edac_name), "l2c%d", pmd);
 	edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
 					      edac_name, 1, "l2c", 1, 2, NULL,
 					      0, edac_device_alloc_index());
@@ -1183,7 +1183,7 @@ xgene_edac_l3_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
 	if (!IS_ENABLED(CONFIG_EDAC_DEBUG) || !ctx->edac->dfs)
 		return;
 
-	sprintf(name, "l3c%d", ctx->edac_idx);
+	snprintf(name, sizeof(name), "l3c%d", ctx->edac_idx);
 	dbgfs_dir = edac_debugfs_create_dir_at(name, ctx->edac->dfs);
 	if (!dbgfs_dir)
 		return;
-- 
1.7.1
