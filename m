From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:56:38 +0530
Subject: [PATCH V5 60/63] ST SPEAr13xx: Pass default padmux settings as
	parameter to spear13**_init routine
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <a5bbc89239f9f71d137ab25e9ac58e2eeb1a85f6.1295499395.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes pmx_driver static to spear1300.c and spear1310.c, also now
default setting of padmux are sent to spear1300_init and spear1310_init routines

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    8 ++++----
 arch/arm/mach-spear13xx/spear1300.c            |    9 +++++++--
 arch/arm/mach-spear13xx/spear1300_evb.c        |    7 +------
 arch/arm/mach-spear13xx/spear1310.c            |    9 +++++++--
 arch/arm/mach-spear13xx/spear1310_evb.c        |    7 +------
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 0551850..768759a 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -220,8 +220,6 @@ extern struct pmx_dev pmx_uart1_modem;
 #define SPEAR_GPT0_CHAN0_IRQ	IRQ_GPT0_TMR0
 #define SPEAR_GPT0_CHAN1_IRQ	IRQ_GPT0_TMR1
 
-extern struct pmx_driver pmx_driver;
-
 /* Add spear13xx family device structure declarations here */
 extern struct amba_device spear13xx_gpio_device[];
 extern struct amba_device spear13xx_ssp_device;
@@ -250,7 +248,8 @@ void spear13xx_secondary_startup(void);
 /* spear1300 declarations */
 #ifdef CONFIG_MACH_SPEAR1300
 /* Add spear1300 machine function declarations here */
-void __init spear1300_init(void);
+void __init spear1300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count);
 
 #endif /* CONFIG_MACH_SPEAR1300 */
 
@@ -261,7 +260,8 @@ extern struct platform_device spear1310_can0_device;
 extern struct platform_device spear1310_can1_device;
 
 /* Add spear1310 machine function declarations here */
-void __init spear1310_init(void);
+void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count);
 void __init spear1310_map_io(void);
 
 #endif /* CONFIG_MACH_SPEAR1310 */
diff --git a/arch/arm/mach-spear13xx/spear1300.c b/arch/arm/mach-spear13xx/spear1300.c
index 28822a3..b10f7a0 100644
--- a/arch/arm/mach-spear13xx/spear1300.c
+++ b/arch/arm/mach-spear13xx/spear1300.c
@@ -15,11 +15,12 @@
 #include <mach/spear.h>
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver;
+static struct pmx_driver pmx_driver;
 
 /* Add spear1300 specific devices here */
 
-void __init spear1300_init(void)
+void __init spear1300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count)
 {
 	int ret;
 
@@ -27,6 +28,10 @@ void __init spear1300_init(void)
 	spear13xx_init();
 
 	/* pmx initialization */
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
+
 	ret = pmx_register(&pmx_driver);
 	if (ret)
 		pr_err("padmux: registeration failed. err no: %d\n", ret);
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index c361e0f..a4f7bc4 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -107,11 +107,6 @@ static void __init spear1300_evb_init(void)
 {
 	unsigned int i;
 
-	/* padmux initialization, must be done before spear1300_init */
-	pmx_driver.mode = NULL;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-
 	/* set keyboard plat data */
 	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
 
@@ -121,7 +116,7 @@ static void __init spear1300_evb_init(void)
 	nand_mach_init(FSMC_NAND_BW8);
 
 	/* call spear1300 machine init function */
-	spear1300_init();
+	spear1300_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index db9bbdb..4f8ba02 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -17,7 +17,7 @@
 #include <mach/hardware.h>
 
 /* pmx driver structure */
-struct pmx_driver pmx_driver;
+static struct pmx_driver pmx_driver;
 
 /* Pad multiplexing for uart1_modem device */
 static struct pmx_mux_reg pmx_uart1_modem_mux[] = {
@@ -410,7 +410,8 @@ void __init spear1310_map_io(void)
 	iotable_init(spear1310_io_desc, ARRAY_SIZE(spear1310_io_desc));
 }
 
-void __init spear1310_init(void)
+void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
+		u8 pmx_dev_count)
 {
 	int ret;
 
@@ -418,6 +419,10 @@ void __init spear1310_init(void)
 	spear13xx_init();
 
 	/* pmx initialization */
+	pmx_driver.mode = pmx_mode;
+	pmx_driver.devs = pmx_devs;
+	pmx_driver.devs_count = pmx_dev_count;
+
 	ret = pmx_register(&pmx_driver);
 	if (ret)
 		pr_err("padmux: registeration failed. err no: %d\n", ret);
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index b4faff4..ca200dd 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -119,11 +119,6 @@ static void __init spear1310_evb_init(void)
 {
 	unsigned int i;
 
-	/* padmux initialization, must be done before spear1300_init */
-	pmx_driver.mode = NULL;
-	pmx_driver.devs = pmx_devs;
-	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-
 	/* set keyboard plat data */
 	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
 
@@ -133,7 +128,7 @@ static void __init spear1310_evb_init(void)
 	nand_mach_init(FSMC_NAND_BW8);
 
 	/* call spear1310 machine init function */
-	spear1310_init();
+	spear1310_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
-- 
1.7.3.4
