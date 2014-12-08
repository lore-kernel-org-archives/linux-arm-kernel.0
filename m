From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 8 Dec 2014 23:03:09 +0800
Subject: [PATCH] irqchip: mediatek: Fix error return code detection
Message-ID: <1418050989-21411-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fix an error handling bug reported by Beniamino, this is based on
mtk intpol patches [1]

Joe.C

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/305808.html

====================
of_io_request_and_map() return ERR_PTR wrapped error code instead of
NULL when fail, fix code in mtk_sysirq_of_init() to correctly handle
this.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 7e342df..0b0d2c0 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -137,9 +137,9 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 		return -ENOMEM;
 
 	chip_data->intpol_base = of_io_request_and_map(node, 0, "intpol");
-	if (!chip_data->intpol_base) {
+	if (IS_ERR(chip_data->intpol_base)) {
 		pr_err("mtk_sysirq: unable to map sysirq register\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(chip_data->intpol_base);
 		goto out_free;
 	}
 
-- 
1.8.1.1.dirty
