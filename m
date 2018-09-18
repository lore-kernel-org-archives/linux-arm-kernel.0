From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 18 Sep 2018 08:33:17 -0500
Subject: [PATCH] mtd: rawnand: atmel: Fix potential NULL pointer dereference
Message-ID: <20180918133317.GA17358@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a potential execution path in which function
of_find_compatible_node() returns NULL. In such a case,
we end up having a NULL pointer dereference when accessing
pointer *nfc_np* in function of_clk_get().

So, we better don't take any chances and fix this by null
checking pointer *nfc_np* before calling of_clk_get().

Addresses-Coverity-ID: 1473052 ("Dereference null return value")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index a38633a..ffa0c6b6 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2035,6 +2035,11 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 	nfc_np = of_find_compatible_node(dev->of_node, NULL,
 					 "atmel,sama5d3-nfc");
 
+	if (!nfc_np) {
+		dev_err(dev, "Could not find device node for sama5d3-nfc\n");
+		return -ENODEV;
+	}
+
 	nc->clk = of_clk_get(nfc_np, 0);
 	if (IS_ERR(nc->clk)) {
 		ret = PTR_ERR(nc->clk);
-- 
2.7.4
