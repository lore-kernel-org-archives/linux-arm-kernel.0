From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu,  1 Nov 2012 07:04:19 +0800
Subject: [PATCH v3 7/9] i2c: pxa: use devm_kzalloc
In-Reply-To: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1351724661-29050-8-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_kzalloc & add checking in probe() function.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/busses/i2c-pxa.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 1034d93..7c8b5d0 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1078,6 +1078,8 @@ static int i2c_pxa_probe_pdata(struct platform_device *pdev,
 	struct i2c_pxa_platform_data *plat = pdev->dev.platform_data;
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 
+	if (!id)
+		return -EINVAL;
 	*i2c_types = id->driver_data;
 	if (plat) {
 		i2c->use_pio = plat->use_pio;
@@ -1094,29 +1096,23 @@ static int i2c_pxa_probe(struct platform_device *dev)
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
@@ -1209,8 +1205,6 @@ ereqirq:
 eremap:
 	clk_put(i2c->clk);
 eclk:
-	kfree(i2c);
-emalloc:
 	release_mem_region(res->start, resource_size(res));
 	return ret;
 }
-- 
1.7.10.4
