From: psodagud@codeaurora.org (Prasad Sodagudi)
Date: Mon, 20 Mar 2017 09:36:17 -0700
Subject: [PATCH] genirq: Notify clients whenever there is change in affinity
In-Reply-To: <1490027777-29130-1-git-send-email-psodagud@codeaurora.org>
References: <alpine.DEB.2.20.1703171416060.3538@nanos>
 <1490027777-29130-1-git-send-email-psodagud@codeaurora.org>
Message-ID: <1490027777-29130-2-git-send-email-psodagud@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the cpu hotplug, irq are getting migrated from
hotplugging core but not getting notitfied to client
drivers. So add parameter to irq_do_set_affinity(),
to check and notify client drivers during the cpu hotplug.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 kernel/irq/cpuhotplug.c | 2 +-
 kernel/irq/internals.h  | 2 +-
 kernel/irq/manage.c     | 9 ++++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 011f8c4..e293d9b 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -38,7 +38,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (!c->irq_set_affinity) {
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
 	} else {
-		int r = irq_do_set_affinity(d, affinity, false);
+		int r = irq_do_set_affinity(d, affinity, false, true);
 		if (r)
 			pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n",
 					    d->irq, r);
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bc226e7..6abde48 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -114,7 +114,7 @@ static inline void unregister_handler_proc(unsigned int irq,
 extern void irq_set_thread_affinity(struct irq_desc *desc);
 
 extern int irq_do_set_affinity(struct irq_data *data,
-			       const struct cpumask *dest, bool force);
+		const struct cpumask *dest, bool force, bool notify);
 
 /* Inline functions for support of irq chips on slow busses */
 static inline void chip_bus_lock(struct irq_desc *desc)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a4afe5c..fea8c8e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -197,7 +197,7 @@ static inline bool irq_move_pending(struct irq_data *data)
 #endif
 
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
-			bool force)
+			bool force, bool notify)
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
@@ -209,6 +209,9 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	case IRQ_SET_MASK_OK_DONE:
 		cpumask_copy(desc->irq_common_data.affinity, mask);
 	case IRQ_SET_MASK_OK_NOCOPY:
+		if (notify && desc->affinity_notify)
+			schedule_work(&desc->affinity_notify->work);
+
 		irq_set_thread_affinity(desc);
 		ret = 0;
 	}
@@ -227,7 +230,7 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 		return -EINVAL;
 
 	if (irq_can_move_pcntxt(data)) {
-		ret = irq_do_set_affinity(data, mask, force);
+		ret = irq_do_set_affinity(data, mask, force, false);
 	} else {
 		irqd_set_move_pending(data);
 		irq_copy_pending(desc, mask);
@@ -375,7 +378,7 @@ static int setup_affinity(struct irq_desc *desc, struct cpumask *mask)
 		if (cpumask_intersects(mask, nodemask))
 			cpumask_and(mask, mask, nodemask);
 	}
-	irq_do_set_affinity(&desc->irq_data, mask, false);
+	irq_do_set_affinity(&desc->irq_data, mask, false, true);
 	return 0;
 }
 #else
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
