From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Nov 2011 14:48:32 +0000
Subject: [PATCH] genirq: don't allow per cpu interrupts to be suspended
Message-ID: <1320763712-764-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power management functions related to interrupts do not know
(yet) about per-cpu interrupts and end up calling the wrong
low-level methods to enable/disable interrupts.

This leads to all kind of interesting issues (action taken on one
CPU only, updating a refcount which is not used otherwise...).

The workaround for the time being is simply to flag these interrupts
with IRQF_NO_SUSPEND. At least on ARM, these interrupts are actually
dealt with at the architecture level.

Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/irq/manage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 67ce837..0e2b179 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1596,7 +1596,7 @@ int request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		return -ENOMEM;
 
 	action->handler = handler;
-	action->flags = IRQF_PERCPU;
+	action->flags = IRQF_PERCPU | IRQF_NO_SUSPEND;
 	action->name = devname;
 	action->percpu_dev_id = dev_id;
 
-- 
1.7.0.4
