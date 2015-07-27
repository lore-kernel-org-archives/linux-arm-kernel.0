From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 10:32:33 +0530
Subject: [PATCH V2 03/11] OPP: Create _remove_device_opp() for freeing dev_opp
In-Reply-To: <cover.1437972635.git.viresh.kumar@linaro.org>
References: <cover.1437972635.git.viresh.kumar@linaro.org>
Message-ID: <ab91ba59b946addcc9e2c072c5613f9394eed7cf.1437972635.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used from multiple places later. Lets create a separate
routine for that.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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
