From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 5 Sep 2012 14:53:46 +0800
Subject: [PATCH] [ARM] msm: dma: use list_move_tail instead of
 list_del/list_add_tail
Message-ID: <CAPgLHd9biJTeYFwR-OOgJVbRCo=2bvG6NjXMz_b_w61vdjy9jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Using list_move_tail() instead of list_del() + list_add_tail().

spatch with a semantic match is used to found this problem.
(http://coccinelle.lip6.fr/)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-msm/dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/dma.c b/arch/arm/mach-msm/dma.c
index 02cae5e..354b91d 100644
--- a/arch/arm/mach-msm/dma.c
+++ b/arch/arm/mach-msm/dma.c
@@ -223,8 +223,7 @@ static irqreturn_t msm_datamover_irq_handler(int irq, void *dev_id)
 			PRINT_FLOW("msm_datamover_irq_handler id %d, status %x\n", id, ch_status);
 			if ((ch_status & DMOV_STATUS_CMD_PTR_RDY) && !list_empty(&ready_commands[id])) {
 				cmd = list_entry(ready_commands[id].next, typeof(*cmd), list);
-				list_del(&cmd->list);
-				list_add_tail(&cmd->list, &active_commands[id]);
+				list_move_tail(&cmd->list, &active_commands[id]);
 				if (cmd->execute_func)
 					cmd->execute_func(cmd);
 				PRINT_FLOW("msm_datamover_irq_handler id %d, start command\n", id);
