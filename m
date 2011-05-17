From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 17 May 2011 16:11:17 +0200 (CEST)
Subject: [PATCH] arm: Use arch_spin_lock for unwind to avoid lockdep deadlock
Message-ID: <alpine.LFD.2.02.1105171605080.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When lockdep traces a lock taken in a module the arm unwinder takes
unwind_lock which causes a recursive lockdep call deadlocking itself
on the unwind_lock.

Make unwind_lock an arch_spin_lock to avoid the lockdep call and use
the raw_local_irq_save/restore() variants to avoid irq tracing as
well.

Reported-and-tested-by: Torben Hohn <torbenh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable at kernel.org
---
 arch/arm/kernel/unwind.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

Index: linux-2.6/arch/arm/kernel/unwind.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/unwind.c
+++ linux-2.6/arch/arm/kernel/unwind.c
@@ -86,7 +86,7 @@ enum regs {
 extern struct unwind_idx __start_unwind_idx[];
 extern struct unwind_idx __stop_unwind_idx[];
 
-static DEFINE_SPINLOCK(unwind_lock);
+static arch_spinlock_t unwind_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(unwind_tables);
 
 /* Convert a prel31 symbol to an absolute address */
@@ -140,7 +140,8 @@ static struct unwind_idx *unwind_find_id
 		/* module unwind tables */
 		struct unwind_table *table;
 
-		spin_lock_irqsave(&unwind_lock, flags);
+		raw_local_irq_save(flags);
+		arch_spin_lock(&unwind_lock);
 		list_for_each_entry(table, &unwind_tables, list) {
 			if (addr >= table->begin_addr &&
 			    addr < table->end_addr) {
@@ -151,7 +152,8 @@ static struct unwind_idx *unwind_find_id
 				break;
 			}
 		}
-		spin_unlock_irqrestore(&unwind_lock, flags);
+		arch_spin_unlock(&unwind_lock);
+		raw_local_irq_restore(flags);
 	}
 
 	pr_debug("%s: idx = %p\n", __func__, idx);
@@ -417,9 +419,11 @@ struct unwind_table *unwind_table_add(un
 	for (idx = tab->start; idx < tab->stop; idx++)
 		idx->addr = prel31_to_addr(&idx->addr);
 
-	spin_lock_irqsave(&unwind_lock, flags);
+	raw_local_irq_save(flags);
+	arch_spin_lock(&unwind_lock);
 	list_add_tail(&tab->list, &unwind_tables);
-	spin_unlock_irqrestore(&unwind_lock, flags);
+	arch_spin_unlock(&unwind_lock);
+	raw_local_irq_restore(flags);
 
 	return tab;
 }
@@ -431,9 +435,11 @@ void unwind_table_del(struct unwind_tabl
 	if (!tab)
 		return;
 
-	spin_lock_irqsave(&unwind_lock, flags);
+	raw_local_irq_save(flags);
+	arch_spin_lock(&unwind_lock);
 	list_del(&tab->list);
-	spin_unlock_irqrestore(&unwind_lock, flags);
+	arch_spin_unlock(&unwind_lock);
+	raw_local_irq_restore(flags);
 
 	kfree(tab);
 }
