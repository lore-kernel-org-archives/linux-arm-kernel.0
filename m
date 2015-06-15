From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 15 Jun 2015 17:27:28 +0530
Subject: [PATCH 02/10] OPP: Create _remove_device_opp() for freeing dev_opp
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Message-ID: <fba1ec728e2ecf9303e13372a2557d886aa7e49c.1434369079.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used from multiple places later. Lets create a separate
routine for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 8c3fd57975fb..7895fdd64192 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -449,6 +449,22 @@ static void _kfree_device_rcu(struct rcu_head *head)
 }
 
 /**
+ * _remove_device_opp() - Removes a device OPP table
+ * @dev_opp: device OPP table to be removed.
+ *
+ * Removes/frees device OPP table it it doesn't contain any OPPs.
+ */
+static void _remove_device_opp(struct device_opp *dev_opp)
+{
+	if (!list_empty(&dev_opp->opp_list))
+		return;
+
+	list_del_rcu(&dev_opp->node);
+	call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
+		  _kfree_device_rcu);
+}
+
+/**
  * _kfree_opp_rcu() - Free OPP RCU handler
  * @head:	RCU head
  */
@@ -481,11 +497,7 @@ static void _opp_remove(struct device_opp *dev_opp,
 	list_del_rcu(&opp->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
 
-	if (list_empty(&dev_opp->opp_list)) {
-		list_del_rcu(&dev_opp->node);
-		call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
-			  _kfree_device_rcu);
-	}
+	_remove_device_opp(dev_opp);
 }
 
 /**
-- 
2.4.0
