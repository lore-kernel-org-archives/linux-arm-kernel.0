From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 22 Dec 2009 00:22:53 +0100
Subject: [PATCH 8/10] ARM: PNX4008: move i2c suspend/resume callbacks into
	driver[PATCH] ARM: PNX4008: move i2c clock start/stop into driver
Message-ID: <083DF309106F364B939360100EC290F804F592E908@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/mach-pnx4008/i2c.c  |   36 ------------------------------------
 drivers/i2c/busses/i2c-pnx.c |   39 ++++++++++++++++++++++++++++++---------
 include/linux/i2c-pnx.h      |    4 ++--
 3 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-pnx4008/i2c.c b/arch/arm/mach-pnx4008/i2c.c
index 707d819..14b4906 100644
--- a/arch/arm/mach-pnx4008/i2c.c
+++ b/arch/arm/mach-pnx4008/i2c.c
@@ -18,36 +18,6 @@
 #include <mach/irqs.h>
 #include <mach/i2c.h>
 
-static int set_clock_run(struct platform_device *pdev)
-{
-	struct clk *clk;
-	int retval = 0;
-
-	clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(clk)) {
-		clk_set_rate(clk, 1);
-		clk_put(clk);
-	} else
-		retval = -ENOENT;
-
-	return retval;
-}
-
-static int set_clock_stop(struct platform_device *pdev)
-{
-	struct clk *clk;
-	int retval = 0;
-
-	clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(clk)) {
-		clk_set_rate(clk, 0);
-		clk_put(clk);
-	} else
-		retval = -ENOENT;
-
-	return retval;
-}
-
 static u32 calculate_input_freq(struct platform_device *pdev)
 {
 	return HCLK_MHZ;
@@ -85,22 +55,16 @@ static struct i2c_adapter pnx_adapter2 = {
 
 static struct i2c_pnx_data i2c0_data = {
 	.calculate_input_freq = calculate_input_freq,
-	.set_clock_run = set_clock_run,
-	.set_clock_stop = set_clock_stop,
 	.adapter = &pnx_adapter0,
 };
 
 static struct i2c_pnx_data i2c1_data = {
 	.calculate_input_freq = calculate_input_freq,
-	.set_clock_run = set_clock_run,
-	.set_clock_stop = set_clock_stop,
 	.adapter = &pnx_adapter1,
 };
 
 static struct i2c_pnx_data i2c2_data = {
 	.calculate_input_freq = calculate_input_freq,
-	.set_clock_run = set_clock_run,
-	.set_clock_stop = set_clock_stop,
 	.adapter = &pnx_adapter2,
 };
 
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index faf4bb6..c4df21c 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -20,6 +20,9 @@
 #include <linux/platform_device.h>
 #include <linux/i2c-pnx.h>
 #include <linux/io.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+
 #include <mach/hardware.h>
 #include <mach/i2c.h>
 #include <asm/irq.h>
@@ -550,13 +553,22 @@ static int i2c_pnx_controller_suspend(struct platform_device *pdev,
 				      pm_message_t state)
 {
 	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
-	return i2c_pnx->set_clock_run(pdev);
+	struct i2c_pnx_algo_data *alg_data = i2c_pnx->adapter->algo_data;
+
+	/* FIXME: disable clock? */
+	clk_set_rate(alg_data->clk, 1);
+
+	return 0;
 }
 
 static int i2c_pnx_controller_resume(struct platform_device *pdev)
 {
 	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
-	return i2c_pnx->set_clock_run(pdev);
+	struct i2c_pnx_algo_data *alg_data = i2c_pnx->adapter->algo_data;
+
+	clk_set_rate(alg_data->clk, 1);
+
+	return 0;
 }
 #else
 #define i2c_pnx_controller_suspend	NULL
@@ -580,6 +592,15 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c_pnx);
 
+	i2c_pnx->adapter->algo = &pnx_algorithm;
+	alg_data = i2c_pnx->adapter->algo_data;
+
+	alg_data->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(alg_data->clk)) {
+		ret = PTR_ERR(alg_data->clk);
+		goto out_drvdata;
+	}
+
 	if (i2c_pnx->calculate_input_freq)
 		freq_mhz = i2c_pnx->calculate_input_freq(pdev);
 	else {
@@ -588,9 +609,6 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 		       "%d MHz\n", freq_mhz);
 	}
 
-	i2c_pnx->adapter->algo = &pnx_algorithm;
-
-	alg_data = i2c_pnx->adapter->algo_data;
 	init_timer(&alg_data->mif.timer);
 	alg_data->mif.timer.function = i2c_pnx_timeout;
 	alg_data->mif.timer.data = (unsigned long)i2c_pnx->adapter;
@@ -602,7 +620,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 		       "I/O region 0x%08x for I2C already in use.\n",
 		       alg_data->base);
 		ret = -ENODEV;
-		goto out_drvdata;
+		goto out_clkget;
 	}
 
 	if (!(alg_data->ioaddr =
@@ -612,7 +630,7 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 		goto out_release;
 	}
 
-	i2c_pnx->set_clock_run(pdev);
+	clk_set_rate(alg_data->clk, 1);
 
 	/*
 	 * Clock Divisor High This value is the number of system clocks
@@ -658,11 +676,13 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 out_irq:
 	free_irq(alg_data->irq, i2c_pnx->adapter);
 out_clock:
-	i2c_pnx->set_clock_stop(pdev);
+	clk_set_rate(alg_data->clk, 0);
 out_unmap:
 	iounmap((void *)alg_data->ioaddr);
 out_release:
 	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
+out_clkget:
+	clk_put(alg_data->clk);
 out_drvdata:
 	platform_set_drvdata(pdev, NULL);
 out:
@@ -677,9 +697,10 @@ static int __devexit i2c_pnx_remove(struct platform_device *pdev)
 
 	free_irq(alg_data->irq, i2c_pnx->adapter);
 	i2c_del_adapter(adap);
-	i2c_pnx->set_clock_stop(pdev);
+	clk_set_rate(alg_data->clk, 0);
 	iounmap((void *)alg_data->ioaddr);
 	release_mem_region(alg_data->base, I2C_PNX_REGION_SIZE);
+	clk_put(alg_data->clk);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
diff --git a/include/linux/i2c-pnx.h b/include/linux/i2c-pnx.h
index 71de7f9..3a69306 100644
--- a/include/linux/i2c-pnx.h
+++ b/include/linux/i2c-pnx.h
@@ -13,6 +13,7 @@
 #define __I2C_PNX_H__
 
 struct platform_device;
+struct clk;
 
 struct i2c_pnx_mif {
 	int			ret;		/* Return value */
@@ -29,12 +30,11 @@ struct i2c_pnx_algo_data {
 	int			irq;
 	struct i2c_pnx_mif	mif;
 	int			last;
+	struct clk		*clk;
 };
 
 struct i2c_pnx_data {
 	u32 (*calculate_input_freq) (struct platform_device *pdev);
-	int (*set_clock_run) (struct platform_device *pdev);
-	int (*set_clock_stop) (struct platform_device *pdev);
 	struct i2c_adapter *adapter;
 };
 
-- 
1.6.0.6
