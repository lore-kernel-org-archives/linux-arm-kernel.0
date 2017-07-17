From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 17 Jul 2017 12:21:15 +0200
Subject: [PATCH] tee: indicate privileged dev in gen_caps
Message-ID: <1500286875-29888-1-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mirrors the TEE_DESC_PRIVILEGED bit of struct tee_desc:flags into struct
tee_ioctl_version_data:gen_caps as TEE_GEN_CAP_PRIVILEGED in
tee_ioctl_version()

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c   | 5 +++++
 include/uapi/linux/tee.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 5c60bf4423e6..58a5009eacc3 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -90,8 +90,13 @@ static int tee_ioctl_version(struct tee_context *ctx,
 	struct tee_ioctl_version_data vers;
 
 	ctx->teedev->desc->ops->get_version(ctx->teedev, &vers);
+
+	if (ctx->teedev->desc->flags & TEE_DESC_PRIVILEGED)
+		vers.gen_caps |= TEE_GEN_CAP_PRIVILEGED;
+
 	if (copy_to_user(uvers, &vers, sizeof(vers)))
 		return -EFAULT;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 370d8845ab21..688782e90140 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -49,6 +49,7 @@
 #define TEE_MAX_ARG_SIZE	1024
 
 #define TEE_GEN_CAP_GP		(1 << 0)/* GlobalPlatform compliant TEE */
+#define TEE_GEN_CAP_PRIVILEGED	(1 << 1)/* Privileged device (for supplicant) */
 
 /*
  * TEE Implementation ID
-- 
2.7.4
