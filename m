From: songjun.wu@microchip.com (Songjun Wu)
Date: Tue, 1 Nov 2016 16:08:46 +0800
Subject: [PATCH] [media] atmel-isc: release the filehandle if it's not the
 only one.
Message-ID: <1477987726-4257-1-git-send-email-songjun.wu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Release the filehandle in 'isc_open' if it's not the only filehandle
opened for the associated video_device.

Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
---

 drivers/media/platform/atmel/atmel-isc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
index 8e25d3f..5e08404 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -926,21 +926,21 @@ static int isc_open(struct file *file)
 	if (ret < 0)
 		goto unlock;
 
-	if (!v4l2_fh_is_singular_file(file))
-		goto unlock;
+	ret = !v4l2_fh_is_singular_file(file);
+	if (ret)
+		goto fh_rel;
 
 	ret = v4l2_subdev_call(sd, core, s_power, 1);
-	if (ret < 0 && ret != -ENOIOCTLCMD) {
-		v4l2_fh_release(file);
-		goto unlock;
-	}
+	if (ret < 0 && ret != -ENOIOCTLCMD)
+		goto fh_rel;
 
 	ret = isc_set_fmt(isc, &isc->fmt);
-	if (ret) {
+	if (ret)
 		v4l2_subdev_call(sd, core, s_power, 0);
-		v4l2_fh_release(file);
-	}
 
+fh_rel:
+	if (ret)
+		v4l2_fh_release(file);
 unlock:
 	mutex_unlock(&isc->lock);
 	return ret;
-- 
2.7.4
