From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Jun 2015 14:34:50 -0500
Subject: [PATCH 3/3] i2c: omap: on ->remove() call pm_runtime_put_sync()
In-Reply-To: <1435260890-32335-1-git-send-email-balbi@ti.com>
References: <1435260890-32335-1-git-send-email-balbi@ti.com>
Message-ID: <1435260890-32335-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we're about to remove the module, so we can't
really schedule a PM transition in the future,
we must wait for it to finish.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 828d5caccfcb..b57d84e01562 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1395,7 +1395,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
 		return ret;
 
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
-- 
2.4.4
