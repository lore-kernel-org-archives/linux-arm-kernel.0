From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sat, 13 Oct 2018 13:22:46 +0300
Subject: [PATCH] irqchip/irq-mvebu-sei: Fix a NULL vs IS_ERR() bug in probe
Message-ID: <20181013102246.GD16086@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The devm_ioremap_resource() function never returns NULL, it returns
error pointers.

Fixes: 61ce8d8d8a81 ("irqchip/irq-mvebu-sei: Add new driver for Marvell SEI")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/irqchip/irq-mvebu-sei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 566d69a2edbc..add4c9c934c8 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -384,9 +384,9 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 
 	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sei->base = devm_ioremap_resource(sei->dev, sei->res);
-	if (!sei->base) {
+	if (IS_ERR(sei->base)) {
 		dev_err(sei->dev, "Failed to remap SEI resource\n");
-		return -ENODEV;
+		return PTR_ERR(sei->base);
 	}
 
 	/* Retrieve the SEI capabilities with the interrupt ranges */
-- 
2.18.0
