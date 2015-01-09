From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Jan 2015 17:55:09 +0000
Subject: [PATCH 1/2] irqchip: gicv3-its: Fix unsafe locking reported by lockdep
In-Reply-To: <1420826110-1697-1-git-send-email-marc.zyngier@arm.com>
References: <1420826110-1697-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1420826110-1697-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiled with CONFIG_LOCKDEP, the kernel shouts badly, saying
that my locking is unsafe. I'm afraid the kernel is right:

       CPU0                    CPU1
       ----                    ----
  lock(&its->lock);
                               local_irq_disable();
                               lock(&irq_desc_lock_class);
                               lock(&its->lock);
  <Interrupt>
    lock(&irq_desc_lock_class);

 *** DEADLOCK ***

The fix is to always take its->lock with interrupts disabled.

Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2a2fb2e..c5c1a3c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -415,13 +415,14 @@ static void its_send_single_command(struct its_node *its,
 {
 	struct its_cmd_block *cmd, *sync_cmd, *next_cmd;
 	struct its_collection *sync_col;
+	unsigned long flags;
 
-	raw_spin_lock(&its->lock);
+	raw_spin_lock_irqsave(&its->lock, flags);
 
 	cmd = its_allocate_entry(its);
 	if (!cmd) {		/* We're soooooo screewed... */
 		pr_err_ratelimited("ITS can't allocate, dropping command\n");
-		raw_spin_unlock(&its->lock);
+		raw_spin_unlock_irqrestore(&its->lock, flags);
 		return;
 	}
 	sync_col = builder(cmd, desc);
@@ -441,7 +442,7 @@ static void its_send_single_command(struct its_node *its,
 
 post:
 	next_cmd = its_post_commands(its);
-	raw_spin_unlock(&its->lock);
+	raw_spin_unlock_irqrestore(&its->lock, flags);
 
 	its_wait_for_range_completion(its, cmd, next_cmd);
 }
@@ -1019,8 +1020,9 @@ static void its_cpu_init_collection(void)
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
 {
 	struct its_device *its_dev = NULL, *tmp;
+	unsigned long flags;
 
-	raw_spin_lock(&its->lock);
+	raw_spin_lock_irqsave(&its->lock, flags);
 
 	list_for_each_entry(tmp, &its->its_device_list, entry) {
 		if (tmp->device_id == dev_id) {
@@ -1029,7 +1031,7 @@ static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
 		}
 	}
 
-	raw_spin_unlock(&its->lock);
+	raw_spin_unlock_irqrestore(&its->lock, flags);
 
 	return its_dev;
 }
@@ -1039,6 +1041,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 {
 	struct its_device *dev;
 	unsigned long *lpi_map;
+	unsigned long flags;
 	void *itt;
 	int lpi_base;
 	int nr_lpis;
@@ -1074,9 +1077,9 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	dev->device_id = dev_id;
 	INIT_LIST_HEAD(&dev->entry);
 
-	raw_spin_lock(&its->lock);
+	raw_spin_lock_irqsave(&its->lock, flags);
 	list_add(&dev->entry, &its->its_device_list);
-	raw_spin_unlock(&its->lock);
+	raw_spin_unlock_irqrestore(&its->lock, flags);
 
 	/* Bind the device to the first possible CPU */
 	cpu = cpumask_first(cpu_online_mask);
@@ -1090,9 +1093,11 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 
 static void its_free_device(struct its_device *its_dev)
 {
-	raw_spin_lock(&its_dev->its->lock);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&its_dev->its->lock, flags);
 	list_del(&its_dev->entry);
-	raw_spin_unlock(&its_dev->its->lock);
+	raw_spin_unlock_irqrestore(&its_dev->its->lock, flags);
 	kfree(its_dev->itt);
 	kfree(its_dev);
 }
-- 
2.1.4
