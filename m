From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 7 Jan 2013 09:20:27 +0100
Subject: [PATCH] ARM: ux500: de-globalize <mach/id.h>
Message-ID: <1357546827-10154-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This removes the file <mach/id.h> from the global kernel include
scope, making it a pure mach-ux500 detail. All ASIC specifics
needed by drivers shall henceforth be passed from either platform
data or the device tree.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I'm sending this as a preview, collecting ACKs for the next
merge window.

Sam, Rafael, could you ACK this?

Linus Walleij
---
 arch/arm/mach-ux500/board-mop500-uib.c      |   1 +
 arch/arm/mach-ux500/cache-l2x0.c            |   3 +-
 arch/arm/mach-ux500/cpu-db8500.c            |   2 +
 arch/arm/mach-ux500/cpu.c                   |   1 +
 arch/arm/mach-ux500/id.c                    |   2 +
 arch/arm/mach-ux500/id.h                    | 144 ++++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/hardware.h |   1 -
 arch/arm/mach-ux500/include/mach/id.h       | 144 ----------------------------
 arch/arm/mach-ux500/platsmp.c               |   3 +
 arch/arm/mach-ux500/timer.c                 |   2 +
 drivers/cpufreq/db8500-cpufreq.c            |   3 -
 drivers/mfd/db8500-prcmu.c                  |  17 ++--
 include/linux/mfd/dbx500-prcmu.h            |   2 -
 13 files changed, 163 insertions(+), 162 deletions(-)
 create mode 100644 arch/arm/mach-ux500/id.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/id.h

diff --git a/arch/arm/mach-ux500/board-mop500-uib.c b/arch/arm/mach-ux500/board-mop500-uib.c
index 1f47d96..7037d36 100644
--- a/arch/arm/mach-ux500/board-mop500-uib.c
+++ b/arch/arm/mach-ux500/board-mop500-uib.c
@@ -13,6 +13,7 @@
 
 #include <mach/hardware.h>
 #include "board-mop500.h"
+#include "id.h"
 
 enum mop500_uib {
 	STUIB,
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 75d5b51..1c1609d 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -10,7 +10,8 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <mach/hardware.h>
-#include <mach/id.h>
+
+#include "id.h"
 
 static void __iomem *l2x0_base;
 
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index db0bb75..09c3fee 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -37,7 +37,9 @@
 
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
+
 #include "board-mop500.h"
+#include "id.h"
 
 /* minimum static i/o mapping required to boot U8500 platforms */
 static struct map_desc u8500_uart_io_desc[] __initdata = {
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 721e7b4..14b7d68 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -27,6 +27,7 @@
 #include <mach/devices.h>
 
 #include "board-mop500.h"
+#include "id.h"
 
 void __iomem *_PRCMU_BASE;
 
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index d157992..9f95184 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -17,6 +17,8 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 
+#include "id.h"
+
 struct dbx500_asic_id dbx500_id;
 
 static unsigned int ux500_read_asicid(phys_addr_t addr)
diff --git a/arch/arm/mach-ux500/id.h b/arch/arm/mach-ux500/id.h
new file mode 100644
index 0000000..bcc58a8
--- /dev/null
+++ b/arch/arm/mach-ux500/id.h
@@ -0,0 +1,144 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __MACH_UX500_ID
+#define __MACH_UX500_ID
+
+/**
+ * struct dbx500_asic_id - fields of the ASIC ID
+ * @process: the manufacturing process, 0x40 is 40 nm 0x00 is "standard"
+ * @partnumber: hithereto 0x8500 for DB8500
+ * @revision: version code in the series
+ */
+struct dbx500_asic_id {
+	u16	partnumber;
+	u8	revision;
+	u8	process;
+};
+
+extern struct dbx500_asic_id dbx500_id;
+
+static inline unsigned int __attribute_const__ dbx500_partnumber(void)
+{
+	return dbx500_id.partnumber;
+}
+
+static inline unsigned int __attribute_const__ dbx500_revision(void)
+{
+	return dbx500_id.revision;
+}
+
+/*
+ * SOCs
+ */
+
+static inline bool __attribute_const__ cpu_is_u8500(void)
+{
+	return dbx500_partnumber() == 0x8500;
+}
+
+static inline bool __attribute_const__ cpu_is_u8520(void)
+{
+	return dbx500_partnumber() == 0x8520;
+}
+
+static inline bool cpu_is_u8500_family(void)
+{
+	return cpu_is_u8500() || cpu_is_u8520();
+}
+
+static inline bool __attribute_const__ cpu_is_u9540(void)
+{
+	return dbx500_partnumber() == 0x9540;
+}
+
+static inline bool __attribute_const__ cpu_is_u8540(void)
+{
+	return dbx500_partnumber() == 0x8540;
+}
+
+static inline bool __attribute_const__ cpu_is_u8580(void)
+{
+	return dbx500_partnumber() == 0x8580;
+}
+
+static inline bool cpu_is_ux540_family(void)
+{
+	return cpu_is_u9540() || cpu_is_u8540() || cpu_is_u8580();
+}
+
+/*
+ * 8500 revisions
+ */
+
+static inline bool __attribute_const__ cpu_is_u8500ed(void)
+{
+	return cpu_is_u8500() && dbx500_revision() == 0x00;
+}
+
+static inline bool __attribute_const__ cpu_is_u8500v1(void)
+{
+	return cpu_is_u8500() && (dbx500_revision() & 0xf0) == 0xA0;
+}
+
+static inline bool __attribute_const__ cpu_is_u8500v10(void)
+{
+	return cpu_is_u8500() && dbx500_revision() == 0xA0;
+}
+
+static inline bool __attribute_const__ cpu_is_u8500v11(void)
+{
+	return cpu_is_u8500() && dbx500_revision() == 0xA1;
+}
+
+static inline bool __attribute_const__ cpu_is_u8500v2(void)
+{
+	return cpu_is_u8500() && ((dbx500_revision() & 0xf0) == 0xB0);
+}
+
+static inline bool cpu_is_u8500v20(void)
+{
+	return cpu_is_u8500() && (dbx500_revision() == 0xB0);
+}
+
+static inline bool cpu_is_u8500v21(void)
+{
+	return cpu_is_u8500() && (dbx500_revision() == 0xB1);
+}
+
+static inline bool cpu_is_u8500v22(void)
+{
+	return cpu_is_u8500() && (dbx500_revision() == 0xB2);
+}
+
+static inline bool cpu_is_u8500v20_or_later(void)
+{
+	return (cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11());
+}
+
+/*
+ * 8540 revisions
+ */
+
+static inline bool __attribute_const__ cpu_is_u8540v10(void)
+{
+	return cpu_is_u8540() && dbx500_revision() == 0xA0;
+}
+
+static inline bool __attribute_const__ cpu_is_u8580v10(void)
+{
+	return cpu_is_u8580() && dbx500_revision() == 0xA0;
+}
+
+static inline bool ux500_is_svp(void)
+{
+	return false;
+}
+
+#define ux500_unknown_soc()	BUG()
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 28d16e7..5201dda 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -39,7 +39,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <mach/id.h>
 extern void __iomem *_PRCMU_BASE;
 
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
deleted file mode 100644
index bcc58a8..0000000
--- a/arch/arm/mach-ux500/include/mach/id.h
+++ /dev/null
@@ -1,144 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#ifndef __MACH_UX500_ID
-#define __MACH_UX500_ID
-
-/**
- * struct dbx500_asic_id - fields of the ASIC ID
- * @process: the manufacturing process, 0x40 is 40 nm 0x00 is "standard"
- * @partnumber: hithereto 0x8500 for DB8500
- * @revision: version code in the series
- */
-struct dbx500_asic_id {
-	u16	partnumber;
-	u8	revision;
-	u8	process;
-};
-
-extern struct dbx500_asic_id dbx500_id;
-
-static inline unsigned int __attribute_const__ dbx500_partnumber(void)
-{
-	return dbx500_id.partnumber;
-}
-
-static inline unsigned int __attribute_const__ dbx500_revision(void)
-{
-	return dbx500_id.revision;
-}
-
-/*
- * SOCs
- */
-
-static inline bool __attribute_const__ cpu_is_u8500(void)
-{
-	return dbx500_partnumber() == 0x8500;
-}
-
-static inline bool __attribute_const__ cpu_is_u8520(void)
-{
-	return dbx500_partnumber() == 0x8520;
-}
-
-static inline bool cpu_is_u8500_family(void)
-{
-	return cpu_is_u8500() || cpu_is_u8520();
-}
-
-static inline bool __attribute_const__ cpu_is_u9540(void)
-{
-	return dbx500_partnumber() == 0x9540;
-}
-
-static inline bool __attribute_const__ cpu_is_u8540(void)
-{
-	return dbx500_partnumber() == 0x8540;
-}
-
-static inline bool __attribute_const__ cpu_is_u8580(void)
-{
-	return dbx500_partnumber() == 0x8580;
-}
-
-static inline bool cpu_is_ux540_family(void)
-{
-	return cpu_is_u9540() || cpu_is_u8540() || cpu_is_u8580();
-}
-
-/*
- * 8500 revisions
- */
-
-static inline bool __attribute_const__ cpu_is_u8500ed(void)
-{
-	return cpu_is_u8500() && dbx500_revision() == 0x00;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v1(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() & 0xf0) == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v10(void)
-{
-	return cpu_is_u8500() && dbx500_revision() == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v11(void)
-{
-	return cpu_is_u8500() && dbx500_revision() == 0xA1;
-}
-
-static inline bool __attribute_const__ cpu_is_u8500v2(void)
-{
-	return cpu_is_u8500() && ((dbx500_revision() & 0xf0) == 0xB0);
-}
-
-static inline bool cpu_is_u8500v20(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() == 0xB0);
-}
-
-static inline bool cpu_is_u8500v21(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() == 0xB1);
-}
-
-static inline bool cpu_is_u8500v22(void)
-{
-	return cpu_is_u8500() && (dbx500_revision() == 0xB2);
-}
-
-static inline bool cpu_is_u8500v20_or_later(void)
-{
-	return (cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11());
-}
-
-/*
- * 8540 revisions
- */
-
-static inline bool __attribute_const__ cpu_is_u8540v10(void)
-{
-	return cpu_is_u8540() && dbx500_revision() == 0xA0;
-}
-
-static inline bool __attribute_const__ cpu_is_u8580v10(void)
-{
-	return cpu_is_u8580() && dbx500_revision() == 0xA0;
-}
-
-static inline bool ux500_is_svp(void)
-{
-	return false;
-}
-
-#define ux500_unknown_soc()	BUG()
-
-#endif
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 3db7782..1a92e07 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -21,9 +21,12 @@
 #include <asm/hardware/gic.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
+
 #include <mach/hardware.h>
 #include <mach/setup.h>
 
+#include "id.h"
+
 /* This is called from headsmp.S to wakeup the secondary core */
 extern void u8500_secondary_startup(void);
 
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 875309a..c685ad1 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -17,6 +17,8 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
+#include "id.h"
+
 #ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(u8500_twd_local_timer,
 			      U8500_TWD_BASE, IRQ_LOCALTIMER);
diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
index 4f154bc..523c940 100644
--- a/drivers/cpufreq/db8500-cpufreq.c
+++ b/drivers/cpufreq/db8500-cpufreq.c
@@ -167,9 +167,6 @@ static struct platform_driver db8500_cpufreq_plat_driver = {
 
 static int __init db8500_cpufreq_register(void)
 {
-	if (!cpu_is_u8500_family())
-		return -ENODEV;
-
 	pr_info("cpufreq for DB8500 started\n");
 	return platform_driver_register(&db8500_cpufreq_plat_driver);
 }
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index dc8826d..67d8b25 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -36,7 +36,6 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/db8500-regs.h>
-#include <mach/id.h>
 #include "dbx500-prcmu-regs.h"
 
 /* Offset for the firmware version within the TCPM */
@@ -216,10 +215,8 @@
 #define PRCM_REQ_MB5_I2C_HW_BITS	(PRCM_REQ_MB5 + 0x1)
 #define PRCM_REQ_MB5_I2C_REG		(PRCM_REQ_MB5 + 0x2)
 #define PRCM_REQ_MB5_I2C_VAL		(PRCM_REQ_MB5 + 0x3)
-#define PRCMU_I2C_WRITE(slave) \
-	(((slave) << 1) | (cpu_is_u8500v2() ? BIT(6) : 0))
-#define PRCMU_I2C_READ(slave) \
-	(((slave) << 1) | BIT(0) | (cpu_is_u8500v2() ? BIT(6) : 0))
+#define PRCMU_I2C_WRITE(slave) (((slave) << 1) | BIT(6))
+#define PRCMU_I2C_READ(slave) (((slave) << 1) | BIT(0) | BIT(6))
 #define PRCMU_I2C_STOP_EN		BIT(3)
 
 /* Mailbox 5 ACKs */
@@ -1049,12 +1046,13 @@ int db8500_prcmu_get_ddr_opp(void)
  *
  * This function sets the operating point of the DDR.
  */
+static bool enable_set_ddr_opp;
 int db8500_prcmu_set_ddr_opp(u8 opp)
 {
 	if (opp < DDR_100_OPP || opp > DDR_25_OPP)
 		return -EINVAL;
 	/* Changing the DDR OPP can hang the hardware pre-v21 */
-	if (cpu_is_u8500v20_or_later() && !cpu_is_u8500v20())
+	if (enable_set_ddr_opp)
 		writeb(opp, PRCM_DDR_SUBSYS_APE_MINBW);
 
 	return 0;
@@ -2790,6 +2788,7 @@ void __init db8500_prcmu_early_init(void)
 		pr_err("prcmu: Unsupported chip version\n");
 		BUG();
 	}
+	tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE);
 
 	spin_lock_init(&mb0_transfer.lock);
 	spin_lock_init(&mb0_transfer.dbb_irqs_lock);
@@ -3104,9 +3103,6 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int irq = 0, err = 0, i;
 
-	if (ux500_is_svp())
-		return -ENODEV;
-
 	init_prcm_registers();
 
 	/* Clean up the mailbox interrupts after pre-kernel code. */
@@ -3135,8 +3131,7 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (cpu_is_u8500v20_or_later())
-		prcmu_config_esram0_deep_sleep(ESRAM0_DEEP_SLEEP_STATE_RET);
+	prcmu_config_esram0_deep_sleep(ESRAM0_DEEP_SLEEP_STATE_RET);
 
 	db8500_prcmu_update_cpufreq();
 
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index ac60147..1552806 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -218,8 +218,6 @@ enum ddr_pwrst {
 
 #if defined(CONFIG_UX500_SOC_DB8500)
 
-#include <mach/id.h>
-
 static inline void __init prcmu_early_init(void)
 {
 	return db8500_prcmu_early_init();
-- 
1.7.11.3
