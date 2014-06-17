From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 17 Jun 2014 16:47:45 +0900
Subject: [PATCH v2 06/08] ARM: shmobile: Move pm-rmobile.h, cleanup sh73xx.h
In-Reply-To: <20140617074658.30008.53021.sendpatchset@w520>
References: <20140617074658.30008.53021.sendpatchset@w520>
Message-ID: <20140617074745.30008.34580.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Change location of pm-rmobile.h so it can be used as #include "pm-rmobile.h"
instead of the old style #include <mach/pm-rmobile.h>. Also clean up
the sh7372 and sh73a0 header files to get rid of unused include files.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

 Changes since V1:
 - rebased to v3.16-rc1

 arch/arm/mach-shmobile/board-armadillo800eva.c   |    1 
 arch/arm/mach-shmobile/board-mackerel.c          |    2 
 arch/arm/mach-shmobile/include/mach/pm-rmobile.h |   63 ----------------------
 arch/arm/mach-shmobile/include/mach/r8a7740.h    |    2 
 arch/arm/mach-shmobile/include/mach/sh7372.h     |    4 -
 arch/arm/mach-shmobile/pm-r8a7740.c              |    2 
 arch/arm/mach-shmobile/pm-rmobile.c              |    2 
 arch/arm/mach-shmobile/pm-rmobile.h              |   63 ++++++++++++++++++++++
 arch/arm/mach-shmobile/pm-sh7372.c               |    2 
 arch/arm/mach-shmobile/setup-r8a7740.c           |    2 
 arch/arm/mach-shmobile/setup-sh7372.c            |    1 
 11 files changed, 71 insertions(+), 73 deletions(-)

--- 0006/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ work/arch/arm/mach-shmobile/board-armadillo800eva.c	2014-06-17 16:09:25.000000000 +0900
@@ -61,6 +61,7 @@
 #include <sound/simple_card.h>
 #include "common.h"
 #include "irqs.h"
+#include "pm-rmobile.h"
 #include "sh-gpio.h"
 
 /*
--- 0006/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2014-06-17 16:09:25.000000000 +0900
@@ -47,6 +47,7 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
+#include <linux/sh_clk.h>
 #include <linux/tca6416_keypad.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/dma-mapping.h>
@@ -62,6 +63,7 @@
 #include <asm/mach-types.h>
 #include "common.h"
 #include "irqs.h"
+#include "pm-rmobile.h"
 #include "sh-gpio.h"
 
 /*
--- 0001/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1,63 +0,0 @@
-/*
- * Copyright (C) 2012 Renesas Solutions Corp.
- *
- * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#ifndef PM_RMOBILE_H
-#define PM_RMOBILE_H
-
-#include <linux/pm_domain.h>
-
-#define DEFAULT_DEV_LATENCY_NS	250000
-
-struct platform_device;
-
-struct rmobile_pm_domain {
-	struct generic_pm_domain genpd;
-	struct dev_power_governor *gov;
-	int (*suspend)(void);
-	void (*resume)(void);
-	unsigned int bit_shift;
-	bool no_debug;
-};
-
-static inline
-struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
-{
-	return container_of(d, struct rmobile_pm_domain, genpd);
-}
-
-struct pm_domain_device {
-	const char *domain_name;
-	struct platform_device *pdev;
-};
-
-#ifdef CONFIG_PM
-extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
-extern void rmobile_add_device_to_domain_td(const char *domain_name,
-					    struct platform_device *pdev,
-					    struct gpd_timing_data *td);
-
-static inline void rmobile_add_device_to_domain(const char *domain_name,
-						struct platform_device *pdev)
-{
-	rmobile_add_device_to_domain_td(domain_name, pdev, NULL);
-}
-
-extern void rmobile_add_devices_to_domains(struct pm_domain_device data[],
-					   int size);
-#else
-
-#define rmobile_init_domains(domains, num) do { } while (0)
-#define rmobile_add_device_to_domain_td(name, pdev, td) do { } while (0)
-#define rmobile_add_device_to_domain(name, pdev) do { } while (0)
-
-static inline void rmobile_add_devices_to_domains(struct pm_domain_device d[],
-						  int size) {}
-#endif /* CONFIG_PM */
-
-#endif /* PM_RMOBILE_H */
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7740.h	2014-06-17 16:09:25.000000000 +0900
@@ -19,8 +19,6 @@
 #ifndef __ASM_R8A7740_H__
 #define __ASM_R8A7740_H__
 
-#include <mach/pm-rmobile.h>
-
 /*
  * MD_CKx pin
  */
--- 0001/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2014-06-17 16:09:25.000000000 +0900
@@ -11,10 +11,6 @@
 #ifndef __ASM_SH7372_H__
 #define __ASM_SH7372_H__
 
-#include <linux/sh_clk.h>
-#include <linux/pm_domain.h>
-#include <mach/pm-rmobile.h>
-
 /* DMA slave IDs */
 enum {
 	SHDMA_SLAVE_INVALID,
--- 0006/arch/arm/mach-shmobile/pm-r8a7740.c
+++ work/arch/arm/mach-shmobile/pm-r8a7740.c	2014-06-17 16:09:25.000000000 +0900
@@ -10,8 +10,8 @@
  */
 #include <linux/console.h>
 #include <linux/suspend.h>
-#include <mach/pm-rmobile.h>
 #include "common.h"
+#include "pm-rmobile.h"
 
 #ifdef CONFIG_PM
 static int r8a7740_pd_a4s_suspend(void)
--- 0001/arch/arm/mach-shmobile/pm-rmobile.c
+++ work/arch/arm/mach-shmobile/pm-rmobile.c	2014-06-17 16:09:25.000000000 +0900
@@ -17,7 +17,7 @@
 #include <linux/pm.h>
 #include <linux/pm_clock.h>
 #include <asm/io.h>
-#include <mach/pm-rmobile.h>
+#include "pm-rmobile.h"
 
 /* SYSC */
 #define SPDCR		IOMEM(0xe6180008)
--- /dev/null
+++ work/arch/arm/mach-shmobile/pm-rmobile.h	2014-06-17 16:09:26.000000000 +0900
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * Kuninori Morimoto <morimoto.kuninori@renesas.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef PM_RMOBILE_H
+#define PM_RMOBILE_H
+
+#include <linux/pm_domain.h>
+
+#define DEFAULT_DEV_LATENCY_NS	250000
+
+struct platform_device;
+
+struct rmobile_pm_domain {
+	struct generic_pm_domain genpd;
+	struct dev_power_governor *gov;
+	int (*suspend)(void);
+	void (*resume)(void);
+	unsigned int bit_shift;
+	bool no_debug;
+};
+
+static inline
+struct rmobile_pm_domain *to_rmobile_pd(struct generic_pm_domain *d)
+{
+	return container_of(d, struct rmobile_pm_domain, genpd);
+}
+
+struct pm_domain_device {
+	const char *domain_name;
+	struct platform_device *pdev;
+};
+
+#ifdef CONFIG_PM
+extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
+extern void rmobile_add_device_to_domain_td(const char *domain_name,
+					    struct platform_device *pdev,
+					    struct gpd_timing_data *td);
+
+static inline void rmobile_add_device_to_domain(const char *domain_name,
+						struct platform_device *pdev)
+{
+	rmobile_add_device_to_domain_td(domain_name, pdev, NULL);
+}
+
+extern void rmobile_add_devices_to_domains(struct pm_domain_device data[],
+					   int size);
+#else
+
+#define rmobile_init_domains(domains, num) do { } while (0)
+#define rmobile_add_device_to_domain_td(name, pdev, td) do { } while (0)
+#define rmobile_add_device_to_domain(name, pdev) do { } while (0)
+
+static inline void rmobile_add_devices_to_domains(struct pm_domain_device d[],
+						  int size) {}
+#endif /* CONFIG_PM */
+
+#endif /* PM_RMOBILE_H */
--- 0006/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2014-06-17 16:09:25.000000000 +0900
@@ -26,8 +26,8 @@
 #include <asm/tlbflush.h>
 #include <asm/suspend.h>
 #include <mach/sh7372.h>
-#include <mach/pm-rmobile.h>
 #include "common.h"
+#include "pm-rmobile.h"
 
 /* DBG */
 #define DBGREG1 IOMEM(0xe6100020)
--- 0006/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2014-06-17 16:09:25.000000000 +0900
@@ -32,7 +32,6 @@
 #include <linux/sh_timer.h>
 #include <linux/platform_data/sh_ipmmu.h>
 #include <mach/r8a7740.h>
-#include <mach/pm-rmobile.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
@@ -40,6 +39,7 @@
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
+#include "pm-rmobile.h"
 
 static struct map_desc r8a7740_io_desc[] __initdata = {
 	 /*
--- 0006/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2014-06-17 16:09:25.000000000 +0900
@@ -41,6 +41,7 @@
 #include "common.h"
 #include "dma-register.h"
 #include "irqs.h"
+#include "pm-rmobile.h"
 
 static struct map_desc sh7372_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
