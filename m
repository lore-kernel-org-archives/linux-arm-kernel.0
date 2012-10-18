From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 18 Oct 2012 17:06:59 +0800
Subject: [PATCH 05/10] i2c: pxa: use devm_kzalloc
In-Reply-To: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1350551224-12857-5-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_kzalloc & add checking in probe() function.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/i2c/busses/i2c-pxa.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index cd66ec2..5f96310 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1083,6 +1083,8 @@ static int i2c_pxa_probe_pdata(struct platform_device *pdev,
 	struct i2c_pxa_platform_data *plat = pdev->dev.platform_data;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 
+	if (!id)
+		return -EINVAL;
 	*i2c_types = id->driver_data;
 	if (plat) {
 		i2c->use_pio = plat->use_pio;
@@ -1099,29 +1101,23 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	struct resource *res = NULL;
 	int ret, irq;
 
-	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
-	if (!i2c) {
-		ret = -ENOMEM;
-		goto emalloc;
-	}
+	i2c = devm_kzalloc(&dev->dev, sizeof(struct pxa_i2c), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
 
 	ret = i2c_pxa_probe_dt(dev, i2c, &i2c_type);
 	if (ret > 0)
 		ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
 	if (ret < 0)
-		goto eclk;
+		return ret;
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(dev, 0);
-	if (res == NULL || irq < 0) {
-		ret = -ENODEV;
-		goto eclk;
-	}
+	if (res == NULL || irq < 0)
+		return -ENODEV;
 
-	if (!request_mem_region(res->start, resource_size(res), res->name)) {
-		ret = -ENOMEM;
-		goto eclk;
-	}
+	if (!request_mem_region(res->start, resource_size(res), res->name))
+		return -ENOMEM;
 
 	i2c->adap.owner   = THIS_MODULE;
 	i2c->adap.retries = 5;
@@ -1214,8 +1210,6 @@ ereqirq:
 eremap:
 	clk_put(i2c->clk);
 eclk:
-	kfree(i2c);
-emalloc:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
-- 
1.7.0.4
