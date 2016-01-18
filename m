From: rainyfeeling@gmail.com (Josh Wu)
Date: Mon, 18 Jan 2016 20:21:41 +0800
Subject: [PATCH 05/13] atmel-isi: add a function: isi_hw_wait_status() to
 check ISI_SR status
In-Reply-To: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
References: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
Message-ID: <1453119709-20940-6-git-send-email-rainyfeeling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

Extract the code that check ISI_SR flag into a function:
isi_hw_wait_status().

In this patch, we use isi_hw_wait_status() to check CDC pending status.

Signed-off-by: Josh Wu <rainyfeeling@gmail.com>
---

 drivers/media/platform/soc_camera/atmel-isi.c | 28 ++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index 4bd8258..f0508ea 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -190,6 +190,21 @@ static void configure_geometry(struct atmel_isi *isi, u32 width,
 	return;
 }
 
+static int isi_hw_wait_status(struct atmel_isi *isi, int status_flag,
+			       int wait_ms)
+{
+	unsigned long timeout = jiffies + wait_ms * HZ;
+
+	while ((isi_readl(isi, ISI_STATUS) & status_flag) &&
+			time_before(jiffies, timeout))
+		msleep(1);
+
+	if (time_after(jiffies, timeout))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static void isi_hw_initialize(struct atmel_isi *isi)
 {
 	u32 common_flags = isi->bus_param;
@@ -511,7 +526,6 @@ static void stop_streaming(struct vb2_queue *vq)
 	struct atmel_isi *isi = ici->priv;
 	struct frame_buffer *buf, *node;
 	int ret = 0;
-	unsigned long timeout;
 
 	spin_lock_irq(&isi->lock);
 	isi->active = NULL;
@@ -523,15 +537,11 @@ static void stop_streaming(struct vb2_queue *vq)
 	spin_unlock_irq(&isi->lock);
 
 	if (!isi->enable_preview_path) {
-		timeout = jiffies + FRAME_INTERVAL_MILLI_SEC * HZ;
 		/* Wait until the end of the current frame. */
-		while ((isi_readl(isi, ISI_STATUS) & ISI_CTRL_CDC) &&
-				time_before(jiffies, timeout))
-			msleep(1);
-
-		if (time_after(jiffies, timeout))
-			dev_err(icd->parent,
-				"Timeout waiting for finishing codec request\n");
+		ret = isi_hw_wait_status(isi, ISI_CTRL_CDC,
+					 FRAME_INTERVAL_MILLI_SEC);
+		if (ret)
+			dev_err(icd->parent, "Timeout waiting for finishing codec request\n");
 	}
 
 	/* Disable interrupts */
-- 
1.9.1
