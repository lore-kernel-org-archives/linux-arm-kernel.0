From: jeremy.lefaure@lse.epita.fr (=?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=)
Date: Sun, 12 Mar 2017 16:13:29 -0400
Subject: [PATCH] [media] vcodev: mediatek: add missing include in JPEG decoder
 driver
Message-ID: <20170312201329.28357-1-jeremy.lefaure@lse.epita.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver uses kzalloc and kfree functions. So it should include
linux/slab.h. This header file is implicitly included by v4l2-common.h
if CONFIG_SPI is enabled. But when it is disabled, slab.h is not
included. In this case, the driver does not compile:

drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c: In function ?mtk_jpeg_open?:
drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:1017:8: error: implicit
declaration of function ?kzalloc?
[-Werror=implicit-function-declaration]
  ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
        ^~~~~~~
drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:1017:6: warning:
assignment makes pointer from integer without a cast [-Wint-conversion]
  ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
      ^
drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c:1047:2: error: implicit
declaration of function ?kfree? [-Werror=implicit-function-declaration]
  kfree(ctx);
  ^~~~~

This patch adds the missing include to fix this issue.

Signed-off-by: J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index b10183f7942b..f9bd58ce7d32 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
-- 
2.12.0
