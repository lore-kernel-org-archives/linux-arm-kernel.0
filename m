From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Thu, 13 Apr 2017 15:33:07 +0800
Subject: [PATCH 3/3] media: mtk-mdp: Fix mdp device tree
In-Reply-To: <1492068787-17838-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1492068787-17838-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1492068787-17838-4-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

If the mdp_* nodes are under an mdp sub-node, their corresponding
platform device does not automatically get its iommu assigned properly.

Fix this by moving the mdp component nodes up a level such that they are
siblings of mdp and all other SoC subsystems.  This also simplifies the
device tree.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>

---
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index 9e4eb7d..a5ad586 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -118,7 +118,7 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 	mutex_init(&mdp->vpulock);
 
 	/* Iterate over sibling MDP function blocks */
-	for_each_child_of_node(dev->of_node, node) {
+	for_each_child_of_node(dev->of_node->parent, node) {
 		const struct of_device_id *of_id;
 		enum mtk_mdp_comp_type comp_type;
 		int comp_id;
-- 
1.9.1
