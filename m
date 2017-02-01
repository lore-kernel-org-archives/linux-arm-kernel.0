From: rrichter@cavium.com (Robert Richter)
Date: Wed, 1 Feb 2017 18:38:25 +0100
Subject: [PATCH 1/9] irqchip/gic-v3-its: Fix command buffer allocation
In-Reply-To: <20170201173833.12630-1-rrichter@cavium.com>
References: <20170201173833.12630-1-rrichter@cavium.com>
Message-ID: <20170201173833.12630-2-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The its command buffer must be page aligned, but kzalloc() is not
guaranteed to be (though it is mostly when allocating 64k). Use
__get_free_pages() as this is used for other buffers as well.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 69b040f47d56..dce70f21a15d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1693,7 +1693,8 @@ static int __init its_probe_one(struct resource *res,
 	its->ite_size = ((gic_read_typer(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
 	its->numa_node = numa_node;
 
-	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
+	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						get_order(ITS_CMD_QUEUE_SZ));
 	if (!its->cmd_base) {
 		err = -ENOMEM;
 		goto out_free_its;
-- 
2.11.0
