From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Mon, 14 Mar 2016 19:16:14 +0800
Subject: [PATCH v2] media: v4l2-compat-ioctl32: fix missing reserved field
 copy in put_v4l2_create32
Message-ID: <1457954174-38624-1-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In v4l2-compliance utility, test VIDIOC_CREATE_BUFS will check whether reserved
filed of v4l2_create_buffers filled with zero
Reserved field is filled with zero in v4l_create_bufs.
This patch copy reserved field of v4l2_create_buffer from kernel space to user
space

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---

Changes since v1
- Remove Change-Id
- Add commit message

 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index f38c076..109f687 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -280,7 +280,8 @@ static int put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __user
 static int put_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_create_buffers32 __user *up)
 {
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_create_buffers32)) ||
-	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)))
+	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)) ||
+	    copy_to_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
 		return -EFAULT;
 	return __put_v4l2_format32(&kp->format, &up->format);
 }
-- 
1.7.9.5
