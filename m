From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Fri, 16 Jun 2017 17:46:51 +0530
Subject: [PATCH] soc: ti: knav: Fix compilation warning.
Message-ID: <c08b7f37152f2b550dcb90d03a6dc38df6c24575.1497615042.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace '%d' by '%zu' to fix the following compilation warning:-

drivers/soc/ti/knav_qmss_queue.c: In function ?knav_queue_setup_link_ram?:
drivers/soc/ti/knav_qmss_queue.c:1166:3: warning: format ?%x? expects argument of type ?unsigned int?, but argument 6 has type ?size_t? [-Wformat=]
   dev_dbg(kdev->dev, "linkram0: dma:%pad, virt:%p, size:%x\n",
   ^
drivers/soc/ti/knav_qmss_queue.c:1175:3: warning: format ?%x? expects argument of type ?unsigned int?, but argument 6 has type ?size_t? [-Wformat=]
   dev_dbg(kdev->dev, "linkram1: dma:%pad, virt:%p, size:%x\n",

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 279e7c5..2ec3536 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1163,7 +1163,7 @@ static int knav_queue_setup_link_ram(struct knav_device *kdev)
 
 	for_each_qmgr(kdev, qmgr) {
 		block = &kdev->link_rams[0];
-		dev_dbg(kdev->dev, "linkram0: dma:%pad, virt:%p, size:%x\n",
+		dev_dbg(kdev->dev, "linkram0: dma:%pad, virt:%p, size:%zu\n",
 			&block->dma, block->virt, block->size);
 		writel_relaxed((u32)block->dma, &qmgr->reg_config->link_ram_base0);
 		writel_relaxed(block->size, &qmgr->reg_config->link_ram_size0);
@@ -1172,7 +1172,7 @@ static int knav_queue_setup_link_ram(struct knav_device *kdev)
 		if (!block->size)
 			continue;
 
-		dev_dbg(kdev->dev, "linkram1: dma:%pad, virt:%p, size:%x\n",
+		dev_dbg(kdev->dev, "linkram1: dma:%pad, virt:%p, size:%zu\n",
 			&block->dma, block->virt, block->size);
 		writel_relaxed(block->dma, &qmgr->reg_config->link_ram_base1);
 	}
-- 
1.9.1
