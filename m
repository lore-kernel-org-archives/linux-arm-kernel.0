From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 09 May 2012 03:34:50 +0530
Subject: [PATCH 06/10] ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata
 function
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the spi controller hardware configuration moved into the driver data, there
are no more default hardware configuration data that is passed through platform
data. Accordingly, the s3c64xx_spi{0|1|2}_set_platdata functions are adapted to
these changes.

Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c            |    2 +-
 arch/arm/plat-samsung/devs.c                     |   50 ++++++++-------------
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    6 +-
 3 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index e20bf58..0cea12f 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -793,7 +793,7 @@ static void __init crag6410_machine_init(void)
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
 	samsung_keypad_set_platdata(&crag6410_keypad_data);
-	s3c64xx_spi0_set_platdata(&s3c64xx_spi0_pdata, 0, 1);
+	s3c64xx_spi0_set_platdata("s3c6410-spi", NULL, 0, 1);
 
 	platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
 
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 8b928f9..2deabda 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1534,13 +1534,10 @@ struct platform_device s3c64xx_device_spi0 = {
 	},
 };
 
-void __init s3c64xx_spi0_set_platdata(struct s3c64xx_spi_info *pd,
+void __init s3c64xx_spi0_set_platdata(char *dev_name, int (*cfg_gpio)(void),
 				      int src_clk_nr, int num_cs)
 {
-	if (!pd) {
-		pr_err("%s:Need to pass platform data\n", __func__);
-		return;
-	}
+	struct s3c64xx_spi_info pd;
 
 	/* Reject invalid configuration */
 	if (!num_cs || src_clk_nr < 0) {
@@ -1548,12 +1545,11 @@ void __init s3c64xx_spi0_set_platdata(struct s3c64xx_spi_info *pd,
 		return;
 	}
 
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-	if (!pd->cfg_gpio)
-		pd->cfg_gpio = s3c64xx_spi0_cfg_gpio;
+	pd.src_clk_nr = src_clk_nr;
+	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
+	s3c64xx_device_spi0.name = dev_name;
 
-	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi0);
+	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI0 */
 
@@ -1576,26 +1572,21 @@ struct platform_device s3c64xx_device_spi1 = {
 	},
 };
 
-void __init s3c64xx_spi1_set_platdata(struct s3c64xx_spi_info *pd,
+void __init s3c64xx_spi1_set_platdata(char *dev_name, int (*cfg_gpio)(void),
 				      int src_clk_nr, int num_cs)
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
+	s3c64xx_device_spi1.name = dev_name;
 
-	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi1);
+	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi1);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI1 */
 
@@ -1618,13 +1609,10 @@ struct platform_device s3c64xx_device_spi2 = {
 	},
 };
 
-void __init s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
+void __init s3c64xx_spi2_set_platdata(char *dev_name, int (*cfg_gpio)(void),
 				      int src_clk_nr, int num_cs)
 {
-	if (!pd) {
-		pr_err("%s:Need to pass platform data\n", __func__);
-		return;
-	}
+	struct s3c64xx_spi_info pd;
 
 	/* Reject invalid configuration */
 	if (!num_cs || src_clk_nr < 0) {
@@ -1632,11 +1620,11 @@ void __init s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
 		return;
 	}
 
-	pd->num_cs = num_cs;
-	pd->src_clk_nr = src_clk_nr;
-	if (!pd->cfg_gpio)
-		pd->cfg_gpio = s3c64xx_spi2_cfg_gpio;
+	pd.num_cs = num_cs;
+	pd.src_clk_nr = src_clk_nr;
+	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi2_cfg_gpio;
+	s3c64xx_device_spi2.name = dev_name;
 
-	s3c_set_platdata(pd, sizeof(*pd), &s3c64xx_device_spi2);
+	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi2);
 }
 #endif /* CONFIG_S3C64XX_DEV_SPI2 */
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index 89dbaee..a733ce9 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -52,11 +52,11 @@ struct s3c64xx_spi_info {
  * Call this from machine init code for each SPI Controller that
  * has some chips attached to it.
  */
-extern void s3c64xx_spi0_set_platdata(struct s3c64xx_spi_info *pd,
+extern void s3c64xx_spi0_set_platdata(char *dev_name, int (*cfg_gpio)(void),
 				      int src_clk_nr, int num_cs);
-extern void s3c64xx_spi1_set_platdata(struct s3c64xx_spi_info *pd,
+extern void s3c64xx_spi1_set_platdata(char *dev_name, int (*cfg_gpio)(void),
 				      int src_clk_nr, int num_cs);
-extern void s3c64xx_spi2_set_platdata(struct s3c64xx_spi_info *pd,
+extern void s3c64xx_spi2_set_platdata(char *dev_name, int (*cfg_gpio)(void),
 				      int src_clk_nr, int num_cs);
 
 /* defined by architecture to configure gpio */
-- 
1.6.6.rc2
