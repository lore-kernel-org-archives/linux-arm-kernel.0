From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  8 Jul 2015 16:28:15 +0200
Subject: [PATCHv4 2/6] dmaengine: mv_xor: add suspend/resume support
In-Reply-To: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1436365699-6862-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds suspend/resume support to the mv_xor driver. The
config and interrupt mask registers must be saved and restored, and
upon resume, the MBus windows configuration must also be done again.

Tested on Armada 388 GP, with a RAID 5 array, accessed before and
after a suspend to RAM cycle.

Based on work from Ofer Heifetz and Lior Amsalem.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/mv_xor.h |  1 +
 2 files changed, 48 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index f1325f6..0a3ddc2 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1121,6 +1121,51 @@ mv_xor_conf_mbus_windows(struct mv_xor_device *xordev,
 	writel(0, base + WINDOW_OVERRIDE_CTRL(1));
 }
 
+static int mv_xor_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct mv_xor_device *xordev = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
+		struct mv_xor_chan *mv_chan = xordev->channels[i];
+
+		if (!mv_chan)
+			continue;
+
+		mv_chan->saved_config_reg =
+			readl_relaxed(XOR_CONFIG(mv_chan));
+		mv_chan->saved_int_mask_reg =
+			readl_relaxed(XOR_INTR_MASK(mv_chan));
+	}
+
+	return 0;
+}
+
+static int mv_xor_resume(struct platform_device *dev)
+{
+	struct mv_xor_device *xordev = platform_get_drvdata(dev);
+	const struct mbus_dram_target_info *dram;
+	int i;
+
+	for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
+		struct mv_xor_chan *mv_chan = xordev->channels[i];
+
+		if (!mv_chan)
+			continue;
+
+		writel_relaxed(mv_chan->saved_config_reg,
+			       XOR_CONFIG(mv_chan));
+		writel_relaxed(mv_chan->saved_int_mask_reg,
+			       XOR_INTR_MASK(mv_chan));
+	}
+
+	dram = mv_mbus_dram_info();
+	if (dram)
+		mv_xor_conf_mbus_windows(xordev, dram);
+
+	return 0;
+}
+
 static const struct of_device_id mv_xor_dt_ids[] = {
 	{ .compatible = "marvell,orion-xor", .data = (void *)XOR_MODE_IN_REG },
 	{ .compatible = "marvell,armada-380-xor", .data = (void *)XOR_MODE_IN_DESC },
@@ -1284,6 +1329,8 @@ static int mv_xor_remove(struct platform_device *pdev)
 static struct platform_driver mv_xor_driver = {
 	.probe		= mv_xor_probe,
 	.remove		= mv_xor_remove,
+	.suspend        = mv_xor_suspend,
+	.resume         = mv_xor_resume,
 	.driver		= {
 		.name	        = MV_XOR_NAME,
 		.of_match_table = of_match_ptr(mv_xor_dt_ids),
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index b7455b4..41a2e8d 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -126,6 +126,7 @@ struct mv_xor_chan {
 	char			dummy_src[MV_XOR_MIN_BYTE_COUNT];
 	char			dummy_dst[MV_XOR_MIN_BYTE_COUNT];
 	dma_addr_t		dummy_src_addr, dummy_dst_addr;
+	u32                     saved_config_reg, saved_int_mask_reg;
 };
 
 /**
-- 
2.4.5
