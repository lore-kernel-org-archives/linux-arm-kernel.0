From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Oct 2015 00:42:14 +0800
Subject: [PATCH v2 2/2] irqchip: sunxi-nmi: switch to of_io_request_and_map()
 from of_iomap()
In-Reply-To: <1444063334-19832-1-git-send-email-wens@csie.org>
References: <1444063334-19832-1-git-send-email-wens@csie.org>
Message-ID: <1444063334-19832-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new of_io_request_and_map() call, so the IO resource is
properly held, and also shows up in /proc/iomem.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/irqchip/irq-sunxi-nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index c4f719664c63..4ef178078e5b 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -153,7 +153,7 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	}
 
 	gc = irq_get_domain_generic_chip(domain, 0);
-	gc->reg_base = of_iomap(node, 0);
+	gc->reg_base = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (!gc->reg_base) {
 		pr_err("unable to map resource\n");
 		ret = -ENOMEM;
-- 
2.5.3
