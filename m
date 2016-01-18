From: rainyfeeling@gmail.com (Josh Wu)
Date: Mon, 18 Jan 2016 20:52:20 +0800
Subject: [PATCH 09/13] atmel-isi: add a function start_isi()
In-Reply-To: <1453121545-27528-1-git-send-email-rainyfeeling@gmail.com>
References: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
 <1453121545-27528-1-git-send-email-rainyfeeling@gmail.com>
Message-ID: <1453121545-27528-4-git-send-email-rainyfeeling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since start_dma() has code which is to start isi, so move such code into
a new function: start_isi().

Signed-off-by: Josh Wu <rainyfeeling@gmail.com>
---

 drivers/media/platform/soc_camera/atmel-isi.c | 32 +++++++++++++++------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index e1ad18f..0e42171 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -245,6 +245,20 @@ static int isi_hw_initialize(struct atmel_isi *isi)
 	return 0;
 }
 
+static void start_isi(struct atmel_isi *isi)
+{
+	u32 ctrl;
+
+	/* cxfr for the codec path, pxfr for the preview path */
+	isi_writel(isi, ISI_INTEN,
+		   ISI_SR_CXFR_DONE | ISI_SR_PXFR_DONE);
+
+	/* Enable ISI */
+	ctrl = ISI_CTRL_EN |
+	       (isi->enable_preview_path ? 0 : ISI_CTRL_CDC);
+	isi_writel(isi, ISI_CTRL, ctrl);
+}
+
 static irqreturn_t atmel_isi_handle_streaming(struct atmel_isi *isi)
 {
 	if (isi->active) {
@@ -403,12 +417,6 @@ static void buffer_cleanup(struct vb2_buffer *vb)
 
 static void start_dma(struct atmel_isi *isi, struct frame_buffer *buffer)
 {
-	u32 ctrl;
-
-	/* Enable irq: cxfr for the codec path, pxfr for the preview path */
-	isi_writel(isi, ISI_INTEN,
-			ISI_SR_CXFR_DONE | ISI_SR_PXFR_DONE);
-
 	/* Check if already in a frame */
 	if (!isi->enable_preview_path) {
 		if (isi_readl(isi, ISI_STATUS) & ISI_CTRL_CDC) {
@@ -429,13 +437,6 @@ static void start_dma(struct atmel_isi *isi, struct frame_buffer *buffer)
 		isi_writel(isi, ISI_DMA_CHER, ISI_DMA_CHSR_P_CH);
 	}
 
-	/* Enable ISI */
-	ctrl = ISI_CTRL_EN;
-
-	if (!isi->enable_preview_path)
-		ctrl |= ISI_CTRL_CDC;
-
-	isi_writel(isi, ISI_CTRL, ctrl);
 }
 
 static void buffer_queue(struct vb2_buffer *vb)
@@ -478,8 +479,11 @@ static int start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	spin_lock_irq(&isi->lock);
 
-	if (count)
+	if (count) {
 		start_dma(isi, isi->active);
+		start_isi(isi);
+	}
+
 	spin_unlock_irq(&isi->lock);
 
 	return 0;
-- 
1.9.1
