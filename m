From: balbi@ti.com (Felipe Balbi)
Date: Mon, 13 Jul 2015 15:38:04 -0500
Subject: [PATCH 3/3] i2c: omap: on ->remove() call pm_runtime_put_sync()
In-Reply-To: <1436819884-1614-1-git-send-email-balbi@ti.com>
References: <20150710172701.GB20408@saruman.tx.rr.com>
 <1436819884-1614-1-git-send-email-balbi@ti.com>
Message-ID: <1436819884-1614-3-git-send-email-balbi@ti.com>
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
index 7030903a3057..133dd0db6f5b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1457,7 +1457,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
 		return ret;
 
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
-- 
2.4.4
