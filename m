From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 19 Jun 2016 23:01:28 +0800
Subject: [PATCH v3 2/2] mtd: nand: sunxi: add reset line support
Message-ID: <20160619150128.44443-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND controller on some sun8i chips needs its reset line to be deasserted
before they can enter working state. This commit added the reset line process
to the driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v1:
  - Corrected the error checking code of reset line.

Changes in v2:
  - Corrected a more serious error brought in the "fix" of v1.

 drivers/mtd/nand/sunxi_nand.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index a83a690..8fb5899 100644
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
@@ -1871,6 +1873,20 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
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
+	}
+	else {
+		if (PTR_ERR(nfc->reset) != -ENOENT)
+			return PTR_ERR(nfc->reset);
+	}
+
 	ret = sunxi_nfc_rst(nfc);
 	if (ret)
 		goto out_mod_clk_unprepare;
-- 
2.9.0
