From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 20 Jun 2016 12:48:38 +0800
Subject: [PATCH v6 2/2] mtd: nand: sunxi: add reset line support
In-Reply-To: <20160620044838.56904-1-icenowy@aosc.xyz>
References: <20160620044838.56904-1-icenowy@aosc.xyz>
Message-ID: <20160620044838.56904-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND controller on some sun8i chips needs its reset line to be
deasserted before they can enter working state.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 ?Changes in v2:
 ???- Corrected the error checking code of reset line.

 ?Changes in v3:
 ???- Corrected a more serious error brought in the "fix" of v2.

 ?Changes in v4:
 ???- Removed unneeded code block after "else".

 ?Changes in v5:
 ???- Added reassertion code in case of initialization error and device
 ?????remove.

  Changes in v6:
    - Fixed a resource leak by not using goto to exit in case of error.

 drivers/mtd/nand/sunxi_nand.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index a83a690..08d5e88 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -39,6 +39,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/reset.h>
 
 #define NFC_REG_CTL		0x0000
 #define NFC_REG_ST		0x0004
@@ -269,6 +270,7 @@ struct sunxi_nfc {
 	void __iomem *regs;
 	struct clk *ahb_clk;
 	struct clk *mod_clk;
+	struct reset_control *reset;
 	unsigned long assigned_cs;
 	unsigned long clk_rate;
 	struct list_head chips;
@@ -1871,26 +1873,42 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_ahb_clk_unprepare;
 
+	nfc->reset = devm_reset_control_get_optional(dev, "ahb");
+
+	if (!IS_ERR(nfc->reset)) {
+		ret = reset_control_deassert(nfc->reset);
+		if (ret) {
+			dev_err(dev, "reset err %d\n", ret);
+			goto out_mod_clk_unprepare;
+		}
+	} else if (PTR_ERR(nfc->reset) != -ENOENT) {
+		ret = PTR_ERR(nfc->reset);
+		goto out_mod_clk_unprepare;
+	}
+
 	ret = sunxi_nfc_rst(nfc);
 	if (ret)
-		goto out_mod_clk_unprepare;
+		goto out_ahb_reset_reassert;
 
 	writel(0, nfc->regs + NFC_REG_INT);
 	ret = devm_request_irq(dev, irq, sunxi_nfc_interrupt,
 			       0, "sunxi-nand", nfc);
 	if (ret)
-		goto out_mod_clk_unprepare;
+		goto out_ahb_reset_reassert;
 
 	platform_set_drvdata(pdev, nfc);
 
 	ret = sunxi_nand_chips_init(dev, nfc);
 	if (ret) {
 		dev_err(dev, "failed to init nand chips\n");
-		goto out_mod_clk_unprepare;
+		goto out_ahb_reset_reassert;
 	}
 
 	return 0;
 
+out_ahb_reset_reassert:
+	if (!IS_ERR(nfc->reset))
+		reset_control_assert(nfc->reset);
 out_mod_clk_unprepare:
 	clk_disable_unprepare(nfc->mod_clk);
 out_ahb_clk_unprepare:
@@ -1904,6 +1922,10 @@ static int sunxi_nfc_remove(struct platform_device *pdev)
 	struct sunxi_nfc *nfc = platform_get_drvdata(pdev);
 
 	sunxi_nand_chips_cleanup(nfc);
+
+	if (!IS_ERR(nfc->reset))
+		reset_control_assert(nfc->reset);
+
 	clk_disable_unprepare(nfc->mod_clk);
 	clk_disable_unprepare(nfc->ahb_clk);
 
-- 
2.9.0
