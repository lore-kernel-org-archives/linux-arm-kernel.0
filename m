From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:50:49 +0900
Subject: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare I2C
	clock source
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EB09.8050304@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is originally prepared for the ARM kernel where rich and
well-maintained "clkdev" clock framework is available, and clock name
might not be strictly required.  ARM's clkdev does slightly fuzzy
matching where it basically gives preference to "struct device" mathing
over "clock id".  As long as used for ARM machines, there's no problem.

However, all users of this driver necessarily don't have the same clk
framework with ARM's, as the clk I/F implementation varies depending on
ARCHs and machines.

This patch adds a clock name so that other users with simple/minimum/
limited clk support could make use of the driver.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index 9d81775..0f8bd4c 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -575,7 +575,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
-	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->clk = clk_get(&pdev->dev, "dw_i2c_clk");
 	if (IS_ERR(dev->clk)) {
 		r = -ENODEV;
 		goto err_free_mem;
-- 
1.6.5
