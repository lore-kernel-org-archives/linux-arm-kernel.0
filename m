From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Tue, 17 Jun 2014 11:17:08 -0300
Subject: [PATCH/RESEND 6/9] drm/tilcdc: fix release order on exit
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <1403014631-18072-7-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unregister resources in the correct order on tilcdc_drm_fini, which is
the reverse order they were registered during tilcdc_drm_init.

This also means unregistering the driver before releasing its resources.

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
Cc: <stable@vger.kernel.org> #v3.9+
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 490aee7..006a30e 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -629,10 +629,10 @@ static int __init tilcdc_drm_init(void)
 static void __exit tilcdc_drm_fini(void)
 {
 	DBG("fini");
-	tilcdc_tfp410_fini();
-	tilcdc_slave_fini();
-	tilcdc_panel_fini();
 	platform_driver_unregister(&tilcdc_platform_driver);
+	tilcdc_panel_fini();
+	tilcdc_slave_fini();
+	tilcdc_tfp410_fini();
 }
 
 late_initcall(tilcdc_drm_init);
-- 
2.0.0
