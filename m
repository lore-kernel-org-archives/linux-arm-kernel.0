From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 30 Apr 2012 12:14:21 -0700
Subject: [PATCH 11/20] of/irq: add retry support for interrupt controller tree
 initialization
In-Reply-To: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1335813270-13083-12-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow a interrupt-controller initializtion call to report -EAGAIN to notify
that its initializtion has not been completed since one or more of its
interrupt-parent has not yet been initialized.

Suggested-by: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/of/irq.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index a520363..bbe6039 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -418,8 +418,6 @@ void __init of_irq_init(const struct of_device_id *matches)
 	INIT_LIST_HEAD(&intc_parent_list);
 
 	for_each_matching_node(np, matches) {
-		if (!of_find_property(np, "interrupt-controller", NULL))
-			continue;
 		/*
 		 * Here, we allocate and populate an intc_desc with the node
 		 * pointer, interrupt-parent device_node etc.
@@ -454,7 +452,6 @@ void __init of_irq_init(const struct of_device_id *matches)
 			if (desc->interrupt_parent != parent)
 				continue;
 
-			list_del(&desc->list);
 			match = of_match_node(matches, desc->dev);
 			if (WARN(!match->data,
 			    "of_irq_init: no init function for %s\n",
@@ -468,6 +465,15 @@ void __init of_irq_init(const struct of_device_id *matches)
 				 desc->dev, desc->interrupt_parent);
 			irq_init_cb = match->data;
 			ret = irq_init_cb(desc->dev, desc->interrupt_parent);
+			if (ret == -EAGAIN)
+				/* 
+				 * Interrupt controller's initialization did not
+				 * complete and should be retried. So let its
+				 * intc_desc be on intc_desc_list.
+				 */
+				continue;
+			list_del(&desc->list);
+
 			if (ret) {
 				kfree(desc);
 				continue;
@@ -484,7 +490,18 @@ void __init of_irq_init(const struct of_device_id *matches)
 		desc = list_first_entry(&intc_parent_list, typeof(*desc), list);
 		if (list_empty(&intc_parent_list) || !desc) {
 			pr_err("of_irq_init: children remain, but no parents\n");
-			break;
+			/*
+			 * If a search with NULL as parent did not result in any
+			 * new parent being found, then the scan for matching
+			 * interrupt controller nodes is considered as complete.
+			 * Otherwise, if there are pending elements on the
+			 * intc_desc_list, then retry this process again with
+			 * NULL as parent.
+			 */
+			if (!parent)
+				break;
+			parent = NULL;
+			continue;
 		}
 		list_del(&desc->list);
 		parent = desc->dev;
-- 
1.7.5.4
