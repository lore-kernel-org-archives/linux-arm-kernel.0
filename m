From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 22 Dec 2009 00:23:03 +0100
Subject: [PATCH 9/10] ARM: PNX4008: convert i2c-pnx to use clk API
	enable/disable calls
Message-ID: <083DF309106F364B939360100EC290F804F592E909@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/mach-pnx4008/clock.c |   12 ++++++------
 drivers/i2c/busses/i2c-pnx.c  |   18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index 1ad9a9e..3f6b681 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -640,30 +640,30 @@ static struct clk i2c0_ck = {
 	.name = "i2c0_ck",
 	.parent = &per_ck,
 	.flags = NEEDS_INITIALIZATION,
-	.round_rate = &on_off_round_rate,
-	.set_rate = &on_off_set_rate,
 	.enable_shift = 0,
 	.enable_reg = I2CCLKCTRL_REG,
+	.enable = clk_reg_enable,
+	.disable = clk_reg_disable,
 };
 
 static struct clk i2c1_ck = {
 	.name = "i2c1_ck",
 	.parent = &per_ck,
 	.flags = NEEDS_INITIALIZATION,
-	.round_rate = &on_off_round_rate,
-	.set_rate = &on_off_set_rate,
 	.enable_shift = 1,
 	.enable_reg = I2CCLKCTRL_REG,
+	.enable = clk_reg_enable,
+	.disable = clk_reg_disable,
 };
 
 static struct clk i2c2_ck = {
 	.name = "i2c2_ck",
 	.parent = &per_ck,
 	.flags = NEEDS_INITIALIZATION,
-	.round_rate = &on_off_round_rate,
-	.set_rate = &on_off_set_rate,
 	.enable_shift = 2,
 	.enable_reg = USB_OTG_CLKCTRL_REG,
+	.enable = clk_reg_enable,
+	.disable = clk_reg_disable,
 };
 
 static struct clk spi0_ck = {
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index c4df21c..7ed425a 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -555,8 +555,8 @@ static int i2c_pnx_controller_suspend(struct platform_device *pdev,
 	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
 	struct i2c_pnx_algo_data *alg_data = i2c_pnx->adapter->algo_data;
 
-	/* FIXME: disable clock? */
-	clk_set_rate(alg_data->clk, 1);
+	/* FIXME: shouldn't this be clk_disable? */
+	clk_enable(alg_data->clk);
 
 	return 0;
 }
@@ -566,9 +566,7 @@ static int i2c_pnx_controller_resume(struct platform_device *pdev)
 	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
 	struct i2c_pnx_algo_data *alg_data = i2c_pnx->adapter->algo_data;
 
-	clk_set_rate(alg_data->clk, 1);
-
-	return 0;
+	return clk_enable(alg_data->clk);
 }
 #else
 #define i2c_pnx_controller_suspend	NULL
@@ -630,7 +628,9 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 		goto out_release;
 	}
 
-	clk_set_rate(alg_data->clk, 1);
+	ret = clk_enable(alg_data->clk);
+	if (ret)
+		goto out_unmap;
 
 	/*
 	 * Clock Divisor High This value is the number of system clocks
@@ -650,7 +650,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 	iowrite32(mcntrl_reset, I2C_REG_CTL(alg_data));
 	if (wait_reset(I2C_PNX_TIMEOUT, alg_data)) {
 		ret = -ENODEV;
-		goto out_unmap;
+		goto out_clock;
 	}
 	init_completion(&alg_data->mif.complete);
 
@@ -676,7 +676,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 out_irq:
 	free_irq(alg_data->irq, i2c_pnx->adapter);
 out_clock:
-	clk_set_rate(alg_data->clk, 0);
+	clk_disable(alg_data->clk);
 out_unmap:
 	iounmap((void *)alg_data->ioaddr);
 out_release:
@@ -697,7 +697,7 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
 
 	free_irq(alg_data->irq, i2c_pnx->adapter);
 	i2c_del_adapter(adap);
-	clk_set_rate(alg_data->clk, 0);
+	clk_disable(alg_data->clk);
 	iounmap((void *)alg_data->ioaddr);
 	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
 	clk_put(alg_data->clk);
-- 
1.6.0.6
