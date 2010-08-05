From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Aug 2010 16:08:44 +0200
Subject: [PATCH 10/19] VIDEO: sa1100fb: register driver using
	platform_driver_probe
In-Reply-To: <20100805140813.GA13859@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
Message-ID: <1281017333-5563-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes

	WARNING: vmlinux.o(.devinit.text+0x364): Section mismatch in reference from the function sa1100fb_probe() to the function .init.text:sa1100fb_init_fbinfo()
	The function __devinit sa1100fb_probe() references
	a function __init sa1100fb_init_fbinfo().
	If sa1100fb_init_fbinfo is only used by sa1100fb_probe then
	annotate sa1100fb_init_fbinfo with a matching annotation.

Commit c2e13037e6794bd0d9de3f9ecabf5615f15c160b addressed a section
mismatch in this driver but introduced new ones as sa1100fb_probe
references many more .init variables and functions (some of them
indirectly) so using platform_driver_probe is less intrusive.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/sa1100fb.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index e8b76d6..35fc741 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1351,7 +1351,6 @@ static struct fb_monspecs monspecs __initdata = {
 	.vfmax	= 65,
 };
 
-
 static struct sa1100fb_info * __init sa1100fb_init_fbinfo(struct device *dev)
 {
 	struct sa1100fb_mach_info *inf;
@@ -1435,7 +1434,7 @@ static struct sa1100fb_info * __init sa1100fb_init_fbinfo(struct device *dev)
 	return fbi;
 }
 
-static int __devinit sa1100fb_probe(struct platform_device *pdev)
+static int __init sa1100fb_probe(struct platform_device *pdev)
 {
 	struct sa1100fb_info *fbi;
 	int ret, irq;
@@ -1501,7 +1500,6 @@ static int __devinit sa1100fb_probe(struct platform_device *pdev)
 }
 
 static struct platform_driver sa1100fb_driver = {
-	.probe		= sa1100fb_probe,
 	.suspend	= sa1100fb_suspend,
 	.resume		= sa1100fb_resume,
 	.driver		= {
@@ -1514,7 +1512,7 @@ int __init sa1100fb_init(void)
 	if (fb_get_options("sa1100fb", NULL))
 		return -ENODEV;
 
-	return platform_driver_register(&sa1100fb_driver);
+	return platform_driver_probe(&sa1100fb_driver, sa1100fb_probe);
 }
 
 int __init sa1100fb_setup(char *options)
-- 
1.7.1
