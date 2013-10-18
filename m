From: vkale@apm.com (Vinayak Kale)
Date: Fri, 18 Oct 2013 15:36:29 +0530
Subject: [PATCH] genirq: error reporting for non-percpu interrupt in
 request_percpu_irq()
Message-ID: <1382090789-18177-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return a separate error code when a non-percpu interrupt is passed to
request_percpu_irq().

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vinayak Kale <vkale@apm.com>
---
 kernel/irq/manage.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 514bcfd..c2713ae 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1671,10 +1671,12 @@ int request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		return -EINVAL;
 
 	desc = irq_to_desc(irq);
-	if (!desc || !irq_settings_can_request(desc) ||
-	    !irq_settings_is_per_cpu_devid(desc))
+	if (!desc || !irq_settings_can_request(desc))
 		return -EINVAL;
 
+	if (!irq_settings_is_per_cpu_devid(desc))
+		return -EPERM;
+
 	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
 	if (!action)
 		return -ENOMEM;
-- 
1.7.9.5
