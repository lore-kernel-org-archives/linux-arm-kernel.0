From: mail@aurabindo.in (Jay Aurabind)
Date: Wed, 21 May 2014 11:45:25 +0530
Subject: [PATCH V2] mfd: abx500-core: Fix compiler warning larger stack
 frame
In-Reply-To: <20140520152054.GB24991@lee--X1>
References: <536E1543.3090107@aurabindo.in> <20140520152054.GB24991@lee--X1>
Message-ID: <537C447D.7070406@aurabindo.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H1,

Change from V1 -> V2: Fix a potential null pointer dereference as reported by kbuild test robot <fengguang.wu@intel.com>.

Inorder to report the kzalloc failure, I have just used a pr_debug statement. If it looks ugly, should I change the function's return value to int and give out an -ENOMEM ?

>From 6615c7a995a6bb4dcf4c1e9ac59bca823ec821a5 Mon Sep 17 00:00:00 2001
From: Aurabindo J <mail@aurabindo.in>
Date: Wed, 21 May 2014 11:18:10 +0530
Subject: [PATCH] mfd: abx500-core: Fix compiler warning larger stack frame

On systems with CONFIG_FRAME_WARN=1024, compiler warns the allocation of
an object of struct device on stack. Make the allocation dynamically to
fix the warning.

Signed-off-by: Aurabindo J <mail@aurabindo.in>
---
 drivers/mfd/abx500-core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index f3a15aa..5e5098d 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -154,16 +154,21 @@ EXPORT_SYMBOL(abx500_startup_irq_enabled);
 void abx500_dump_all_banks(void)
 {
 	struct abx500_ops *ops;
-	struct device dummy_child = {NULL};
+	struct device *dummy_child;
 	struct abx500_device_entry *dev_entry;
 
-	list_for_each_entry(dev_entry, &abx500_list, list) {
-		dummy_child.parent = dev_entry->dev;
-		ops = &dev_entry->ops;
+	dummy_child = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (dummy_child != NULL) {
+		list_for_each_entry(dev_entry, &abx500_list, list) {
+			dummy_child->parent = dev_entry->dev;
+			ops = &dev_entry->ops;
 
-		if ((ops != NULL) && (ops->dump_all_banks != NULL))
-			ops->dump_all_banks(&dummy_child);
-	}
+			if ((ops != NULL) && (ops->dump_all_banks != NULL))
+				ops->dump_all_banks(dummy_child);
+		}
+		kfree(dummy_child);
+	} else
+		pr_debug("kzalloc failure in abx500_dump_all_banks\n");
 }
 EXPORT_SYMBOL(abx500_dump_all_banks);
 
-- 
1.9.1



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 278 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/8791bd05/attachment.sig>
