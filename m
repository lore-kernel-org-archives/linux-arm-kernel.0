From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:20:37 +0000
Subject: [PATCH 07/18] ARM: PNX4008: move i2c suspend/resume callbacks into
	driver
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <6201dacc2ba49c99cf7c6b9f04ceceecd9c136cd.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Vitaly Wool <vitalywool@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pnx4008/i2c.c  |   24 ------------------------
 drivers/i2c/busses/i2c-pnx.c |    9 +++++++--
 include/linux/i2c-pnx.h      |    4 ----
 3 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-pnx4008/i2c.c b/arch/arm/mach-pnx4008/i2c.c
index c986b3a..707d819 100644
--- a/arch/arm/mach-pnx4008/i2c.c
+++ b/arch/arm/mach-pnx4008/i2c.c
@@ -48,24 +48,6 @@ static int set_clock_stop(struct platform_device *pdev)
 	return retval;
 }
 
-static int i2c_pnx_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	int retval = 0;
-#ifdef CONFIG_PM
-	retval = set_clock_run(pdev);
-#endif
-	return retval;
-}
-
-static int i2c_pnx_resume(struct platform_device *pdev)
-{
-	int retval = 0;
-#ifdef CONFIG_PM
-	retval = set_clock_run(pdev);
-#endif
-	return retval;
-}
-
 static u32 calculate_input_freq(struct platform_device *pdev)
 {
 	return HCLK_MHZ;
@@ -102,8 +84,6 @@ static struct i2c_adapter pnx_adapter2 = {
 };
 
 static struct i2c_pnx_data i2c0_data = {
-	.suspend = i2c_pnx_suspend,
-	.resume = i2c_pnx_resume,
 	.calculate_input_freq = calculate_input_freq,
 	.set_clock_run = set_clock_run,
 	.set_clock_stop = set_clock_stop,
@@ -111,8 +91,6 @@ static struct i2c_pnx_data i2c0_data = {
 };
 
 static struct i2c_pnx_data i2c1_data = {
-	.suspend = i2c_pnx_suspend,
-	.resume = i2c_pnx_resume,
 	.calculate_input_freq = calculate_input_freq,
 	.set_clock_run = set_clock_run,
 	.set_clock_stop = set_clock_stop,
@@ -120,8 +98,6 @@ static struct i2c_pnx_data i2c1_data = {
 };
 
 static struct i2c_pnx_data i2c2_data = {
-	.suspend = i2c_pnx_suspend,
-	.resume = i2c_pnx_resume,
 	.calculate_input_freq = calculate_input_freq,
 	.set_clock_run = set_clock_run,
 	.set_clock_stop = set_clock_stop,
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 5d1c260..bc80755 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -545,18 +545,23 @@ static struct i2c_algorithm pnx_algorithm = {
 	.functionality = i2c_pnx_func,
 };
 
+#ifdef CONFIG_PM
 static int i2c_pnx_controller_suspend(struct platform_device *pdev,
 				      pm_message_t state)
 {
 	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
-	return i2c_pnx->suspend(pdev, state);
+	return i2c_pnx->set_clock_run(pdev);
 }
 
 static int i2c_pnx_controller_resume(struct platform_device *pdev)
 {
 	struct i2c_pnx_data *i2c_pnx = platform_get_drvdata(pdev);
-	return i2c_pnx->resume(pdev);
+	return i2c_pnx->set_clock_run(pdev);
 }
+#else
+#define i2c_pnx_controller_suspend	NULL
+#define i2c_pnx_controller_resume	NULL
+#endif
 
 static int __devinit i2c_pnx_probe(struct platform_device *pdev)
 {
diff --git a/include/linux/i2c-pnx.h b/include/linux/i2c-pnx.h
index 9eb07bb..71de7f9 100644
--- a/include/linux/i2c-pnx.h
+++ b/include/linux/i2c-pnx.h
@@ -12,8 +12,6 @@
 #ifndef __I2C_PNX_H__
 #define __I2C_PNX_H__
 
-#include <linux/pm.h>
-
 struct platform_device;
 
 struct i2c_pnx_mif {
@@ -34,8 +32,6 @@ struct i2c_pnx_algo_data {
 };
 
 struct i2c_pnx_data {
-	int (*suspend) (struct platform_device *pdev, pm_message_t state);
-	int (*resume) (struct platform_device *pdev);
 	u32 (*calculate_input_freq) (struct platform_device *pdev);
 	int (*set_clock_run) (struct platform_device *pdev);
 	int (*set_clock_stop) (struct platform_device *pdev);
-- 
1.6.2.5
