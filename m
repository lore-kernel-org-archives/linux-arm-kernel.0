From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 30 May 2014 12:10:49 +0200
Subject: [PATCH 1/2] backlight: show brightness even if get_brightness is not
 implemented
In-Reply-To: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
References: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1401444650-12267-2-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many implementations of get_brightness operation returns only value
of props.brightness field. This change makes such implementations
unnecessary.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/video/backlight/backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 19b170d..0ce8823 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -221,6 +221,8 @@ static ssize_t actual_brightness_show(struct device *dev,
 	mutex_lock(&bd->ops_lock);
 	if (bd->ops && bd->ops->get_brightness)
 		rc = sprintf(buf, "%d\n", bd->ops->get_brightness(bd));
+	else
+		rc = sprintf(buf, "%d\n", bd->props.brightness);
 	mutex_unlock(&bd->ops_lock);
 
 	return rc;
-- 
1.9.1
