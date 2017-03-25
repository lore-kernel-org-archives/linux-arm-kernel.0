From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 24 Mar 2017 18:04:59 -0600
Subject: [PATCH 1/7] usb: dwc3: core: fix dwc3_probe() to not do put_sync when
 get_sync fails
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Message-ID: <2238ea52423a83118ab724a96e8f0691ec4ada0b.1490387086.git.shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dwc3_probe() does pm_runtime_put_sync() in its err1 handling when
pm_runtime_get_sync() fails.  Move the pm_runtime_put_sync() under
err2 instead as it is used in error paths after pm_runtime_get_sync()
succeeds.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 56f1367..0fc7bef 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1162,9 +1162,9 @@ static int dwc3_probe(struct platform_device *pdev)
 
 err2:
 	pm_runtime_allow(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 
 err1:
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 err0:
-- 
2.7.4
