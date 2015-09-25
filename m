From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 25 Sep 2015 18:09:33 +0200
Subject: [PATCH v2 2/7] irq: Export per-cpu irq allocation and de-allocation
 functions
In-Reply-To: <1443197378-30717-1-git-send-email-gregory.clement@free-electrons.com>
References: <1443197378-30717-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1443197378-30717-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

Some drivers might use the per-cpu interrupts and still might be built as a
module. Export request_percpu_irq an free_percpu_irq to these user, which
also make it consistent with enable/disable_percpu_irq that were exported.

Reported-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 kernel/irq/manage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dc8a80ecfc4a..89440d2f6c07 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1761,6 +1761,7 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
 	kfree(__free_percpu_irq(irq, dev_id));
 	chip_bus_sync_unlock(desc);
 }
+EXPORT_SYMBOL_GPL(free_percpu_irq);
 
 /**
  *	setup_percpu_irq - setup a per-cpu interrupt
@@ -1832,6 +1833,7 @@ int request_percpu_irq(unsigned int irq, irq_handler_t handler,
 
 	return retval;
 }
+EXPORT_SYMBOL_GPL(request_percpu_irq);
 
 /**
  *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
-- 
2.1.0
