From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 16 Aug 2017 17:17:13 -0500
Subject: [PATCH v2 1/3] i2c: davinci: Preserve return value of devm_clk_get
In-Reply-To: <20170816221715.15027-1-fcooper@ti.com>
References: <20170816221715.15027-1-fcooper@ti.com>
Message-ID: <20170816221715.15027-2-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c driver can run into driver dependency issues if its loaded
before a clock driver it depends on. Therefore, EPROBE_DEFER may be
returned by devm_clk_get and should be returned in probe to allow the
kernel to reprobe the driver at a later time. This patch allows the error
value returned by devm_clk_get to be passed through and not overwritten.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/i2c/busses/i2c-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 33ca9a3..b8c4353 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -801,7 +801,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
-		return -ENODEV;
+		return PTR_ERR(dev->clk);
 	clk_prepare_enable(dev->clk);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.9.4.dirty
