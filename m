From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 16 Jun 2016 17:40:34 -0400
Subject: [PATCH 5/6] [media] gsc-m2m: add device name sufix to bus_info
 capatiliby field
In-Reply-To: <1466113235-25909-1-git-send-email-javier@osg.samsung.com>
References: <1466113235-25909-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1466113235-25909-6-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver doesn't set the device in the struct v4l2_capability bus_info
field so v4l2-compliance reports the following error for VIDIOC_QUERYCAP:

Required ioctls:
                fail: v4l2-compliance.cpp(537): missing bus_info prefix ('platform')
        test VIDIOC_QUERYCAP: FAIL

This patch fixes this by filling also the device besides the bus.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/media/platform/exynos-gsc/gsc-m2m.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos-gsc/gsc-m2m.c b/drivers/media/platform/exynos-gsc/gsc-m2m.c
index a600e32e2543..af81383086b8 100644
--- a/drivers/media/platform/exynos-gsc/gsc-m2m.c
+++ b/drivers/media/platform/exynos-gsc/gsc-m2m.c
@@ -281,7 +281,8 @@ static int gsc_m2m_querycap(struct file *file, void *fh,
 
 	strlcpy(cap->driver, gsc->pdev->name, sizeof(cap->driver));
 	strlcpy(cap->card, gsc->pdev->name, sizeof(cap->card));
-	strlcpy(cap->bus_info, "platform", sizeof(cap->bus_info));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
+		 dev_name(&gsc->pdev->dev));
 	cap->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE |
 		V4L2_CAP_VIDEO_CAPTURE_MPLANE |	V4L2_CAP_VIDEO_OUTPUT_MPLANE;
 
-- 
2.5.5
