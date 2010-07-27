From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 27 Jul 2010 15:06:07 +0300
Subject: [PATCH 1/4] mx2_camera: fix a race causing NULL dereference
In-Reply-To: <cover.1280229966.git.baruch@tkos.co.il>
References: <cover.1280229966.git.baruch@tkos.co.il>
Message-ID: <9f12919acb3673ff10249ea3d151eccaa2818859.1280229966.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mx25_camera_irq irq handler may get called after the camera has been
deactivated (from mx2_camera_deactivate). Detect this situation, and bail out.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/media/video/mx2_camera.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/mx2_camera.c b/drivers/media/video/mx2_camera.c
index 881d5d8..1536bd4 100644
--- a/drivers/media/video/mx2_camera.c
+++ b/drivers/media/video/mx2_camera.c
@@ -384,6 +384,9 @@ static void mx25_camera_frame_done(struct mx2_camera_dev *pcdev, int fb,
 
 	spin_lock_irqsave(&pcdev->lock, flags);
 
+	if (*fb_active == NULL)
+		goto out;
+
 	vb = &(*fb_active)->vb;
 	dev_dbg(pcdev->dev, "%s (vb=0x%p) 0x%08lx %d\n", __func__,
 		vb, vb->baddr, vb->bsize);
@@ -408,6 +411,7 @@ static void mx25_camera_frame_done(struct mx2_camera_dev *pcdev, int fb,
 
 	*fb_active = buf;
 
+out:
 	spin_unlock_irqrestore(&pcdev->lock, flags);
 }
 
-- 
1.7.1
