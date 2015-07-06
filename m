From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  6 Jul 2015 15:24:40 +0200
Subject: [RFC v2 6/9] irq: bypass: add active field on producer side
In-Reply-To: <1436189083-32527-1-git-send-email-eric.auger@linaro.org>
References: <1436189083-32527-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1436189083-32527-7-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An active boolean is introduced on producer side: it reflects whether
the source is active (at interrupt controller level or at VFIO level
- automasked -).

This is a temporary hack for ARM IRQ forwarding with vfio platform.
I think the connect and disconnect should become callbacks too.
This would make possible to handle error in the process. Typically
active could be returned by producer->stop and analyzed before going
further. in that case the list_add only if connect returns 0.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 include/linux/irqbypass.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
index 8f62235..c89c3a8 100644
--- a/include/linux/irqbypass.h
+++ b/include/linux/irqbypass.h
@@ -9,6 +9,8 @@ struct irq_bypass_producer {
 	struct list_head node;
 	void *token;
 	int irq; /* linux irq */
+	/* is irq active at irqchip or VFIO masked? */
+	bool active;
 	void (*stop)(struct irq_bypass_producer *);
 	void (*resume)(struct irq_bypass_producer *);
 	void (*add_consumer)(struct irq_bypass_producer *,
-- 
1.9.1
