From: mail@aurabindo.in (Jay Aurabind)
Date: Wed, 21 May 2014 22:49:54 +0530
Subject: [PATCH V2] mfd: abx500-core: Fix compiler warning larger stack
 frame
In-Reply-To: <20140521091751.GC6679@lee--X1>
References: <536E1543.3090107@aurabindo.in> <20140520152054.GB24991@lee--X1>
 <537C447D.7070406@aurabindo.in> <20140521091751.GC6679@lee--X1>
Message-ID: <537CE03A.7060702@aurabindo.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 21 May 2014 02:47 PM, Lee Jones wrote:
>> Change from V1 -> V2: Fix a potential null pointer dereference as reported by kbuild test robot <fengguang.wu@intel.com>.
>>
>> Inorder to report the kzalloc failure, I have just used a pr_debug statement. If it looks ugly, should I change the function's return value to int and give out an -ENOMEM ?
> 
> Yes, please do that - and obviously add the checks to the calling code.

But I cannot find any calling code. At least thats what linux cross reference has to say.

Change from V2 -> V3:
	Change abx500_dump_all_banks to return int so as to account for error handling.

Change from V1 -> V2: 
	Fix a potential null pointer dereference as reported by kbuild test robot <fengguang.wu@intel.com>.

>From 19d34af7240498b2e624e94b2d003f3d9928dee8 Mon Sep 17 00:00:00 2001
From: Aurabindo J <mail@aurabindo.in>
Date: Wed, 21 May 2014 22:27:30 +0530
Subject: [PATCH] mfd: abx500-core: Fix compiler warning larger stack frame
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On systems with CONFIG_FRAME_WARN=1024, compiler warns the allocation of
an object of struct device on stack. Make the allocation dynamically to
fix the warning. Also change the caller's return type to int so as to
account for error handling.

drivers/mfd/abx500-core.c: In function ?abx500_dump_all_banks?:
drivers/mfd/abx500-core.c:167:1: warning: the frame size of 1032 bytes
is larger than 1024 bytes [-Wframe-larger-than=]

Signed-off-by: Aurabindo J <mail@aurabindo.in>
---
 drivers/mfd/abx500-core.c  | 12 ++++++++----
 include/linux/mfd/abx500.h |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index f3a15aa..d6d0ec4 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -151,19 +151,23 @@ int abx500_startup_irq_enabled(struct device *dev, unsigned int irq)
 }
 EXPORT_SYMBOL(abx500_startup_irq_enabled);
 
-void abx500_dump_all_banks(void)
+int abx500_dump_all_banks(void)
 {
 	struct abx500_ops *ops;
-	struct device dummy_child = {NULL};
+	struct device *dummy_child;
 	struct abx500_device_entry *dev_entry;
 
+	dummy_child = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!dummy_child)
+		return -ENOMEM;
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
 
diff --git a/include/linux/mfd/abx500.h b/include/linux/mfd/abx500.h
index 3301b20..df2508f 100644
--- a/include/linux/mfd/abx500.h
+++ b/include/linux/mfd/abx500.h
@@ -330,7 +330,7 @@ int abx500_mask_and_set_register_interruptible(struct device *dev, u8 bank,
 int abx500_get_chip_id(struct device *dev);
 int abx500_event_registers_startup_state_get(struct device *dev, u8 *event);
 int abx500_startup_irq_enabled(struct device *dev, unsigned int irq);
-void abx500_dump_all_banks(void);
+int abx500_dump_all_banks(void);
 
 struct abx500_ops {
 	int (*get_chip_id) (struct device *);
-- 
1.9.1



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 278 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/3bba61a9/attachment.sig>
