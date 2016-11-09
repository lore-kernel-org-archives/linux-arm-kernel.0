From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed,  9 Nov 2016 15:58:17 -0700
Subject: [PATCH fpga 3/9] fpga zynq: Fix incorrect ISR state on bootup
In-Reply-To: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <1478732303-13718-4-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is best practice to clear and mask all interrupts before
associating the IRQ, and this should be done after the clock
is enabled.

This corrects a bad result from zynq_fpga_ops_state on bootup
where left over latched values in INT_STS_OFFSET caused it to
report an unconfigured FPGA as configured.

After this change the boot up operating state for an unconfigured
FPGA reports 'unknown'.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/fpga/zynq-fpga.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 86f4377e2b52..40cf0feaca7c 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -460,13 +460,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 		return priv->irq;
 	}
 
-	err = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0,
-			       dev_name(dev), priv);
-	if (err) {
-		dev_err(dev, "unable to request IRQ\n");
-		return err;
-	}
-
 	priv->clk = devm_clk_get(dev, "ref_clk");
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "input clock not found\n");
@@ -482,6 +475,16 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	/* unlock the device */
 	zynq_fpga_write(priv, UNLOCK_OFFSET, UNLOCK_MASK);
 
+	zynq_fpga_write(priv, INT_MASK_OFFSET, 0xFFFFFFFF);
+	zynq_fpga_write(priv, INT_STS_OFFSET, IXR_ALL_MASK);
+	err = devm_request_irq(dev, priv->irq, zynq_fpga_isr, 0, dev_name(dev),
+			       priv);
+	if (err) {
+		dev_err(dev, "unable to request IRQ\n");
+		clk_unprepare(priv->clk);
+		return err;
+	}
+
 	clk_disable(priv->clk);
 
 	err = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
-- 
2.1.4
