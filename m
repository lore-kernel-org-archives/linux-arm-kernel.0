From: david.andrey@netmodule.com (David Andrey)
Date: Mon, 22 Apr 2013 14:22:41 +0200
Subject: [PATCH] clk: remove clock notifier at unregister
Message-ID: <1366633361-28887-1-git-send-email-david.andrey@netmodule.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock notifier node is now removed from the
notifier list during unregister

Signed-off-by: David Andrey <david.andrey@netmodule.com>
Acked-by: Martin Meuli <martin.meuli@netmodule.com>
---
 drivers/clk/clk.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 20ce67f..eb66434 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1941,7 +1941,10 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
 
 		/* XXX the notifier code should handle this better */
 		if (!cn->notifier_head.head) {
+			if (clk->notifier_count)
+				BUG();
 			srcu_cleanup_notifier_head(&cn->notifier_head);
+			list_del(&cn->node);
 			kfree(cn);
 		}
 
-- 
1.7.4.1
