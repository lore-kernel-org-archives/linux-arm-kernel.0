From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed,  9 Mar 2016 03:21:40 +0200
Subject: [PATCH] irqchip/mxs: fix error check of of_io_request_and_map()
Message-ID: <1457486500-10237-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_io_request_and_map() returns a valid pointer in iomem region or
ERR_PTR(), check for NULL always fails and may cause a NULL pointer
dereference on error path.

Fixes: 25e34b44313b ("irqchip/mxs: Prepare driver for hardware with different offsets")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/irqchip/irq-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index c22e2d4..5bec700 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -183,7 +183,7 @@ static void __iomem * __init icoll_init_iobase(struct device_node *np)
 	void __iomem *icoll_base;
 
 	icoll_base = of_io_request_and_map(np, 0, np->name);
-	if (!icoll_base)
+	if (IS_ERR(icoll_base))
 		panic("%s: unable to map resource", np->full_name);
 	return icoll_base;
 }
-- 
2.1.4
