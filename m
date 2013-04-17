From: cedric@precidata.com (Cedric Berger)
Date: Wed, 17 Apr 2013 22:42:49 +0200 (CEST)
Subject: [PATCH 1/10] LPC32XX: 001-mmc.1: Define + Implement DMA_FORCE_BURST
 for pl032
Message-ID: <mailman.13.1366231399.1198.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gabriele Mondada <gabriele@precidata.com>
---
To implement the MMC driver on LPC32xx, we need a way to force a DMA burst by
software. This patch defines a new DMA_FORCE_BURST hook and implements it for
the pl08x.c

Index: include/linux/dmaengine.h
===================================================================
--- include/linux/dmaengine.h	(revision 1688)
+++ include/linux/dmaengine.h	(revision 1736)
@@ -208,6 +208,7 @@
  * argument of struct dma_slave_config must be passed in with this
  * command.
  * @FSLDMA_EXTERNAL_START: this command will put the Freescale DMA controller
+ * @DMA_FORCE_BURST: force DMA burst
  * into external start mode.
  */
 enum dma_ctrl_cmd {
@@ -216,6 +217,7 @@
 	DMA_RESUME,
 	DMA_SLAVE_CONFIG,
 	FSLDMA_EXTERNAL_START,
+	DMA_FORCE_BURST,
 };
 
 /**
Index: drivers/dma/amba-pl08x.c
===================================================================
--- drivers/dma/amba-pl08x.c	(revision 1688)
+++ drivers/dma/amba-pl08x.c	(revision 1736)
@@ -448,6 +448,19 @@
 	writel(1 << ch->id, pl08x->base + PL080_TC_CLEAR);
 }
 
+/*
+ * simulate a DMA request by software, generating a burst transfer
+ */
+static void pl08x_force_burst(struct pl08x_dma_chan *plchan)
+{
+	struct pl08x_driver_data *pl08x = plchan->host;
+
+	dev_dbg(&pl08x->adev->dev, "force burst signal=%d plchan=%p\n",
+		plchan->signal, plchan);
+	if (plchan->signal >= 0)
+		writel(1 << plchan->signal, pl08x->base + PL080_SOFT_BREQ);
+}
+
 static inline u32 get_bytes_in_cctl(u32 cctl)
 {
 	/* The source width defines the number of bytes */
@@ -1574,6 +1587,9 @@
 		pl08x_resume_phy_chan(plchan->phychan);
 		plchan->state = PL08X_CHAN_RUNNING;
 		break;
+	case DMA_FORCE_BURST:
+		pl08x_force_burst(plchan);
+		break;
 	default:
 		/* Unknown command */
 		ret = -ENXIO;
