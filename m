From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed,  9 Mar 2016 03:21:29 +0200
Subject: [PATCH] irqchip/sunxi-nmi: fix error check of of_io_request_and_map()
Message-ID: <1457486489-10189-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_io_request_and_map() returns a valid pointer in iomem region or
ERR_PTR(), check for NULL always fails and may cause a NULL pointer
dereference on error path.

Fixes: 0e841b04c829 ("irqchip/sunxi-nmi: Switch to of_io_request_and_map() from of_iomap()")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/irqchip/irq-sunxi-nmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 0820f67..668730c 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -160,9 +160,9 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 
 	gc = irq_get_domain_generic_chip(domain, 0);
 	gc->reg_base = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (!gc->reg_base) {
+	if (IS_ERR(gc->reg_base)) {
 		pr_err("unable to map resource\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(gc->reg_base);
 		goto fail_irqd_remove;
 	}
 
-- 
2.1.4
