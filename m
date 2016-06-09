From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed,  8 Jun 2016 21:57:35 -0400
Subject: [PATCH 2/2] [media] s5p-mfc: don't print errors on VIDIOC_REQBUFS
 unsupported mem type
In-Reply-To: <1465437455-24110-1-git-send-email-javier@osg.samsung.com>
References: <1465437455-24110-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1465437455-24110-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The V4L2 documentation says that applications must call the VIDIOC_REQBUFS
ioctl to determine if a memory mapped, user pointer or DMABUF based I/O is
supported by the driver.

For example GStreamer does this by first calling VIDIOC_REQBUFS with count
zero for all the possible streaming I/O methods and then finally doing the
real VIDIOC_REQBUFS with count N using a known to be supported memory type.

But the driver prints an error on VIDIOC_REQBUFS if the memory type is not
supported which leads to the following errors that can confuse the users:

[  178.704390] vidioc_reqbufs:575: Only V4L2_MEMORY_MMAP is supported
[  178.704666] vidioc_reqbufs:575: Only V4L2_MEMORY_MMAP is supported
[  178.714956] vidioc_reqbufs:575: Only V4L2_MEMORY_MMAP is supported
[  178.715229] vidioc_reqbufs:575: Only V4L2_MEMORY_MMAP is supported

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index 8e2ee1a0df2b..038215c198ac 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -572,7 +572,7 @@ static int vidioc_reqbufs(struct file *file, void *priv,
 	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
 
 	if (reqbufs->memory != V4L2_MEMORY_MMAP) {
-		mfc_err("Only V4L2_MEMORY_MMAP is supported\n");
+		mfc_debug(2, "Only V4L2_MEMORY_MMAP is supported\n");
 		return -EINVAL;
 	}
 
-- 
2.5.5
