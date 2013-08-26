From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Mon, 26 Aug 2013 17:36:24 +0200
Subject: [PATCH 2/3] kernel,
 irq: Use interrupt prioritization infrastructure during interrupt
 setup.
In-Reply-To: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1377531385-19369-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <1377531385-19369-3-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once interrupt is shared all actions co-related to given interrupt need
to have IRQF_HIGH_PRIORITY flag which means that actions have the same
priority.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 include/linux/interrupt.h |    1 +
 kernel/irq/manage.c       |   16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5fa5afe..a566e54 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -71,6 +71,7 @@
 #define IRQF_FORCE_RESUME	0x00008000
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
+#define IRQF_HIGH_PRIORITY	0x00040000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 514bcfd..7c80295 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
+#include <linux/irqpriority.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
@@ -1006,11 +1007,12 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 * the same type (level, edge, polarity). So both flag
 		 * fields must have IRQF_SHARED set and the bits which
 		 * set the trigger type must match. Also all must
-		 * agree on ONESHOT.
+		 * agree on ONESHOT and IRQF_HIGH_PRIORITY.
 		 */
 		if (!((old->flags & new->flags) & IRQF_SHARED) ||
 		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
-		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
+		    ((old->flags ^ new->flags) & IRQF_ONESHOT) ||
+		    ((old->flags ^ new->flags) & IRQF_HIGH_PRIORITY))
 			goto mismatch;
 
 		/* All handlers must agree on per-cpuness */
@@ -1115,6 +1117,16 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		if (new->flags & IRQF_ONESHOT)
 			desc->istate |= IRQS_ONESHOT;
 
+		if (new->flags & IRQF_HIGH_PRIORITY) {
+			ret = irq_set_priority(desc, IRQP_HIGH);
+			if (ret)
+				goto out_mask;
+		} else {
+			ret = irq_set_priority(desc, IRQP_DEFAULT);
+			if (ret && ret != ENOSYS)
+				goto out_mask;
+		}
+
 		if (irq_settings_can_autoenable(desc))
 			irq_startup(desc, true);
 		else
-- 
1.7.9.5
