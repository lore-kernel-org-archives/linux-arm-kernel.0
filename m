From: zonque@gmail.com (Daniel Mack)
Date: Tue, 13 Aug 2013 17:44:26 +0200
Subject: [PATCH v2] usb: musb dsps: fix pdev cast in suspend/resume
Message-ID: <1376408666-20075-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dsps_suspend() and dsps_resume() are called with the device that has the
glue assigned as drvdata. Using dev->parent seems wrong and causes a
NULL pointer exception on an AM33xx board.

The code was introduced by commit c68bb4c6 ("usb: musb: dsps: control
module handling (quirk)") but I wonder whether it was ever used.

As suggested by Felipe, this patch gets rid of the platform_device
access entirely by using dev_get_drvdata().

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/musb_dsps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 5233804..16e36a3 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -692,8 +692,7 @@ static int dsps_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int dsps_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct dsps_glue *glue = dev_get_drvdata(dev);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	int i;
 
@@ -705,8 +704,7 @@ static int dsps_suspend(struct device *dev)
 
 static int dsps_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct dsps_glue *glue = dev_get_drvdata(dev);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	int i;
 
-- 
1.8.3.1
