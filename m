From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 25 Apr 2013 18:14:51 +0100
Subject: [PATCH v2] mfd: vexpress: Handle pending config transactions
In-Reply-To: <1366821084-12815-1-git-send-email-pawel.moll@arm.com>
References: <1366821084-12815-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1366910091-17971-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config transactions "scheduler" was hopelessly broken,
repeating completed transaction instead of picking up
next pending one.

Fixed now. Also improved debug messages.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mfd/vexpress-config.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/vexpress-config.c b/drivers/mfd/vexpress-config.c
index 3c1723aa..84ce6b9 100644
--- a/drivers/mfd/vexpress-config.c
+++ b/drivers/mfd/vexpress-config.c
@@ -184,13 +184,14 @@ static int vexpress_config_schedule(struct vexpress_config_trans *trans)
 
 	spin_lock_irqsave(&bridge->transactions_lock, flags);
 
-	vexpress_config_dump_trans("Executing", trans);
-
-	if (list_empty(&bridge->transactions))
+	if (list_empty(&bridge->transactions)) {
+		vexpress_config_dump_trans("Executing", trans);
 		status = bridge->info->func_exec(trans->func->func,
 				trans->offset, trans->write, trans->data);
-	else
+	} else {
+		vexpress_config_dump_trans("Queuing", trans);
 		status = VEXPRESS_CONFIG_STATUS_WAIT;
+	}
 
 	switch (status) {
 	case VEXPRESS_CONFIG_STATUS_DONE:
@@ -212,25 +213,31 @@ void vexpress_config_complete(struct vexpress_config_bridge *bridge,
 {
 	struct vexpress_config_trans *trans;
 	unsigned long flags;
+	const char *message = "Completed";
 
 	spin_lock_irqsave(&bridge->transactions_lock, flags);
 
 	trans = list_first_entry(&bridge->transactions,
 			struct vexpress_config_trans, list);
-	vexpress_config_dump_trans("Completed", trans);
-
 	trans->status = status;
-	list_del(&trans->list);
 
-	if (!list_empty(&bridge->transactions)) {
-		vexpress_config_dump_trans("Pending", trans);
+	do {
+		vexpress_config_dump_trans(message, trans);
+		list_del(&trans->list);
+		complete(&trans->completion);
 
-		bridge->info->func_exec(trans->func->func, trans->offset,
-				trans->write, trans->data);
-	}
-	spin_unlock_irqrestore(&bridge->transactions_lock, flags);
+		if (list_empty(&bridge->transactions))
+			break;
+
+		trans = list_first_entry(&bridge->transactions,
+				struct vexpress_config_trans, list);
+		vexpress_config_dump_trans("Executing pending", trans);
+		trans->status = bridge->info->func_exec(trans->func->func,
+				trans->offset, trans->write, trans->data);
+		message = "Finished pending";
+	} while (trans->status == VEXPRESS_CONFIG_STATUS_DONE);
 
-	complete(&trans->completion);
+	spin_unlock_irqrestore(&bridge->transactions_lock, flags);
 }
 EXPORT_SYMBOL(vexpress_config_complete);
 
-- 
1.7.10.4
