From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 23 Sep 2017 13:50:19 -0500
Subject: [PATCH] irqchip/gic-v3-its: Fix the incorrect BUG_ON in
 its_init_vpe_domain()
Message-ID: <1506192619-15503-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver probe path hits 'BUG_ON(entries != vpe_proxy.dev->nr_ites)'
on systems where it has VLPI capability, doesn't support direct LPI
feature and boot with a single CPU.

Relax the BUG_ON() condition to fix the issue.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e8d8934..e3a59f4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2851,7 +2851,7 @@ static int its_init_vpe_domain(void)
 		return -ENOMEM;
 	}
 
-	BUG_ON(entries != vpe_proxy.dev->nr_ites);
+	BUG_ON(entries > vpe_proxy.dev->nr_ites);
 
 	raw_spin_lock_init(&vpe_proxy.lock);
 	vpe_proxy.next_victim = 0;
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
