From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Mar 2016 19:35:18 +0200
Subject: [PATCH 3/5] dmaengine: mv_xor: add support for Armada 3700 SoC
In-Reply-To: <1459359320-12638-1-git-send-email-gregory.clement@free-electrons.com>
References: <1459359320-12638-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1459359320-12638-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>

Armada 3700 SoC comprise a single XOR engine compliant with the ones used
in older Marvell SoC's like Armada XP or 38x. The only thing that neededs
modification is the Mbus configuration, which has to be done on two
levels: global and in device. The first one is inherited from the
bootlader.  The latter can be opened in a default way, leaving
arbitration to the bus controller. Hence filled mbus_dram_target_info
structure is not needed.

Patch "dmaengine: mv_xor: optimize performance by using a subset
of the XOR channels" introduced limitation for using XOR engines and
channels vs number of available CPU's. Those contstraints do not however
fit Armada 3700 architecture with two possible CPU's and single,
dual-channel engine. Hence in this commit an adjustment for setting
maximum available channels is added.

This patch enables XOR access to DRAM by opening default window to 4GB
space with specific attribute.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/dma/mv-xor.txt |  3 +-
 drivers/dma/mv_xor.c                             | 56 +++++++++++++++++++++---
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/mv-xor.txt b/Documentation/devicetree/bindings/dma/mv-xor.txt
index 276ef815ef32..900328d28231 100644
--- a/Documentation/devicetree/bindings/dma/mv-xor.txt
+++ b/Documentation/devicetree/bindings/dma/mv-xor.txt
@@ -1,7 +1,8 @@
 * Marvell XOR engines
 
 Required properties:
-- compatible: Should be "marvell,orion-xor" or "marvell,armada-380-xor"
+- compatible: Should be "marvell,orion-xor", "marvell,armada-380-xor"
+    or "marvell,armada-3700-xor".
 - reg: Should contain registers location and length (two sets)
     the first set is the low registers, the second set the high
     registers for the XOR engine.
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 6d012a56b97b..25d1dadcddd1 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -34,6 +34,7 @@
 enum mv_xor_type {
 	XOR_ORION,
 	XOR_ARMADA_38X,
+	XOR_ARMADA_37XX,
 };
 
 enum mv_xor_mode {
@@ -1093,6 +1094,33 @@ mv_xor_conf_mbus_windows(struct mv_xor_device *xordev,
 	writel(0, base + WINDOW_OVERRIDE_CTRL(1));
 }
 
+static void
+mv_xor_conf_mbus_windows_a3700(struct mv_xor_device *xordev)
+{
+	void __iomem *base = xordev->xor_high_base;
+	u32 win_enable = 0;
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		writel(0, base + WINDOW_BASE(i));
+		writel(0, base + WINDOW_SIZE(i));
+		if (i < 4)
+			writel(0, base + WINDOW_REMAP_HIGH(i));
+	}
+	/*
+	 * For Armada3700 open default 4GB Mbus window. The dram
+	 * related configuration are done@AXIS level.
+	 */
+	writel(0xffff0000, base + WINDOW_SIZE(0));
+	win_enable |= 1;
+	win_enable |= 3 << 16;
+
+	writel(win_enable, base + WINDOW_BAR_ENABLE(0));
+	writel(win_enable, base + WINDOW_BAR_ENABLE(1));
+	writel(0, base + WINDOW_OVERRIDE_CTRL(0));
+	writel(0, base + WINDOW_OVERRIDE_CTRL(1));
+}
+
 /*
  * Since this XOR driver is basically used only for RAID5, we don't
  * need to care about synchronizing ->suspend with DMA activity,
@@ -1137,6 +1165,11 @@ static int mv_xor_resume(struct platform_device *dev)
 			       XOR_INTR_MASK(mv_chan));
 	}
 
+	if (xordev->xor_type == XOR_ARMADA_37XX) {
+		mv_xor_conf_mbus_windows_a3700(xordev);
+		return 0;
+	}
+
 	dram = mv_mbus_dram_info();
 	if (dram)
 		mv_xor_conf_mbus_windows(xordev, dram);
@@ -1147,6 +1180,7 @@ static int mv_xor_resume(struct platform_device *dev)
 static const struct of_device_id mv_xor_dt_ids[] = {
 	{ .compatible = "marvell,orion-xor", .data = (void *)XOR_ORION },
 	{ .compatible = "marvell,armada-380-xor", .data = (void *)XOR_ARMADA_38X },
+	{ .compatible = "marvell,armada-3700-xor", .data = (void *)XOR_ARMADA_37XX },
 	{},
 };
 
@@ -1204,9 +1238,13 @@ static int mv_xor_probe(struct platform_device *pdev)
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
-	dram = mv_mbus_dram_info();
-	if (dram)
-		mv_xor_conf_mbus_windows(xordev, dram);
+	if (xordev->xor_type == XOR_ARMADA_37XX) {
+		mv_xor_conf_mbus_windows_a3700(xordev);
+	} else {
+		dram = mv_mbus_dram_info();
+		if (dram)
+			mv_xor_conf_mbus_windows(xordev, dram);
+	}
 
 	/* Not all platforms can gate the clock, so it is not
 	 * an error if the clock does not exists.
@@ -1220,12 +1258,16 @@ static int mv_xor_probe(struct platform_device *pdev)
 	 * order for async_tx to perform well. So we limit the number
 	 * of engines and channels so that we take into account this
 	 * constraint. Note that we also want to use channels from
-	 * separate engines when possible.
+	 * separate engines when possible.  For dual-CPU Armada 3700
+	 * SoC with single XOR engine allow using its both channels.
 	 */
 	max_engines = num_present_cpus();
-	max_channels = min_t(unsigned int,
-			     MV_XOR_MAX_CHANNELS,
-			     DIV_ROUND_UP(num_present_cpus(), 2));
+	if (xordev->xor_type == XOR_ARMADA_37XX)
+		max_channels =	num_present_cpus();
+	else
+		max_channels = min_t(unsigned int,
+				     MV_XOR_MAX_CHANNELS,
+				     DIV_ROUND_UP(num_present_cpus(), 2));
 
 	if (mv_xor_engine_count >= max_engines)
 		return 0;
-- 
2.5.0
