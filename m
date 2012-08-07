From: balbi@ti.com (Felipe Balbi)
Date: Tue,  7 Aug 2012 15:11:08 +0300
Subject: [PATCH] i2c: omap: switch over to autosuspend API
In-Reply-To: <20120807120728.GW8468@arwen.pp.htv.fi>
References: <20120807120728.GW8468@arwen.pp.htv.fi>
Message-ID: <1344341468-8144-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this helps us reduce unnecessary pm transitions
in case we have another i2c message been started
soon.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 60928f2..c210b45 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -645,7 +645,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	omap_i2c_wait_for_bb(dev);
 out:
-	pm_runtime_put(dev->dev);
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 	return r;
 }
 
@@ -1113,6 +1114,9 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->regs = (u8 *)reg_map_ip_v1;
 
 	pm_runtime_enable(dev->dev);
+	pm_runtime_set_autosuspend_delay(dev->dev, 1000);
+	pm_runtime_use_autosuspend(dev->dev);
+
 	r = pm_runtime_get_sync(dev->dev);
 	if (IS_ERR_VALUE(r))
 		goto err_free_mem;
@@ -1189,7 +1193,8 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	of_i2c_register_devices(adap);
 
-	pm_runtime_put(dev->dev);
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
-- 
1.7.12.rc0
