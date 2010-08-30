From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:59 +0530
Subject: [PATCH 35/74] ST SPEAr: Enabling clocks before amba device
	registeration
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <96b4972a92cab5025a89bd71a4e23fa29aa41cba.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |    5 +--
 arch/arm/mach-spear3xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear3xx/spear300_evb.c          |    7 +---
 arch/arm/mach-spear3xx/spear310_evb.c          |    7 +---
 arch/arm/mach-spear3xx/spear320_evb.c          |    7 +---
 arch/arm/mach-spear6xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear6xx/spear600_evb.c          |    7 +---
 arch/arm/plat-spear/include/plat/device.h      |   37 ++++++++++++++++++++++++
 9 files changed, 49 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/plat-spear/include/plat/device.h

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index a09bf62..18800b0 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
+#include <plat/device.h>
 
 /*
  * Each GPT has 2 timer channels
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index aed4bba..db05747 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -121,8 +121,6 @@ static int spear1300_pcie_port_is_host(int port)
 
 static void __init spear1300_evb_init(void)
 {
-	unsigned int i;
-
 	/* set keyboard plat data */
 	kbd_set_plat_data(&kbd_device, &kbd_data);
 
@@ -150,8 +148,7 @@ static void __init spear1300_evb_init(void)
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
 	/* Add Amba Devices */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
+	spear_amba_device_register(amba_devs, ARRAY_SIZE(amba_devs));
 
 	spi_init();
 }
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index 9bd9424..ddfc382 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
+#include <plat/device.h>
 #include <plat/padmux.h>
 
 /* spear3xx declarations */
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index d6eb2a7..1bcbd95 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -11,9 +11,9 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/mtd/nand.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/mtd/nand.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 #include <linux/mmc/sdhci-spear.h>
@@ -130,8 +130,6 @@ static void __init spi_init(void)
 
 static void __init spear300_evb_init(void)
 {
-	unsigned int i;
-
 	/* padmux initialization, must be done before spear300_init */
 	pmx_driver.mode = &photo_frame_mode;
 	pmx_driver.devs = pmx_devs;
@@ -163,8 +161,7 @@ static void __init spear300_evb_init(void)
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
 	/* Add Amba Devices */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
+	spear_amba_device_register(amba_devs, ARRAY_SIZE(amba_devs));
 
 	spi_init();
 }
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 663e78e..612eb04 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -11,9 +11,9 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/mtd/nand.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/mtd/nand.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
 #include <mach/generic.h>
@@ -108,8 +108,6 @@ static void __init spi_init(void)
 
 static void __init spear310_evb_init(void)
 {
-	unsigned int i;
-
 	/* padmux initialization, must be done before spear310_init */
 	pmx_driver.mode = NULL;
 	pmx_driver.devs = pmx_devs;
@@ -132,8 +130,7 @@ static void __init spear310_evb_init(void)
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
 	/* Add Amba Devices */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
+	spear_amba_device_register(amba_devs, ARRAY_SIZE(amba_devs));
 
 	spi_init();
 }
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index 52f3b75..261c0b0 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -11,9 +11,9 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/mtd/nand.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/mtd/nand.h>
 #include <linux/spi/flash.h>
 #include <linux/mmc/sdhci-spear.h>
 #include <linux/spi/spi.h>
@@ -122,8 +122,6 @@ static void __init spi_init(void)
 
 static void __init spear320_evb_init(void)
 {
-	unsigned int i;
-
 	/* set sdhci device platform data */
 	sdhci_set_plat_data(&sdhci_device, &sdhci_plat_data);
 
@@ -149,8 +147,7 @@ static void __init spear320_evb_init(void)
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
 	/* Add Amba Devices */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
+	spear_amba_device_register(amba_devs, ARRAY_SIZE(amba_devs));
 
 	spi_init();
 }
diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
index dd29298..b33e436 100644
--- a/arch/arm/mach-spear6xx/include/mach/generic.h
+++ b/arch/arm/mach-spear6xx/include/mach/generic.h
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
+#include <plat/device.h>
 
 /*
  * Each GPT has 2 timer channels
diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
index ae1055a..b03e761 100644
--- a/arch/arm/mach-spear6xx/spear600_evb.c
+++ b/arch/arm/mach-spear6xx/spear600_evb.c
@@ -11,9 +11,9 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/mtd/nand.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <linux/mtd/nand.h>
 #include <linux/gpio.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
@@ -91,8 +91,6 @@ static void __init spi_init(void)
 
 static void __init spear600_evb_init(void)
 {
-	unsigned int i;
-
 	/* set nand device's plat data */
 	nand_set_plat_data(&nand_device, NULL, 0, NAND_SKIP_BBTSCAN,
 			SPEAR_NAND_BW8);
@@ -110,8 +108,7 @@ static void __init spear600_evb_init(void)
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
 	/* Add Amba Devices */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
+	spear_amba_device_register(amba_devs, ARRAY_SIZE(amba_devs));
 
 	spi_init();
 }
diff --git a/arch/arm/plat-spear/include/plat/device.h b/arch/arm/plat-spear/include/plat/device.h
new file mode 100644
index 0000000..008581b
--- /dev/null
+++ b/arch/arm/plat-spear/include/plat/device.h
@@ -0,0 +1,37 @@
+/*
+ * arch/arm/plat-spear/include/plat/device.h
+ *
+ * device definitions for SPEAr platform
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PLAT_DEVICE_H
+#define __PLAT_DEVICE_H
+
+#include <linux/amba/bus.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+
+static inline void
+spear_amba_device_register(struct amba_device **devices, u32 count)
+{
+	u32 i;
+
+	for (i = 0; i < count; i++) {
+		struct clk *clk = clk_get_sys(devices[i]->dev.init_name, NULL);
+		if (IS_ERR(clk))
+			continue;
+
+		clk_enable(clk);
+		amba_device_register(devices[i], &iomem_resource);
+		clk_disable(clk);
+	}
+}
+
+#endif /* __PLAT_DEVICE_H */
-- 
1.7.2.2
