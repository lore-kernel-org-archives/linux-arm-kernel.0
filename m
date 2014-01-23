From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 23 Jan 2014 23:38:05 +0100
Subject: [PATCH 2/3] irqchip: orion: use handle_edge_irq on bridge irqs
In-Reply-To: <1390516686-2224-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390516686-2224-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1390516686-2224-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bridge irqs are edge-triggered, i.e. they get asserted on low-to-high
transitions and not on the level of the downstream interrupt line.
This replaces handle_level_irq by the more appropriate handle_edge_irq.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/irqchip/irq-orion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index 4137c3d15284..1f636f719065 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -143,7 +143,7 @@ static int __init orion_bridge_irq_init(struct device_node *np,
 	}
 
 	ret = irq_alloc_domain_generic_chips(domain, nrirqs, 1, np->name,
-			     handle_level_irq, clr, 0, IRQ_GC_INIT_MASK_CACHE);
+			     handle_edge_irq, clr, 0, IRQ_GC_INIT_MASK_CACHE);
 	if (ret) {
 		pr_err("%s: unable to alloc irq domain gc\n", np->name);
 		return ret;
-- 
1.8.5.2
