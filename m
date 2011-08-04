From: swarren@nvidia.com (Stephen Warren)
Date: Thu,  4 Aug 2011 17:00:18 -0600
Subject: [PATCH 1/3] irq: If an IRQ is a GPIO, request and configure it
In-Reply-To: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
Message-ID: <1312498820-2275-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many IRQs are associated with GPIO pins. When the pin is used as an IRQ,
it can't be used as anything else; it should be requested. Enhance the
core interrupt code to call gpio_request() and gpio_direction_input() for
any IRQ that is also a GPIO. This prevents duplication of these calls in
each driver that uses an IRQ.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 kernel/irq/manage.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0a7840a..6e2db72 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -7,6 +7,7 @@
  * This file contains driver APIs to the irq subsystem.
  */
 
+#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
@@ -875,7 +876,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	struct irqaction *old, **old_ptr;
 	const char *old_name = NULL;
 	unsigned long flags, thread_mask = 0;
-	int ret, nested, shared = 0;
+	int ret, nested, shared = 0, gpio = -1;
 	cpumask_var_t mask;
 
 	if (!desc)
@@ -978,6 +979,16 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			old = *old_ptr;
 		} while (old);
 		shared = 1;
+	} else {
+		gpio = irq_to_gpio(irq);
+		if (gpio_is_valid(gpio)) {
+			ret = gpio_request(gpio, new->name);
+			if (ret < 0)
+				goto out_mask;
+			ret = gpio_direction_input(gpio);
+			if (ret < 0)
+				goto out_mask;
+		}
 	}
 
 	/*
@@ -1083,6 +1094,8 @@ mismatch:
 	ret = -EBUSY;
 
 out_mask:
+	if (gpio_is_valid(gpio))
+		gpio_free(gpio);
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	free_cpumask_var(mask);
 
@@ -1127,6 +1140,7 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 	struct irq_desc *desc = irq_to_desc(irq);
 	struct irqaction *action, **action_ptr;
 	unsigned long flags;
+	int gpio;
 
 	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
 
@@ -1165,8 +1179,13 @@ static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
 #endif
 
 	/* If this was the last handler, shut down the IRQ line: */
-	if (!desc->action)
+	if (!desc->action) {
 		irq_shutdown(desc);
+		/* If the IRQ line is a GPIO, it's no longer in use */
+		gpio = irq_to_gpio(irq);
+		if (gpio_is_valid(gpio))
+			gpio_free(gpio);
+	}
 
 #ifdef CONFIG_SMP
 	/* make sure affinity_hint is cleaned up */
-- 
1.7.0.4
