From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Tue, 21 Feb 2017 12:59:13 -0800
Subject: Schedule affinity_notify work while migrating IRQs during hot plug
Message-ID: <05102c455476941d37904f8c6f387452@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Currently irq_set_affinity() is called to migrate irqs from 
migrate_one_irq()
during cpu hot plug and clients which are interested to know the irq 
affinity change
not getting notified

take_cpu_down () --> __cpu_disable() --> irq_migrate_all_off_this_cpu();

irq_set_affinity() is changing the IRQ affinity at chip level
but it is not notifying the affinity_notify work.

How about below change, so that clients drivers gets notified about irq 
affinity changes?
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -207,6 +207,7 @@ int irq_do_set_affinity(struct irq_data *data, const 
struct cpumask *mask,
         case IRQ_SET_MASK_OK_DONE:
                 cpumask_copy(desc->irq_common_data.affinity, mask);
         case IRQ_SET_MASK_OK_NOCOPY:
+               schedule_work(&desc->affinity_notify->work);
                 irq_set_thread_affinity(desc);
                 ret = 0;

With this change, notifications of IRQ affinity gets executed and 
notified
to client drivers.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
