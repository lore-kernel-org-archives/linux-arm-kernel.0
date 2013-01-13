From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sun, 13 Jan 2013 16:56:43 +0100
Subject: [PATCH] ARM: imx: imxfb: fix imxfb_info configuration order
In-Reply-To: <1358092603-13480-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1358092603-13480-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <1358092603-13480-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gwenhael Goavec-Merou <gwe@trabucayre.com>

The devtype field for fbi (struct imxfb_info) must be set after memset call to
avoid some wrong behaviour (pixel size).

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 drivers/video/imxfb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index e501dbc..8435c5d 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -729,6 +729,8 @@ static int __init imxfb_init_fbinfo(struct platform_device *pdev)
 
 	memset(fbi, 0, sizeof(struct imxfb_info));
 
+	fbi->devtype = pdev->id_entry->driver_data;
+
 	strlcpy(info->fix.id, IMX_NAME, sizeof(info->fix.id));
 
 	info->fix.type			= FB_TYPE_PACKED_PIXELS;
@@ -789,7 +791,6 @@ static int __init imxfb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	fbi = info->par;
-	fbi->devtype = pdev->id_entry->driver_data;
 
 	if (!fb_mode)
 		fb_mode = pdata->mode[0].mode.name;
-- 
1.7.12.4
