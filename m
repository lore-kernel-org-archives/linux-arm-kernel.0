From: loic.minier@linaro.org (=?UTF-8?q?Lo=C3=AFc=20Minier?=)
Date: Mon, 20 Jun 2011 22:44:17 +0200
Subject: [PATCH] ARM: amba: Link fb device to its parent
Message-ID: <1308602657-28783-1-git-send-email-loic.minier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some pieces of userspace like debian-installer expect to find the fb0
driver name by readlink-ing /sys/class/graphics/fb0/device/driver but
this was broken with amba-clcd as it sets up fb_info manually and missed
the .device parent pointer.

Signed-off-by: Lo?c Minier <loic.minier@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 drivers/video/amba-clcd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 5fc983c..cf03ad0 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -447,6 +447,8 @@ static int clcdfb_register(struct clcd_fb *fb)
 		goto out;
 	}
 
+	fb->fb.device		= &fb->dev->dev;
+
 	fb->fb.fix.mmio_start	= fb->dev->res.start;
 	fb->fb.fix.mmio_len	= resource_size(&fb->dev->res);
 
-- 
1.7.5.4
