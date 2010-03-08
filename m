From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon,  8 Mar 2010 14:52:19 +0100
Subject: [PATCH 2/5] ARM: add generic PrimeCell interface to COH 901 318
Message-ID: <1268056339-16855-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extends the DMA engine driver for the COH 901 318 used in the
U300 platform with the generic PrimeCell interface,

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/dma/coh901318.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index f636c4a..a0241b1 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <mach/coh901318.h>
+#include <linux/amba/dma.h>
 
 #include "coh901318_lli.h"
 
@@ -1228,6 +1229,26 @@ coh901318_terminate_all(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&cohc->lock, flags);
 }
+
+/*
+ * Here we wrap in the PrimeCell dma interface
+ */
+void dma_set_ambaconfig(struct dma_chan *chan,
+			struct amba_dma_channel_config *config)
+{
+	/* Dummy implementation - our channels currently knows all */
+}
+
+void dma_stop_channel(struct dma_chan *chan)
+{
+	coh901318_stop(chan);
+}
+
+u32 dma_get_channel_bytes_left(struct dma_chan *chan)
+{
+	return coh901318_get_bytes_left(chan);
+}
+
 void coh901318_base_init(struct dma_device *dma, const int *pick_chans,
 			 struct coh901318_base *base)
 {
-- 
1.6.2.5
