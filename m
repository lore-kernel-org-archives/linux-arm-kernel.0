From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 Nov 2012 18:32:22 +0100
Subject: [PATCH 2/5] dma: mv_xor: clear the window override control registers
In-Reply-To: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353605545-7091-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353605545-7091-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The XOR channels on Marvell SoCs have a Window Override Control
register that allow to do some fancy things with addresses. Those
features are not used by the driver, but some U-Boot versions anyway
modify those registers.

For some reason, the U-Boot on OpenBlocks AX3-4 was setting an invalid
value in those registers when the addition 2 GB DRAM chip was plugged
into the board, causing the XOR driver to fail in using the XOR
engines.

By setting those registers to 0 during the driver initialization, we
ensure that the registers are configured according with the driver
operation model.

Thanks to Lior Amsalem <alior@marvell.com> for his help in debugging
this problem.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/dma/mv_xor.c |    2 ++
 drivers/dma/mv_xor.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index f450fe8..2c69b89 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1240,6 +1240,8 @@ mv_xor_conf_mbus_windows(struct mv_xor_device *xordev,
 
 	writel(win_enable, base + WINDOW_BAR_ENABLE(0));
 	writel(win_enable, base + WINDOW_BAR_ENABLE(1));
+	writel(0, base + WINDOW_OVERRIDE_CTRL(0));
+	writel(0, base + WINDOW_OVERRIDE_CTRL(1));
 }
 
 static int __devinit mv_xor_probe(struct platform_device *pdev)
diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index 1704328..c632a47 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -53,6 +53,7 @@
 #define WINDOW_SIZE(w)		(0x270 + ((w) << 2))
 #define WINDOW_REMAP_HIGH(w)	(0x290 + ((w) << 2))
 #define WINDOW_BAR_ENABLE(chan)	(0x240 + ((chan) << 2))
+#define WINDOW_OVERRIDE_CTRL(chan)	(0x2A0 + ((chan) << 2))
 
 struct mv_xor_device {
 	void __iomem	     *xor_base;
-- 
1.7.9.5
