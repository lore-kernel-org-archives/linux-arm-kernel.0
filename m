From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 24 Jun 2016 13:00:05 +0800
Subject: [PATCH v7 2/2] mtd: nand: sunxi: add reset line support
In-Reply-To: <20160624050005.31186-1-icenowy@aosc.xyz>
References: <20160624050005.31186-1-icenowy@aosc.xyz>
Message-ID: <20160624050005.31186-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND controller on some sun8i chips needs its reset line to be
deasserted before they can enter working state.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2:
  - Corrected the error checking code of reset line.

Changes in v3:
  - Corrected a more serious error brought in the "fix" of v2.

Changes in v4:
  - Removed unneeded code block after "else".

Changes in v5:
  - Added reassertion code in case of initialization error and device
    remove.

Changes in v6:
  - Fixed a resource leak by not using goto to exit in case of error.

Changes in v7:
  - Rebased for nand/next branch.

 drivers/mtd/nand/sunxi_nand.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index f582fe4..77796da 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -39,6 +39,7 @@
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/reset.h>
 
 #define NFC_REG_CTL		0x0000
 #define NFC_REG_ST		0x0004
@@ -270,6 +271,7 @@ struct sunxi_nfc {
 	void __iomem *regs;
 	struct clk *ahb_clk;
 	struct clk *mod_clk;
+	struct reset_control *reset;
 	unsigned long assigned_cs;
 	unsigned long clk_rate;
 	struct list_head chips;
@@ -2209,15 +2211,28 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
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
 
 	nfc->dmac = dma_request_slave_channel(dev, "rxtx");
 	if (nfc->dmac) {
@@ -2247,6 +2262,9 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 out_release_dmac:
 	if (nfc->dmac)
 		dma_release_channel(nfc->dmac);
+out_ahb_reset_reassert:
+	if (!IS_ERR(nfc->reset))
+		reset_control_assert(nfc->reset);
 out_mod_clk_unprepare:
 	clk_disable_unprepare(nfc->mod_clk);
 out_ahb_clk_unprepare:
@@ -2262,6 +2280,10 @@ static int sunxi_nfc_remove(struct platform_device *pdev)
 	sunxi_nand_chips_cleanup(nfc);
 	if (nfc->dmac)
 		dma_release_channel(nfc->dmac);
+
+	if (!IS_ERR(nfc->reset))
+		reset_control_assert(nfc->reset);
+
 	clk_disable_unprepare(nfc->mod_clk);
 	clk_disable_unprepare(nfc->ahb_clk);
 
-- 
2.9.0
