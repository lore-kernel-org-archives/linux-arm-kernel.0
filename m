From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 03 Jun 2012 18:05:11 +0530
Subject: [PATCH v3 4/6] ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata
 function
In-Reply-To: <1338726913-18076-1-git-send-email-thomas.abraham@linaro.org>
References: <1338726913-18076-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1338726913-18076-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the spi controller hardware configuration moved into the driver data, there
are no more default hardware configuration data that is passed through platform
data. Accordingly, the s3c64xx_spi{0|1|2}_set_platdata functions are adapted to
these changes.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c            |    2 +-
 arch/arm/plat-samsung/devs.c                     |   60 ++++++++-------------
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   14 +++---
 3 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index d0c352d..6dd4fae 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -799,7 +799,7 @@ static void __init crag6410_machine_init(void)
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
 	samsung_keypad_set_platdata(&crag6410_keypad_data);
-	s3c64xx_spi0_set_platdata(&s3c64xx_spi0_pdata, 0, 1);
+	s3c64xx_spi0_set_platdata(NULL, 0, 1);
 
 	platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
 
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 1d214cb..86d0758 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1512,7 +1512,7 @@ static struct resource s3c64xx_spi0_resource[] = {
 };
 
 struct platform_device s3c64xx_device_spi0 = {
-	.name		= "s3c64xx-spi",
+	.name		= "s3c6410-spi",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s3c64xx_spi0_resource),
 	.resource	= s3c64xx_spi0_resource,
@@ -1522,13 +1522,10 @@ struct platform_device s3c64xx_device_spi0 = {
 	},
 };
 
-void __init s3c64xx_spi0_set_platdata(struct s3c64xx_spi_info *pd,
-				      int src_clk_nr, int num_cs)
+void __init s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
+						int num_cs)
 {
-	if (!pd) {
-		pr_err("%s:Need to pass platform data\n", __func__);
-		return;
-	}
+	struct s3c64xx_spi_info pd;
 
 	/* Reject invalid configuration */
 	if (!num_cs || src_clk_nr < 0) {
@@ -1536,12 +1533,11 @@ void __init s3c64xx_spi0_set_platdata(struct s3c64xx_spi_info *pd,
 		return;
 	}
 
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-	if (!pd->cfg_gpio)
-		pd->cfg_gpio = s3c64xx_spi0_cfg_gpio;
+	pd.num_cs = num_cs;
+	pd.src_clk_nr = src_clk_nr;
+	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
 
-	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi0);
+	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI0 */
 
@@ -1554,7 +1550,7 @@ static struct resource s3c64xx_spi1_resource[] = {
 };
 
 struct platform_device s3c64xx_device_spi1 = {
-	.name		= "s3c64xx-spi",
+	.name		= "s3c6410-spi",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(s3c64xx_spi1_resource),
 	.resource	= s3c64xx_spi1_resource,
@@ -1564,26 +1560,20 @@ struct platform_device s3c64xx_device_spi1 = {
 	},
 };
 
-void __init s3c64xx_spi1_set_platdata(struct s3c64xx_spi_info *pd,
-				      int src_clk_nr, int num_cs)
+void __init s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
+						int num_cs)
 {
-	if (!pd) {
-		pr_err("%s:Need to pass platform data\n", __func__);
-		return;
-	}
-
 	/* Reject invalid configuration */
 	if (!num_cs || src_clk_nr < 0) {
 		pr_err("%s: Invalid SPI configuration\n", __func__);
 		return;
 	}
 
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-	if (!pd->cfg_gpio)
-		pd->cfg_gpio = s3c64xx_spi1_cfg_gpio;
+	pd.num_cs = num_cs;
+	pd.src_clk_nr = src_clk_nr;
+	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi1_cfg_gpio;
 
-	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi1);
+	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi1);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI1 */
 
@@ -1596,7 +1586,7 @@ static struct resource s3c64xx_spi2_resource[] = {
 };
 
 struct platform_device s3c64xx_device_spi2 = {
-	.name		= "s3c64xx-spi",
+	.name		= "s3c6410-spi",
 	.id		= 2,
 	.num_resources	= ARRAY_SIZE(s3c64xx_spi2_resource),
 	.resource	= s3c64xx_spi2_resource,
@@ -1606,13 +1596,10 @@ struct platform_device s3c64xx_device_spi2 = {
 	},
 };
 
-void __init s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
-				      int src_clk_nr, int num_cs)
+void __init s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
+						int num_cs)
 {
-	if (!pd) {
-		pr_err("%s:Need to pass platform data\n", __func__);
-		return;
-	}
+	struct s3c64xx_spi_info pd;
 
 	/* Reject invalid configuration */
 	if (!num_cs || src_clk_nr < 0) {
@@ -1620,11 +1607,10 @@ void __init s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
 		return;
 	}
 
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-	if (!pd->cfg_gpio)
-		pd->cfg_gpio = s3c64xx_spi2_cfg_gpio;
+	pd.num_cs = num_cs;
+	pd.src_clk_nr = src_clk_nr;
+	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi2_cfg_gpio;
 
-	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi2);
+	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi2);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI2 */
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index 89dbaee..c818a7c 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -45,19 +45,19 @@ struct s3c64xx_spi_info {
 /**
  * s3c64xx_spi_set_platdata - SPI Controller configure callback by the board
  *				initialization code.
- * @pd: SPI platform data to set.
+ * @cfg_gpio: Pointer to gpio setup function.
  * @src_clk_nr: Clock the SPI controller is to use to generate SPI clocks.
  * @num_cs: Number of elements in the 'cs' array.
  *
  * Call this from machine init code for each SPI Controller that
  * has some chips attached to it.
  */
-extern void s3c64xx_spi0_set_platdata(struct s3c64xx_spi_info *pd,
-				      int src_clk_nr, int num_cs);
-extern void s3c64xx_spi1_set_platdata(struct s3c64xx_spi_info *pd,
-				      int src_clk_nr, int num_cs);
-extern void s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
-				      int src_clk_nr, int num_cs);
+extern void s3c64xx_spi0_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
+						int num_cs);
+extern void s3c64xx_spi1_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
+						int num_cs);
+extern void s3c64xx_spi2_set_platdata(int (*cfg_gpio)(void), int src_clk_nr,
+						int num_cs);
 
 /* defined by architecture to configure gpio */
 extern int s3c64xx_spi0_cfg_gpio(void);
-- 
1.6.6.rc2
