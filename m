From: atull@opensource.altera.com (Alan Tull)
Date: Wed, 28 Sep 2016 13:21:55 -0500
Subject: [PATCH v19 07/12] fpga: add fpga image information struct for zynq
 support
In-Reply-To: <20160928182200.15800-1-atull@opensource.altera.com>
References: <20160928182200.15800-1-atull@opensource.altera.com>
Message-ID: <20160928182200.15800-8-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor changes to the Xilinx Zynq FPGA Manager support driver
due to FPGA Manager framework API changes for the new fpga
image information struct.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
v19: Added in v19 of this patchset
---
 drivers/fpga/zynq-fpga.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index c2fb412..249682e 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -175,7 +175,8 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
+static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
+				    struct fpga_image_info *info,
 				    const char *buf, size_t count)
 {
 	struct zynq_fpga_priv *priv;
@@ -189,7 +190,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
 		return err;
 
 	/* don't globally reset PL if we're doing partial reconfig */
-	if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
 		/* assert AXI interface resets */
 		regmap_write(priv->slcr, SLCR_FPGA_RST_CTRL_OFFSET,
 			     FPGA_RST_ALL_MASK);
@@ -343,7 +344,8 @@ out_free:
 	return err;
 }
 
-static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr, u32 flags)
+static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
+					struct fpga_image_info *info)
 {
 	struct zynq_fpga_priv *priv = mgr->priv;
 	int err;
@@ -364,7 +366,7 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr, u32 flags)
 		return err;
 
 	/* for the partial reconfig case we didn't touch the level shifters */
-	if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
 		/* enable level shifters from PL to PS */
 		regmap_write(priv->slcr, SLCR_LVL_SHFTR_EN_OFFSET,
 			     LVL_SHFTR_ENABLE_PL_TO_PS);
-- 
2.9.3
