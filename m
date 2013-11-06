From: vkale@apm.com (Vinayak Kale)
Date: Wed,  6 Nov 2013 17:37:36 +0530
Subject: [PATCH 1/2] genirq: error reporting in request_percpu_irq() and
 request_threaded_irq()
In-Reply-To: <1383739658-10036-1-git-send-email-vkale@apm.com>
References: <1383739658-10036-1-git-send-email-vkale@apm.com>
Message-ID: <1383739658-10036-2-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return a separate error code when invalid interrupt type is passed to
request_percpu_irq() and request_threaded_irq().

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vinayak Kale <vkale@apm.com>
---
 kernel/irq/manage.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 514bcfd..08fffaf 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1414,10 +1414,12 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	if (!desc)
 		return -EINVAL;
 
-	if (!irq_settings_can_request(desc) ||
-	    WARN_ON(irq_settings_is_per_cpu_devid(desc)))
+	if (!irq_settings_can_request(desc))
 		return -EINVAL;
 
+	if (irq_settings_is_per_cpu_devid(desc))
+		return -EPERM;
+
 	if (!handler) {
 		if (!thread_fn)
 			return -EINVAL;
@@ -1671,10 +1673,12 @@ int request_percpu_irq(unsigned int irq, irq_handler_t handler,
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
