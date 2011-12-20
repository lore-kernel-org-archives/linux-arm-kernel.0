From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Dec 2011 20:00:37 +0800
Subject: [PATCH 06/12] mtd: gpmi-lib: convert to clk_prepare/clk_unprepare
In-Reply-To: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1324382443-4439-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch converts gpmi nand driver to clk_prepare/clk_unprepare by
using helper functions clk_prepare_enable/clk_disable_unprepare.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Huang Shijie <b32955@freescale.com>
Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index de4db76..2a56fc6 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -126,7 +126,7 @@ int gpmi_init(struct gpmi_nand_data *this)
 	struct resources *r = &this->resources;
 	int ret;
 
-	ret = clk_enable(r->clock);
+	ret = clk_prepare_enable(r->clock);
 	if (ret)
 		goto err_out;
 	ret = gpmi_reset_block(r->gpmi_regs, false);
@@ -146,7 +146,7 @@ int gpmi_init(struct gpmi_nand_data *this)
 	/* Select BCH ECC. */
 	writel(BM_GPMI_CTRL1_BCH_MODE, r->gpmi_regs + HW_GPMI_CTRL1_SET);
 
-	clk_disable(r->clock);
+	clk_disable_unprepare(r->clock);
 	return 0;
 err_out:
 	return ret;
@@ -202,7 +202,7 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	ecc_strength  = bch_geo->ecc_strength >> 1;
 	page_size     = bch_geo->page_size;
 
-	ret = clk_enable(r->clock);
+	ret = clk_prepare_enable(r->clock);
 	if (ret)
 		goto err_out;
 
@@ -229,7 +229,7 @@ int bch_set_geometry(struct gpmi_nand_data *this)
 	writel(BM_BCH_CTRL_COMPLETE_IRQ_EN,
 				r->bch_regs + HW_BCH_CTRL_SET);
 
-	clk_disable(r->clock);
+	clk_disable_unprepare(r->clock);
 	return 0;
 err_out:
 	return ret;
@@ -704,7 +704,7 @@ void gpmi_begin(struct gpmi_nand_data *this)
 	int ret;
 
 	/* Enable the clock. */
-	ret = clk_enable(r->clock);
+	ret = clk_prepare_enable(r->clock);
 	if (ret) {
 		pr_err("We failed in enable the clk\n");
 		goto err_out;
@@ -773,7 +773,7 @@ err_out:
 void gpmi_end(struct gpmi_nand_data *this)
 {
 	struct resources *r = &this->resources;
-	clk_disable(r->clock);
+	clk_disable_unprepare(r->clock);
 }
 
 /* Clears a BCH interrupt. */
-- 
1.7.4.1
