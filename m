From: rainyfeeling@gmail.com (Josh Wu)
Date: Mon, 18 Jan 2016 20:52:21 +0800
Subject: [PATCH 10/13] atmel-isi: reuse start_dma() function in isi interrupt
 handler
In-Reply-To: <1453121545-27528-1-git-send-email-rainyfeeling@gmail.com>
References: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
 <1453121545-27528-1-git-send-email-rainyfeeling@gmail.com>
Message-ID: <1453121545-27528-5-git-send-email-rainyfeeling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reuse start_dma() in interrupt handler function to avoid duplication.
Also we need to move start_dma() function up in the file.

Signed-off-by: Josh Wu <rainyfeeling@gmail.com>
---

 drivers/media/platform/soc_camera/atmel-isi.c | 62 +++++++++++----------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index 0e42171..c1a8698 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -259,6 +259,30 @@ static void start_isi(struct atmel_isi *isi)
 	isi_writel(isi, ISI_CTRL, ctrl);
 }
 
+static void start_dma(struct atmel_isi *isi, struct frame_buffer *buffer)
+{
+	/* Check if already in a frame */
+	if (!isi->enable_preview_path) {
+		if (isi_readl(isi, ISI_STATUS) & ISI_CTRL_CDC) {
+			dev_err(isi->soc_host.icd->parent, "Already in frame handling.\n");
+			return;
+		}
+
+		isi_writel(isi, ISI_DMA_C_DSCR,
+				(u32)buffer->p_dma_desc->fbd_phys);
+		isi_writel(isi, ISI_DMA_C_CTRL,
+				ISI_DMA_CTRL_FETCH | ISI_DMA_CTRL_DONE);
+		isi_writel(isi, ISI_DMA_CHER, ISI_DMA_CHSR_C_CH);
+	} else {
+		isi_writel(isi, ISI_DMA_P_DSCR,
+				(u32)buffer->p_dma_desc->fbd_phys);
+		isi_writel(isi, ISI_DMA_P_CTRL,
+				ISI_DMA_CTRL_FETCH | ISI_DMA_CTRL_DONE);
+		isi_writel(isi, ISI_DMA_CHER, ISI_DMA_CHSR_P_CH);
+	}
+
+}
+
 static irqreturn_t atmel_isi_handle_streaming(struct atmel_isi *isi)
 {
 	if (isi->active) {
@@ -277,19 +301,7 @@ static irqreturn_t atmel_isi_handle_streaming(struct atmel_isi *isi)
 		/* start next dma frame. */
 		isi->active = list_entry(isi->video_buffer_list.next,
 					struct frame_buffer, list);
-		if (!isi->enable_preview_path) {
-			isi_writel(isi, ISI_DMA_C_DSCR,
-				(u32)isi->active->p_dma_desc->fbd_phys);
-			isi_writel(isi, ISI_DMA_C_CTRL,
-				ISI_DMA_CTRL_FETCH | ISI_DMA_CTRL_DONE);
-			isi_writel(isi, ISI_DMA_CHER, ISI_DMA_CHSR_C_CH);
-		} else {
-			isi_writel(isi, ISI_DMA_P_DSCR,
-				(u32)isi->active->p_dma_desc->fbd_phys);
-			isi_writel(isi, ISI_DMA_P_CTRL,
-				ISI_DMA_CTRL_FETCH | ISI_DMA_CTRL_DONE);
-			isi_writel(isi, ISI_DMA_CHER, ISI_DMA_CHSR_P_CH);
-		}
+		start_dma(isi, isi->active);
 	}
 	return IRQ_HANDLED;
 }
@@ -415,30 +427,6 @@ static void buffer_cleanup(struct vb2_buffer *vb)
 		list_add(&buf->p_dma_desc->list, &isi->dma_desc_head);
 }
 
-static void start_dma(struct atmel_isi *isi, struct frame_buffer *buffer)
-{
-	/* Check if already in a frame */
-	if (!isi->enable_preview_path) {
-		if (isi_readl(isi, ISI_STATUS) & ISI_CTRL_CDC) {
-			dev_err(isi->soc_host.icd->parent, "Already in frame handling.\n");
-			return;
-		}
-
-		isi_writel(isi, ISI_DMA_C_DSCR,
-				(u32)buffer->p_dma_desc->fbd_phys);
-		isi_writel(isi, ISI_DMA_C_CTRL,
-				ISI_DMA_CTRL_FETCH | ISI_DMA_CTRL_DONE);
-		isi_writel(isi, ISI_DMA_CHER, ISI_DMA_CHSR_C_CH);
-	} else {
-		isi_writel(isi, ISI_DMA_P_DSCR,
-				(u32)buffer->p_dma_desc->fbd_phys);
-		isi_writel(isi, ISI_DMA_P_CTRL,
-				ISI_DMA_CTRL_FETCH | ISI_DMA_CTRL_DONE);
-		isi_writel(isi, ISI_DMA_CHER, ISI_DMA_CHSR_P_CH);
-	}
-
-}
-
 static void buffer_queue(struct vb2_buffer *vb)
 {
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
-- 
1.9.1
