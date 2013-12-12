From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 15:38:42 -0600
Subject: [PATCH 4/7] usb: dwc3: omap: fix pm_runtime usage
In-Reply-To: <1386884325-11440-1-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
Message-ID: <1386884325-11440-5-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

even if pm_runtime_get*() fails, it still increments
pm usage counter, so we must pm_runtime_put*()
in that case too. Fix that observation in dwc3-omap.c.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/dwc3/dwc3-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index aea305d..076bb28 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -451,7 +451,7 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "get_sync failed with err %d\n", ret);
-		goto err0;
+		goto err1;
 	}
 
 	reg = dwc3_omap_readl(omap->base, USBOTGSS_REVISION);
@@ -566,8 +566,6 @@ err2:
 
 err1:
 	pm_runtime_put_sync(dev);
-
-err0:
 	pm_runtime_disable(dev);
 
 	return ret;
-- 
1.8.4.GIT
