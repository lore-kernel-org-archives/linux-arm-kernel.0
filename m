From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Tue, 17 Jun 2014 11:17:06 -0300
Subject: [PATCH/RESEND 4/9] drm/tilcdc: tfp410: fix dangling sysfs connector
 node
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <1403014631-18072-5-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a drm_sysfs_connector_remove call when we destroy the panel to make
sure the connector node in sysfs gets deleted.

This is required for proper unload and re-load of this driver, otherwise
we will get a warning about a duplicate filename in sysfs.

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
Cc: <stable@vger.kernel.org> #v3.9+
---
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
index c38b56b..ce75ac8 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -167,6 +167,7 @@ struct tfp410_connector {
 static void tfp410_connector_destroy(struct drm_connector *connector)
 {
 	struct tfp410_connector *tfp410_connector = to_tfp410_connector(connector);
+	drm_sysfs_connector_remove(connector);
 	drm_connector_cleanup(connector);
 	kfree(tfp410_connector);
 }
-- 
2.0.0
