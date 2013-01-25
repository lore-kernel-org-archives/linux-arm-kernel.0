From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:55 +0900
Subject: [PATCH 19/80] sh-pfc: Split platform device and platform driver
 registration
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-20-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Move platform driver registration to a static postcore initcall. This
prepares the move of platform device registration to arch code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pfc/core.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index 1bb38e8..cd8f09d 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -573,19 +573,16 @@ static struct platform_device sh_pfc_device = {
 
 int __init register_sh_pfc(struct sh_pfc_platform_data *pdata)
 {
-	int rc;
-
 	sh_pfc_device.dev.platform_data = pdata;
 
-	rc = platform_driver_register(&sh_pfc_driver);
-	if (likely(!rc)) {
-		rc = platform_device_register(&sh_pfc_device);
-		if (unlikely(rc))
-			platform_driver_unregister(&sh_pfc_driver);
-	}
+	return platform_device_register(&sh_pfc_device);
+}
 
-	return rc;
+static int __init sh_pfc_init(void)
+{
+	return platform_driver_register(&sh_pfc_driver);
 }
+postcore_initcall(sh_pfc_init);
 
 static void __exit sh_pfc_exit(void)
 {
-- 
1.7.10.4
