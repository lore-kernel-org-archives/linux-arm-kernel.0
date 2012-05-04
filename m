From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri,  4 May 2012 20:30:24 +0800
Subject: [PATCH v2 7/9] ARM: mmp: support pxa910 with device tree
In-Reply-To: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1336134626-12262-8-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suppot gpio/irq/timer in mmp-dt driver. Support PXA910 also in mmp-dt
driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/mmp-dt.c |   50 +++++++++++++++++++++++++++++++++++--------
 1 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index ca22e3c0..033cc31 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -14,14 +14,19 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/time.h>
 #include <mach/irqs.h>
 
 #include "common.h"
 
-extern struct sys_timer pxa168_timer;
-extern void __init icu_init_irq(void);
+extern void __init mmp_dt_irq_init(void);
+extern void __init mmp_dt_init_timer(void);
 
-static const struct of_dev_auxdata mmp_auxdata_lookup[] __initconst = {
+static struct sys_timer mmp_dt_timer = {
+	.init	= mmp_dt_init_timer,
+};
+
+static const struct of_dev_auxdata pxa168_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000, "pxa2xx-uart.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4018000, "pxa2xx-uart.1", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4026000, "pxa2xx-uart.2", NULL),
@@ -32,22 +37,47 @@ static const struct of_dev_auxdata mmp_auxdata_lookup[] __initconst = {
 	{}
 };
 
-static void __init mmp_dt_init(void)
+static const struct of_dev_auxdata pxa910_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000, "pxa2xx-uart.0", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4018000, "pxa2xx-uart.1", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4036000, "pxa2xx-uart.2", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4037000, "pxa2xx-i2c.1", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "pxa-gpio", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
+	{}
+};
+
+static void __init pxa168_dt_init(void)
 {
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     pxa168_auxdata_lookup, NULL);
+}
 
+static void __init pxa910_dt_init(void)
+{
 	of_platform_populate(NULL, of_default_bus_match_table,
-			     mmp_auxdata_lookup, NULL);
+			     pxa910_auxdata_lookup, NULL);
 }
 
-static const char *pxa168_dt_board_compat[] __initdata = {
+static const char *mmp_dt_board_compat[] __initdata = {
 	"mrvl,pxa168-aspenite",
+	"mrvl,pxa910-dkb",
 	NULL,
 };
 
 DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
 	.map_io		= mmp_map_io,
-	.init_irq	= icu_init_irq,
-	.timer		= &pxa168_timer,
-	.init_machine	= mmp_dt_init,
-	.dt_compat	= pxa168_dt_board_compat,
+	.init_irq	= mmp_dt_irq_init,
+	.timer		= &mmp_dt_timer,
+	.init_machine	= pxa168_dt_init,
+	.dt_compat	= mmp_dt_board_compat,
+MACHINE_END
+
+DT_MACHINE_START(PXA910_DT, "Marvell PXA910 (Device Tree Support)")
+	.map_io		= mmp_map_io,
+	.init_irq	= mmp_dt_irq_init,
+	.timer		= &mmp_dt_timer,
+	.init_machine	= pxa910_dt_init,
+	.dt_compat	= mmp_dt_board_compat,
 MACHINE_END
-- 
1.7.5.4
