From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 27 Nov 2014 08:54:07 +0530
Subject: [PATCH V1 5/8] opp: replace kfree_rcu() with call_srcu() in
 opp_set_availability()
In-Reply-To: <9a64eb3d9d11ff7379b7eb6d9207625175f28e47.1417058376.git.viresh.kumar@linaro.org>
References: <f815d0855c1bd28d8389554176acd2620e56b3c8.1416910766.git.viresh.kumar@linaro.org>
 <9a64eb3d9d11ff7379b7eb6d9207625175f28e47.1417058376.git.viresh.kumar@linaro.org>
Message-ID: <268325a89f657777924a52082749d8342e4ef79f.1417058376.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This existed before we introduced call_srcu() in opp layer to synchronize with
srcu_notifier_call_chain() while removing OPPs. And is a potential bug which
wasn't noticed earlier.

Let fix it as well by using the right API to free OPP.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 977474a..2d195f3 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -641,7 +641,7 @@ static int opp_set_availability(struct device *dev, unsigned long freq,
 
 	list_replace_rcu(&opp->node, &new_opp->node);
 	mutex_unlock(&dev_opp_list_lock);
-	kfree_rcu(opp, rcu_head);
+	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, kfree_opp_rcu);
 
 	/* Notify the change of the OPP availability */
 	if (availability_req)
-- 
2.0.3.693.g996b0fd
