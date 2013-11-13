From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 13 Nov 2013 10:40:30 +0300
Subject: [patch] mfd: ab8500-debugfs: move dereference after check for NULL
Message-ID: <20131113074030.GA25541@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We dereference "desc" before check if it is NULL.  I've shifted it
around so we check first before dereferencing.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I am not able to compile this.

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index e33e385..d1a22aa 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1600,7 +1600,6 @@ static int ab8500_interrupts_print(struct seq_file *s, void *p)
 
 	for (line = 0; line < num_interrupt_lines; line++) {
 		struct irq_desc *desc = irq_to_desc(line + irq_first);
-		struct irqaction *action = desc->action;
 
 		seq_printf(s, "%3i:  %6i %4i", line,
 			   num_interrupts[line],
@@ -1608,7 +1607,9 @@ static int ab8500_interrupts_print(struct seq_file *s, void *p)
 
 		if (desc && desc->name)
 			seq_printf(s, "-%-8s", desc->name);
-		if (action) {
+		if (desc && desc->action) {
+			struct irqaction *action = desc->action;
+
 			seq_printf(s, "  %s", action->name);
 			while ((action = action->next) != NULL)
 				seq_printf(s, ", %s", action->name);
