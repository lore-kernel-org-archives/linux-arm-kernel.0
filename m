From: rainyfeeling@gmail.com (Josh Wu)
Date: Mon, 18 Jan 2016 20:52:23 +0800
Subject: [PATCH 11/13] atmel-isi: add hw_uninitialize()
In-Reply-To: <1453121545-27528-1-git-send-email-rainyfeeling@gmail.com>
References: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
 <1453121545-27528-1-git-send-email-rainyfeeling@gmail.com>
Message-ID: <1453121545-27528-7-git-send-email-rainyfeeling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add new function: hw_uninitialize() and call it when stop_streaming().

Signed-off-by: Josh Wu <rainyfeeling@gmail.com>
---

 drivers/media/platform/soc_camera/atmel-isi.c | 46 +++++++++++++++------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index b789523..843102f 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -245,6 +245,31 @@ static int isi_hw_initialize(struct atmel_isi *isi)
 	return 0;
 }
 
+static void isi_hw_uninitialize(struct atmel_isi *isi)
+{
+	int ret;
+
+	if (!isi->enable_preview_path) {
+		/* Wait until the end of the current frame. */
+		ret = isi_hw_wait_status(isi, ISI_CTRL_CDC,
+				         FRAME_INTERVAL_MILLI_SEC);
+		if (ret)
+			dev_err(isi->soc_host.icd->parent, "Timeout waiting for finishing codec request\n");
+	}
+
+	/* Disable interrupts */
+	isi_writel(isi, ISI_INTDIS,
+			ISI_SR_CXFR_DONE | ISI_SR_PXFR_DONE);
+
+	/* Disable ISI and wait for it is done */
+	isi_writel(isi, ISI_CTRL, ISI_CTRL_DIS);
+
+	/* Check Reset status */
+	ret  = isi_hw_wait_status(isi, ISI_CTRL_DIS, 500);
+	if (ret)
+		dev_err(isi->soc_host.icd->parent, "Disable ISI timed out\n");
+}
+
 static void start_isi(struct atmel_isi *isi)
 {
 	u32 ctrl;
@@ -484,7 +509,6 @@ static void stop_streaming(struct vb2_queue *vq)
 	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
 	struct atmel_isi *isi = ici->priv;
 	struct frame_buffer *buf, *node;
-	int ret = 0;
 
 	spin_lock_irq(&isi->lock);
 	isi->active = NULL;
@@ -495,25 +519,7 @@ static void stop_streaming(struct vb2_queue *vq)
 	}
 	spin_unlock_irq(&isi->lock);
 
-	if (!isi->enable_preview_path) {
-		/* Wait until the end of the current frame. */
-		ret = isi_hw_wait_status(isi, ISI_CTRL_CDC,
-				         FRAME_INTERVAL_MILLI_SEC);
-		if (ret)
-			dev_err(icd->parent, "Timeout waiting for finishing codec request\n");
-	}
-
-	/* Disable interrupts */
-	isi_writel(isi, ISI_INTDIS,
-			ISI_SR_CXFR_DONE | ISI_SR_PXFR_DONE);
-
-	/* Disable ISI and wait for it is done */
-	isi_writel(isi, ISI_CTRL, ISI_CTRL_DIS);
-
-	/* Check Reset status */
-	ret  = isi_hw_wait_status(isi, ISI_CTRL_DIS, 500);
-	if (ret)
-		dev_err(icd->parent, "Disable ISI timed out\n");
+	isi_hw_uninitialize(isi);
 
 	pm_runtime_put(ici->v4l2_dev.dev);
 }
-- 
1.9.1
