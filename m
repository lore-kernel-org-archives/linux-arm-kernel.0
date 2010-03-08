From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon,  8 Mar 2010 14:52:07 +0100
Subject: [PATCH 1/5] ARM: define the PrimeCell DMA API
Message-ID: <1268056327-16577-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends the DMA engine with a PrimeCell superset with
three functions: configure DMA channel, stop channel, and one for
getting the number of bytes pending on a channel. These have been
identified as the basic extensions needed to drive DMA on top of
the PL011 and PL180 PrimeCells.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 include/linux/amba/dma.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/amba/dma.h

diff --git a/include/linux/amba/dma.h b/include/linux/amba/dma.h
new file mode 100644
index 0000000..13196af
--- /dev/null
+++ b/include/linux/amba/dma.h
@@ -0,0 +1,44 @@
+/*
+ *  linux/include/amba/dma.h
+ *
+ *  Copyright (C) 2010 ST-Ericsson AB
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#if !defined(AMBA_DMA_H) && defined(CONFIG_DMADEVICES)
+#define AMBA_DMA_H
+
+/**
+ * struct amba_dma_channel_request - this struct is passed in as
+ * configuration data to a DMA engine in order to set up a certain
+ * channel for DMA transport. Anything the DMA engine needs to
+ * know about the PrimeCell shall be passed through this struct.
+ * The DMA engine has to provide an additional function:
+ * dma_set_ambaconfig() in order for it to work with PrimeCells.
+ * @addr: this is the physical address where DMA data should be
+ * read (RX) or written (TX)
+ * @addr_width: this is the width of the source (RX) or target
+ * (TX) register where DMA data shall be read/written, in bytes.
+ * legal values: 1, 2, 4, 8.
+ */
+struct amba_dma_channel_config {
+	dma_addr_t addr;
+	u8 addr_width:4;
+};
+
+/*
+ * The following are extensions to the DMA engine framework
+ * that are needed to use the engine with PrimeCells. We need
+ * to configure devices and be able to stop transfers and
+ * retrieve the number of bytes left on the channel for some
+ * RX transfers when we don't know where and how the transfer
+ * will occur.
+ */
+void dma_set_ambaconfig(struct dma_chan *chan,
+			struct amba_dma_channel_config *config);
+void dma_stop_channel(struct dma_chan *chan);
+u32 dma_get_channel_bytes_left(struct dma_chan *chan);
+
+#endif /* AMBA_DMA_H */
-- 
1.6.2.5
