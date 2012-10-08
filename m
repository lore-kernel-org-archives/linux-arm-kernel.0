From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 8 Oct 2012 14:35:14 +0530
Subject: [PATCH 1/3] i2c: omap: Do not enable the irq always
Message-ID: <1349687116-14463-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the irq in the transfer and disable it after the
transfer is done.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b6c6b95..ce41596 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -625,6 +625,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	if (IS_ERR_VALUE(r))
 		goto out;
 
+	enable_irq(dev->irq);
 	r = omap_i2c_wait_for_bb(dev);
 	if (r < 0)
 		goto out;
@@ -654,6 +655,7 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	omap_i2c_wait_for_bb(dev);
 out:
+	disable_irq(dev->irq);
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 	return r;
@@ -1179,6 +1181,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
+	disable_irq(dev->irq);
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
-- 
1.7.5.4
