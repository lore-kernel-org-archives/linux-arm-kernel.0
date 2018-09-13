From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Thu, 13 Sep 2018 14:53:47 +0200
Subject: Patch "irqchip/gicv3-its: Fix memory leak in its_free_tables()" has
 been added to the 4.4-stable tree
Message-ID: <1536843227189203@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    irqchip/gicv3-its: Fix memory leak in its_free_tables()

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     irqchip-gicv3-its-fix-memory-leak-in-its_free_tables.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 1a485f4d2e28efd77075b2952926683d6c245633 Mon Sep 17 00:00:00 2001
From: Shanker Donthineni <shankerd@codeaurora.org>
Date: Mon, 1 Feb 2016 20:19:44 -0600
Subject: irqchip/gicv3-its: Fix memory leak in its_free_tables()

From: Shanker Donthineni <shankerd@codeaurora.org>

commit 1a485f4d2e28efd77075b2952926683d6c245633 upstream.

The current ITS driver has a memory leak in its_free_tables(). It
happens on tear down path of the driver when its_probe() call fails.
its_free_tables() should free the exact number of pages that have
been allocated, not just a single page as current code does.

This patch records the memory size for each ITS_BASERn at the time of
page allocation and uses the same size information when freeing pages
to fix the issue.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Vikram Sethi <vikrams@codeaurora.org>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/1454379584-21772-1-git-send-email-shankerd at codeaurora.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -67,7 +67,10 @@ struct its_node {
 	unsigned long		phys_base;
 	struct its_cmd_block	*cmd_base;
 	struct its_cmd_block	*cmd_write;
-	void			*tables[GITS_BASER_NR_REGS];
+	struct {
+		void		*base;
+		u32		order;
+	} tables[GITS_BASER_NR_REGS];
 	struct its_collection	*collections;
 	struct list_head	its_device_list;
 	u64			flags;
@@ -816,9 +819,10 @@ static void its_free_tables(struct its_n
 	int i;
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
-		if (its->tables[i]) {
-			free_page((unsigned long)its->tables[i]);
-			its->tables[i] = NULL;
+		if (its->tables[i].base) {
+			free_pages((unsigned long)its->tables[i].base,
+				   its->tables[i].order);
+			its->tables[i].base = NULL;
 		}
 	}
 }
@@ -899,7 +903,8 @@ retry_alloc_baser:
 			goto out_free;
 		}
 
-		its->tables[i] = base;
+		its->tables[i].base = base;
+		its->tables[i].order = order;
 
 retry_baser:
 		val = (virt_to_phys(base) 				 |
@@ -949,7 +954,7 @@ retry_baser:
 			 * something is horribly wrong...
 			 */
 			free_pages((unsigned long)base, order);
-			its->tables[i] = NULL;
+			its->tables[i].base = NULL;
 
 			switch (psz) {
 			case SZ_16K:


Patches currently in stable-queue which might be from shankerd at codeaurora.org are

queue-4.4/irqchip-gicv3-its-avoid-cache-flush-beyond-its_basern-memory-size.patch
queue-4.4/irqchip-gicv3-its-fix-memory-leak-in-its_free_tables.patch
