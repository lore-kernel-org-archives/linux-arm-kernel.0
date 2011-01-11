From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 11 Jan 2011 12:43:53 +0000
Subject: [PATCH 16/16] w1: mxc_w1: don't treat NULL clk as an error
In-Reply-To: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1294749833-32019-17-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_get() returns a struct clk cookie to the driver and some platforms
may return NULL if they only support a single clock.  clk_get() has only
failed if it returns a ERR_PTR() encoded pointer.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/w1/masters/mxc_w1.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index a3b6a74..67ea082 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -118,8 +119,8 @@ static int __devinit mxc_w1_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mdev->clk = clk_get(&pdev->dev, "owire");
-	if (!mdev->clk) {
-		err = -ENODEV;
+	if (IS_ERR(mdev->clk)) {
+		err = PTR_ERR(mdev->clk);
 		goto failed_clk;
 	}
 
-- 
1.7.3.4
