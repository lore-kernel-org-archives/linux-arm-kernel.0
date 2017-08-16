From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 16 Aug 2017 21:04:42 +0800
Subject: [PATCH] irqchip/gic-v3-its: handle queue wrapping in
 its_wait_for_range_completion()
Message-ID: <1502888682-12148-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the to_idx wrap to 0, (rd_idx >= to_idx) will be true,
but the command is not completed.

When to_idx is smaller than from_idx, it means the queue
is wrapped. For handling this case, add ITS_CMD_QUEUE_SZ
to to_idx and rd_idx to.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6893287..8e47515 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -446,13 +446,18 @@ static void its_wait_for_range_completion(struct its_node *its,
 					  struct its_cmd_block *to)
 {
 	u64 rd_idx, from_idx, to_idx;
+	u32 wrap_offset = 0;
 	u32 count = 1000000;	/* 1s! */
 
 	from_idx = its_cmd_ptr_to_offset(its, from);
 	to_idx = its_cmd_ptr_to_offset(its, to);
+	if (to_idx < from_idx) {
+		wrap_offset = ITS_CMD_QUEUE_SZ;
+		to_idx += ITS_CMD_QUEUE_SZ;
+	}
 
 	while (1) {
-		rd_idx = readl_relaxed(its->base + GITS_CREADR);
+		rd_idx = readl_relaxed(its->base + GITS_CREADR) + wrap_offset;
 		if (rd_idx >= to_idx || rd_idx < from_idx)
 			break;
 
-- 
2.5.0
