From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:23 +0530
Subject: [PATCH V2 03/69] ST SPEAr: Padmux code Updated
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <20674433a345c48e3dde212c6b8a52e759c2abc9.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- compiling padmux only for spear3xx
- padmux initialization code rearranged in evaluation board and machine files.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/generic.h |    7 -------
 arch/arm/mach-spear3xx/spear300.c             |   14 ++++++++++----
 arch/arm/mach-spear3xx/spear300_evb.c         |    9 ++++-----
 arch/arm/mach-spear3xx/spear310.c             |   11 ++++++-----
 arch/arm/mach-spear3xx/spear310_evb.c         |    9 ++++-----
 arch/arm/mach-spear3xx/spear320.c             |   11 ++++++-----
 arch/arm/mach-spear3xx/spear320_evb.c         |    9 ++++-----
 arch/arm/mach-spear3xx/spear3xx.c             |   21 ---------------------
 arch/arm/plat-spear/Makefile                  |    4 ++--
 9 files changed, 36 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index af7e02c..c16d2f8 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -40,7 +40,6 @@ void __init clk_init(void);
 void __init spear3xx_map_io(void);
 void __init spear3xx_init_irq(void);
 void __init spear3xx_init(void);
-void spear_pmx_init(struct pmx_driver *pmx_driver, uint base, uint size);
 
 /* pad mux declarations */
 #define PMX_FIRDA_MASK		(1 << 14)
@@ -133,8 +132,6 @@ extern struct pmx_dev pmx_telecom_sdio_4bit;
 extern struct pmx_dev pmx_telecom_sdio_8bit;
 extern struct pmx_dev pmx_gpio1;
 
-void spear300_pmx_init(void);
-
 /* Add spear300 machine function declarations here */
 void __init spear300_init(void);
 
@@ -154,8 +151,6 @@ extern struct pmx_dev pmx_fsmc;
 extern struct pmx_dev pmx_rs485_0_1;
 extern struct pmx_dev pmx_tdm0;
 
-void spear310_pmx_init(void);
-
 /* Add spear310 machine function declarations here */
 void __init spear310_init(void);
 
@@ -195,8 +190,6 @@ extern struct pmx_dev pmx_smii0;
 extern struct pmx_dev pmx_smii1;
 extern struct pmx_dev pmx_i2c1;
 
-void spear320_pmx_init(void);
-
 /* Add spear320 machine function declarations here */
 void __init spear320_init(void);
 
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 3560f8c..19c2daf 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -459,10 +459,16 @@ void __init spear300_init(void)
 		if (ret)
 			printk(KERN_ERR "Error registering Shared IRQ\n");
 	}
-}
 
-void spear300_pmx_init(void)
-{
-	spear_pmx_init(&pmx_driver, SPEAR300_SOC_CONFIG_BASE,
+	/* pmx initialization */
+	pmx_driver.base = ioremap(SPEAR300_SOC_CONFIG_BASE,
 			SPEAR300_SOC_CONFIG_SIZE);
+	if (pmx_driver.base) {
+		ret = pmx_register(&pmx_driver);
+		if (ret)
+			printk(KERN_ERR "padmux: registeration failed. err no"
+					": %d\n", ret);
+		/* Free Mapping, device selection already done */
+		iounmap(pmx_driver.base);
+	}
 }
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index bb21db1..2c90663 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -51,14 +51,13 @@ static void __init spear300_evb_init(void)
 {
 	unsigned int i;
 
-	/* call spear300 machine init function */
-	spear300_init();
-
-	/* padmux initialization */
+	/* padmux initialization, must be done before spear300_init */
 	pmx_driver.mode = &photo_frame_mode;
 	pmx_driver.devs = pmx_devs;
 	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-	spear300_pmx_init();
+
+	/* call spear300 machine init function */
+	spear300_init();
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 96a1ab8..576bc57 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -293,10 +293,11 @@ void __init spear310_init(void)
 		if (ret)
 			printk(KERN_ERR "Error registering Shared IRQ 4\n");
 	}
-}
 
-void spear310_pmx_init(void)
-{
-	spear_pmx_init(&pmx_driver, SPEAR310_SOC_CONFIG_BASE,
-			SPEAR310_SOC_CONFIG_SIZE);
+	/* pmx initialization */
+	pmx_driver.base = base;
+	ret = pmx_register(&pmx_driver);
+	if (ret)
+		printk(KERN_ERR "padmux: registeration failed. err no: %d\n",
+				ret);
 }
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 7facf66..4e55e55 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -58,14 +58,13 @@ static void __init spear310_evb_init(void)
 {
 	unsigned int i;
 
-	/* call spear310 machine init function */
-	spear310_init();
-
-	/* padmux initialization */
+	/* padmux initialization, must be done before spear310_init */
 	pmx_driver.mode = NULL;
 	pmx_driver.devs = pmx_devs;
 	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-	spear310_pmx_init();
+
+	/* call spear310 machine init function */
+	spear310_init();
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 6a12195..2886bb2 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -540,10 +540,11 @@ void __init spear320_init(void)
 		if (ret)
 			printk(KERN_ERR "Error registering Shared IRQ 4\n");
 	}
-}
 
-void spear320_pmx_init(void)
-{
-	spear_pmx_init(&pmx_driver, SPEAR320_SOC_CONFIG_BASE,
-			SPEAR320_SOC_CONFIG_SIZE);
+	/* pmx initialization */
+	pmx_driver.base = base;
+	ret = pmx_register(&pmx_driver);
+	if (ret)
+		printk(KERN_ERR "padmux: registeration failed. err no: %d\n",
+				ret);
 }
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 62ac685..7083a06 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -55,14 +55,13 @@ static void __init spear320_evb_init(void)
 {
 	unsigned int i;
 
-	/* call spear320 machine init function */
-	spear320_init();
-
-	/* padmux initialization */
+	/* padmux initialization, must be done before spear320_init */
 	pmx_driver.mode = &auto_net_mii_mode;
 	pmx_driver.devs = pmx_devs;
 	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
-	spear320_pmx_init();
+
+	/* call spear320 machine init function */
+	spear320_init();
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index e87313a..efd2e17 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -525,24 +525,3 @@ struct pmx_dev pmx_plgpio_45_46_49_50 = {
 };
 
 #endif
-
-/* spear padmux initialization function */
-void spear_pmx_init(struct pmx_driver *pmx_driver, uint base, uint size)
-{
-	int ret = 0;
-
-	/* pad mux initialization */
-	pmx_driver->base = ioremap(base, size);
-	if (!pmx_driver->base) {
-		ret = -ENOMEM;
-		goto pmx_fail;
-	}
-
-	ret = pmx_register(pmx_driver);
-	iounmap(pmx_driver->base);
-
-pmx_fail:
-	if (ret)
-		printk(KERN_ERR "padmux: registeration failed. err no: %d\n",
-				ret);
-}
diff --git a/arch/arm/plat-spear/Makefile b/arch/arm/plat-spear/Makefile
index eb89540..b4f340b 100644
--- a/arch/arm/plat-spear/Makefile
+++ b/arch/arm/plat-spear/Makefile
@@ -3,6 +3,6 @@
 #
 
 # Common support
-obj-y	:= clock.o padmux.o time.o
+obj-y	:= clock.o time.o
 
-obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o
+obj-$(CONFIG_ARCH_SPEAR3XX)	+= shirq.o padmux.o
-- 
1.7.2.2
