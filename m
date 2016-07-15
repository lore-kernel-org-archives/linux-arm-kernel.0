From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Sat, 16 Jul 2016 02:36:38 +0300
Subject: [PATCH] i2c: efm32: fix a failure path in efm32_i2c_probe()
Message-ID: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is the only failure path in efm32_i2c_probe(),
where clk_disable_unprepare() is missed.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/i2c/busses/i2c-efm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index 8eff62738877..e253598d764c 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -433,7 +433,7 @@ static int efm32_i2c_probe(struct platform_device *pdev)
 	ret = request_irq(ddata->irq, efm32_i2c_irq, 0, DRIVER_NAME, ddata);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request irq (%d)\n", ret);
-		return ret;
+		goto err_disable_clk;
 	}
 
 	ret = i2c_add_adapter(&ddata->adapter);
-- 
1.9.1
