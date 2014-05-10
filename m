From: mail@aurabindo.in (Jay Aurabind)
Date: Sat, 10 May 2014 17:32:11 +0530
Subject: [PATCH] mfd: abx500-core: Fix compiler warning larger stack frame
Message-ID: <536E1543.3090107@aurabindo.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 95f6ac368dbe352af0dfa2097b7d58b416447be5 Mon Sep 17 00:00:00 2001
From: Aurabindo J <mail@aurabindo.in>
Date: Sat, 10 May 2014 15:16:58 +0530
Subject: [PATCH] mfd: abx500-core: Fix compiler warning larger stack frame

On systems with CONFIG_FRAME_WARN=1024, compiler warns the allocation of
an object of struct device on stack. Make the allocation dynamically to
fix the warning.

drivers/mfd/abx500-core.c: In function ?abx500_dump_all_banks?:
drivers/mfd/abx500-core.c:167:1: warning: the frame size of 1032 bytes
is larger than 1024 bytes [-Wframe-larger-than=]

Signed-off-by: Aurabindo J <mail@aurabindo.in>
---
 drivers/mfd/abx500-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index f3a15aa..87d80c3 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -154,16 +154,19 @@ EXPORT_SYMBOL(abx500_startup_irq_enabled);
 void abx500_dump_all_banks(void)
 {
 	struct abx500_ops *ops;
-	struct device dummy_child = {NULL};
+	struct device *dummy_child;
 	struct abx500_device_entry *dev_entry;

+	dummy_child = kzalloc(sizeof(struct device), GFP_KERNEL);
+
 	list_for_each_entry(dev_entry, &abx500_list, list) {
-		dummy_child.parent = dev_entry->dev;
+		dummy_child->parent = dev_entry->dev;
 		ops = &dev_entry->ops;

 		if ((ops != NULL) && (ops->dump_all_banks != NULL))
-			ops->dump_all_banks(&dummy_child);
+			ops->dump_all_banks(dummy_child);
 	}
+	kfree(dummy_child);
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140510/f96bad0f/attachment.sig>
