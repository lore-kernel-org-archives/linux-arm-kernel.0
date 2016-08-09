From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  9 Aug 2016 16:18:51 +0200
Subject: [PATCH 1/2] of/irq: Mark interrupt controllers as populated before
 initialisation
Message-ID: <1470752332-14185-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That way the init callback may clear the flag again, in case of drivers
split between early irq chip and a normal platform driver.

Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/of/irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 89a71c6..a2e68f7 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -544,12 +544,15 @@ void __init of_irq_init(const struct of_device_id *matches)
 
 			list_del(&desc->list);
 
+			of_node_set_flag(desc->dev, OF_POPULATED);
+
 			pr_debug("of_irq_init: init %s (%p), parent %p\n",
 				 desc->dev->full_name,
 				 desc->dev, desc->interrupt_parent);
 			ret = desc->irq_init_cb(desc->dev,
 						desc->interrupt_parent);
 			if (ret) {
+				of_node_clear_flag(desc->dev, OF_POPULATED);
 				kfree(desc);
 				continue;
 			}
@@ -559,8 +562,6 @@ void __init of_irq_init(const struct of_device_id *matches)
 			 * its children can get processed in a subsequent pass.
 			 */
 			list_add_tail(&desc->list, &intc_parent_list);
-
-			of_node_set_flag(desc->dev, OF_POPULATED);
 		}
 
 		/* Get the next pending parent that might have children */
-- 
2.8.1
