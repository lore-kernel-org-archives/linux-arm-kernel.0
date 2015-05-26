From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 26 May 2015 17:54:45 +0800
Subject: [PATCH v5 1/3] media: atmel-isi: disable ISI even it has codec
 request in stop_streaming()
In-Reply-To: <1432634087-3356-1-git-send-email-josh.wu@atmel.com>
References: <1432634087-3356-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1432634087-3356-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current code, stop_streaming() will just return if ISI is still
working in the codec. But this is incorrect, we need to disable ISI even
it is working on the codec. otherwise stop_streaming() will not work as
we expected.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

Changes in v5:
- add new patch to fix the condition that codec request still in work.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/media/platform/soc_camera/atmel-isi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index 2879026..2227022 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -431,11 +431,9 @@ static void stop_streaming(struct vb2_queue *vq)
 			time_before(jiffies, timeout))
 		msleep(1);
 
-	if (time_after(jiffies, timeout)) {
+	if (time_after(jiffies, timeout))
 		dev_err(icd->parent,
 			"Timeout waiting for finishing codec request\n");
-		return;
-	}
 
 	/* Disable interrupts */
 	isi_writel(isi, ISI_INTDIS,
-- 
1.9.1
