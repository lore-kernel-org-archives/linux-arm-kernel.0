From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 18 Oct 2011 14:24:50 +0200
Subject: [PATCH] amba: be more careful in runtime_suspend/resume
Message-ID: <1318940690-30138-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This checks that a valid pclk actually was retrieved before
trying to disable/enable it in the runtime PM hooks on the
PrimeCell bus.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/amba/bus.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index bd230e8..57c33b9 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -378,7 +378,7 @@ static int amba_pm_runtime_suspend(struct device *dev)
 	int ret = pm_generic_runtime_suspend(dev);
 
 	if (ret == 0 && dev->driver)
-		clk_disable(pcdev->pclk);
+		amba_pclk_disable(pcdev);
 
 	return ret;
 }
@@ -388,8 +388,8 @@ static int amba_pm_runtime_resume(struct device *dev)
 	struct amba_device *pcdev = to_amba_device(dev);
 	int ret;
 
-	if (dev->driver) {
-		ret = clk_enable(pcdev->pclk);
+	if (dev->driver && !IS_ERR(pcdev->pclk)) {
+		ret = amba_pclk_enable(pcdev->pclk);
 		/* Failure is probably fatal to the system, but... */
 		if (ret)
 			return ret;
-- 
1.7.3.2
