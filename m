From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:51 +0200
Subject: [PATCH 09/14] ARM: ux500: get rid of <mach/[hardware|db8500-regs].h>
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-10-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This removes <mach/hardware.h> and <mach/db8500-regs.h>
from the Ux500, merging them into the local include
"db8500-regs.h" in mach-ux500. There is some impact
outside the ux500 machine, but most of it is dealt with
in earlier patches.

Contains portions of a clean-up patch from Arnd Bergmann.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Remove erroneous hunk adding the GIC distbase as resource
  to the PRCMU. This was done away with in the previous patch.
- Split debug-macro portions into a separate patch.

Sam: seeking your ACKs to take this through ARM SoC.
---
 arch/arm/mach-ux500/board-mop500-audio.c           |  1 -
 arch/arm/mach-ux500/board-mop500-pins.c            |  2 -
 arch/arm/mach-ux500/board-mop500-sdi.c             |  2 +-
 arch/arm/mach-ux500/board-mop500-uib.c             |  1 -
 arch/arm/mach-ux500/board-mop500.c                 |  2 +-
 arch/arm/mach-ux500/cache-l2x0.c                   |  2 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |  4 +-
 arch/arm/mach-ux500/cpu.c                          |  2 +-
 arch/arm/mach-ux500/cpuidle.c                      |  2 +
 .../mach-ux500/{include/mach => }/db8500-regs.h    | 28 ++++++++++++++
 arch/arm/mach-ux500/devices-common.c               |  1 -
 arch/arm/mach-ux500/devices-db8500.c               |  2 +-
 arch/arm/mach-ux500/devices-db8500.h               |  1 +
 arch/arm/mach-ux500/devices.c                      |  3 +-
 arch/arm/mach-ux500/id.c                           |  2 +-
 arch/arm/mach-ux500/include/mach/hardware.h        | 45 ----------------------
 arch/arm/mach-ux500/include/mach/irqs.h            |  2 -
 arch/arm/mach-ux500/include/mach/uncompress.h      |  3 +-
 arch/arm/mach-ux500/platsmp.c                      |  2 +-
 arch/arm/mach-ux500/pm.c                           |  2 +-
 arch/arm/mach-ux500/timer.c                        |  2 +-
 arch/arm/mach-ux500/usb.c                          |  2 +-
 drivers/clk/ux500/clk-prcc.c                       |  1 -
 drivers/clocksource/clksrc-dbx500-prcmu.c          |  1 -
 drivers/crypto/ux500/cryp/cryp.c                   |  2 -
 drivers/crypto/ux500/cryp/cryp_core.c              |  1 -
 drivers/crypto/ux500/hash/hash_core.c              |  1 -
 drivers/mfd/db8500-prcmu.c                         |  2 -
 drivers/mfd/dbx500-prcmu-regs.h                    | 22 -----------
 sound/soc/ux500/mop500_ab8500.c                    |  2 -
 sound/soc/ux500/ux500_msp_dai.c                    |  2 -
 sound/soc/ux500/ux500_msp_i2s.c                    |  2 -
 32 files changed, 46 insertions(+), 103 deletions(-)
 rename arch/arm/mach-ux500/{include/mach => }/db8500-regs.h (88%)
 delete mode 100644 arch/arm/mach-ux500/include/mach/hardware.h

diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index 43bbee1..96e62ef 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -11,7 +11,6 @@
 #include <linux/platform_data/dma-ste-dma40.h>
 
 #include <mach/devices.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <linux/platform_data/asoc-ux500-msp.h>
 
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 0a3f30d..f3976f9 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -13,8 +13,6 @@
 
 #include <asm/mach-types.h>
 
-#include <mach/hardware.h>
-
 #include "pins-db8500.h"
 #include "board-mop500.h"
 
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 051b62c..0ada767 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -15,8 +15,8 @@
 
 #include <asm/mach-types.h>
 #include <mach/devices.h>
-#include <mach/hardware.h>
 
+#include "db8500-regs.h"
 #include "devices-db8500.h"
 #include "board-mop500.h"
 #include "ste-dma40-db8500.h"
diff --git a/arch/arm/mach-ux500/board-mop500-uib.c b/arch/arm/mach-ux500/board-mop500-uib.c
index 7037d36..bdaa422 100644
--- a/arch/arm/mach-ux500/board-mop500-uib.c
+++ b/arch/arm/mach-ux500/board-mop500-uib.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 
-#include <mach/hardware.h>
 #include "board-mop500.h"
 #include "id.h"
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index b034578..caad80e 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -41,13 +41,13 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
 #include <mach/irqs.h>
 #include <linux/platform_data/crypto-ux500.h>
 
 #include "ste-dma40-db8500.h"
+#include "db8500-regs.h"
 #include "devices-db8500.h"
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 1c1609d..e12cc92 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -9,8 +9,8 @@
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <mach/hardware.h>
 
+#include "db8500-regs.h"
 #include "id.h"
 
 static void __iomem *l2x0_base;
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 8c58dff..d726c06 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -28,15 +28,13 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
-#include <mach/db8500-regs.h>
 #include <mach/irqs.h>
 
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
-
+#include "db8500-regs.h"
 #include "board-mop500.h"
 #include "id.h"
 
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index ee69439d..aa14c5f 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -24,11 +24,11 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
 
 #include "board-mop500.h"
+#include "db8500-regs.h"
 #include "id.h"
 
 /*
diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index 1e5bb66..654115a 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -21,6 +21,8 @@
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 
+#include "db8500-regs.h"
+
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
 static DEFINE_PER_CPU(struct cpuidle_device, ux500_cpuidle_device);
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/db8500-regs.h
similarity index 88%
rename from arch/arm/mach-ux500/include/mach/db8500-regs.h
rename to arch/arm/mach-ux500/db8500-regs.h
index 1530d49..b2d7a0b 100644
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ b/arch/arm/mach-ux500/db8500-regs.h
@@ -170,4 +170,32 @@
 /* SoC identification number information */
 #define U8500_BB_UID_BASE      (U8500_BACKUPRAM1_BASE + 0xFC0)
 
+/* Offsets to specific addresses in some IP blocks for DMA */
+#define MSP_TX_RX_REG_OFFSET	0
+#define CRYP1_RX_REG_OFFSET	0x10
+#define CRYP1_TX_REG_OFFSET	0x8
+#define HASH1_TX_REG_OFFSET	0x4
+
+/*
+ * Macros to get at IO space when running virtually
+ * We dont map all the peripherals, let ioremap do
+ * this for us. We map only very basic peripherals here.
+ */
+#define U8500_IO_VIRTUAL	0xf0000000
+#define U8500_IO_PHYSICAL	0xa0000000
+/* This is where we map in the ROM to check ASIC IDs */
+#define UX500_VIRT_ROM		0xf0000000
+
+/* This macro is used in assembly, so no cast */
+#define IO_ADDRESS(x)           \
+	(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + U8500_IO_VIRTUAL)
+
+/* typesafe io address */
+#define __io_address(n)		IOMEM(IO_ADDRESS(n))
+
+/* Used by some plat-nomadik code */
+#define io_p2v(n)		__io_address(n)
+
+#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
+
 #endif
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 16b5f71..94868b7 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 
 #include "devices-common.h"
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index f3d9419..38467bf 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -15,10 +15,10 @@
 #include <linux/platform_data/dma-ste-dma40.h>
 #include <linux/mfd/dbx500-prcmu.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/irqs.h>
 
+#include "db8500-regs.h"
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
 
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index dbcb35c..c9db210 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -10,6 +10,7 @@
 
 #include <linux/platform_data/usb-musb-ux500.h>
 #include <mach/irqs.h>
+#include "db8500-regs.h"
 #include "devices-common.h"
 
 struct ske_keypad_platform_data;
diff --git a/arch/arm/mach-ux500/devices.c b/arch/arm/mach-ux500/devices.c
index ea0a2f9..f63a512 100644
--- a/arch/arm/mach-ux500/devices.c
+++ b/arch/arm/mach-ux500/devices.c
@@ -11,9 +11,10 @@
 #include <linux/io.h>
 #include <linux/amba/bus.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 
+#include "db8500-regs.h"
+
 void __init amba_add_devices(struct amba_device *devs[], int num)
 {
 	int i;
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index 9f95184..a847cf2 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -14,9 +14,9 @@
 #include <asm/cacheflush.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 
+#include "db8500-regs.h"
 #include "id.h"
 
 struct dbx500_asic_id dbx500_id;
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
deleted file mode 100644
index 4eece2a..0000000
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Copyright (C) 2009 ST-Ericsson.
- *
- * U8500 hardware definitions
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#ifndef __MACH_HARDWARE_H
-#define __MACH_HARDWARE_H
-
-/*
- * Macros to get at IO space when running virtually
- * We dont map all the peripherals, let ioremap do
- * this for us. We map only very basic peripherals here.
- */
-#define U8500_IO_VIRTUAL	0xf0000000
-#define U8500_IO_PHYSICAL	0xa0000000
-/* This is where we map in the ROM to check ASIC IDs */
-#define UX500_VIRT_ROM		0xf0000000
-
-/* This macro is used in assembly, so no cast */
-#define IO_ADDRESS(x)           \
-	(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + U8500_IO_VIRTUAL)
-
-/* typesafe io address */
-#define __io_address(n)		IOMEM(IO_ADDRESS(n))
-
-/* Used by some plat-nomadik code */
-#define io_p2v(n)		__io_address(n)
-
-#include <mach/db8500-regs.h>
-
-#define MSP_TX_RX_REG_OFFSET	0
-#define CRYP1_RX_REG_OFFSET	0x10
-#define CRYP1_TX_REG_OFFSET	0x8
-#define HASH1_TX_REG_OFFSET	0x4
-
-#ifndef __ASSEMBLY__
-
-#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
-
-#endif				/* __ASSEMBLY__ */
-#endif				/* __MACH_HARDWARE_H */
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index fc77b42..829947d 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -10,8 +10,6 @@
 #ifndef ASM_ARCH_IRQS_H
 #define ASM_ARCH_IRQS_H
 
-#include <mach/hardware.h>
-
 #define IRQ_LOCALTIMER			29
 #define IRQ_LOCALWDOG			30
 
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 36969d5..533a004 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -22,7 +22,8 @@
 #include <asm/mach-types.h>
 #include <linux/io.h>
 #include <linux/amba/serial.h>
-#include <mach/hardware.h>
+/* TODO: This goes away in multiplatform boot, this file gets deleted */
+#include "../../db8500-regs.h"
 
 void __iomem *ux500_uart_base;
 
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 18f7af3..8a9c070 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -22,9 +22,9 @@
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 
+#include "db8500-regs.h"
 #include "id.h"
 
 /* This is called from headsmp.S to wakeup the secondary core */
diff --git a/arch/arm/mach-ux500/pm.c b/arch/arm/mach-ux500/pm.c
index 6949a13..1a468f0 100644
--- a/arch/arm/mach-ux500/pm.c
+++ b/arch/arm/mach-ux500/pm.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/platform_data/arm-ux500-pm.h>
 
-#include <mach/hardware.h>
+#include "db8500-regs.h"
 
 /* ARM WFI Standby signal register */
 #define PRCM_ARM_WFI_STANDBY    (prcmu_base + 0x130)
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index a6af0b8..5b91fac 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -14,9 +14,9 @@
 #include <asm/smp_twd.h>
 
 #include <mach/setup.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 
+#include "db8500-regs.h"
 #include "id.h"
 
 #ifdef CONFIG_HAVE_ARM_TWD
diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
index 78ac65f..2dfc72f 100644
--- a/arch/arm/mach-ux500/usb.c
+++ b/arch/arm/mach-ux500/usb.c
@@ -10,7 +10,7 @@
 #include <linux/platform_data/usb-musb-ux500.h>
 #include <linux/platform_data/dma-ste-dma40.h>
 
-#include <mach/hardware.h>
+#include "db8500-regs.h"
 
 #define MUSB_DMA40_RX_CH { \
 		.mode = STEDMA40_MODE_LOGICAL, \
diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
index 7eee7f7..bd4769a 100644
--- a/drivers/clk/ux500/clk-prcc.c
+++ b/drivers/clk/ux500/clk-prcc.c
@@ -13,7 +13,6 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/types.h>
-#include <mach/hardware.h>
 
 #include "clk.h"
 
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index c26c369..4f34093 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -18,7 +18,6 @@
 #include <asm/sched_clock.h>
 
 #include <mach/setup.h>
-#include <mach/hardware.h>
 
 #define RATE_32K		32768
 
diff --git a/drivers/crypto/ux500/cryp/cryp.c b/drivers/crypto/ux500/cryp/cryp.c
index e208cea..3eafa90 100644
--- a/drivers/crypto/ux500/cryp/cryp.c
+++ b/drivers/crypto/ux500/cryp/cryp.c
@@ -12,8 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-#include <mach/hardware.h>
-
 #include "cryp_p.h"
 #include "cryp.h"
 
diff --git a/drivers/crypto/ux500/cryp/cryp_core.c b/drivers/crypto/ux500/cryp/cryp_core.c
index 8bc5fef..2809b19 100644
--- a/drivers/crypto/ux500/cryp/cryp_core.c
+++ b/drivers/crypto/ux500/cryp/cryp_core.c
@@ -32,7 +32,6 @@
 #include <crypto/scatterwalk.h>
 
 #include <linux/platform_data/crypto-ux500.h>
-#include <mach/hardware.h>
 
 #include "cryp_p.h"
 #include "cryp.h"
diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index 632c333..1827e9f 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -32,7 +32,6 @@
 #include <crypto/algapi.h>
 
 #include <linux/platform_data/crypto-ux500.h>
-#include <mach/hardware.h>
 
 #include "hash_alg.h"
 
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 2d3a5f6..03e2aed 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -33,9 +33,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/cpufreq.h>
 #include <linux/platform_data/ux500_wdt.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/db8500-regs.h>
 #include "dbx500-prcmu-regs.h"
 
 /* Index of different voltages to be used when accessing AVSData */
diff --git a/drivers/mfd/dbx500-prcmu-regs.h b/drivers/mfd/dbx500-prcmu-regs.h
index 439254d..d14836e 100644
--- a/drivers/mfd/dbx500-prcmu-regs.h
+++ b/drivers/mfd/dbx500-prcmu-regs.h
@@ -74,33 +74,11 @@
 #define PRCM_A9PL_FORCE_CLKEN_PRCM_A9PL_FORCE_CLKEN BIT(0)
 #define PRCM_A9PL_FORCE_CLKEN_PRCM_A9AXI_FORCE_CLKEN BIT(1)
 
-/* ARM WFI Standby signal register */
-#define PRCM_ARM_WFI_STANDBY    (prcmu_base + 0x130)
-#define PRCM_ARM_WFI_STANDBY_WFI0               0x08
-#define PRCM_ARM_WFI_STANDBY_WFI1               0x10
-#define PRCM_IOCR		(prcmu_base + 0x310)
-#define PRCM_IOCR_IOFORCE			0x1
-
 /* CPU mailbox registers */
 #define PRCM_MBOX_CPU_VAL	(prcmu_base + 0x0fc)
 #define PRCM_MBOX_CPU_SET	(prcmu_base + 0x100)
 #define PRCM_MBOX_CPU_CLR	(prcmu_base + 0x104)
 
-/* Dual A9 core interrupt management unit registers */
-#define PRCM_A9_MASK_REQ	(prcmu_base + 0x328)
-#define PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ	0x1
-
-#define PRCM_A9_MASK_ACK	(prcmu_base + 0x32c)
-#define PRCM_ARMITMSK31TO0	(prcmu_base + 0x11c)
-#define PRCM_ARMITMSK63TO32	(prcmu_base + 0x120)
-#define PRCM_ARMITMSK95TO64	(prcmu_base + 0x124)
-#define PRCM_ARMITMSK127TO96	(prcmu_base + 0x128)
-#define PRCM_POWER_STATE_VAL	(prcmu_base + 0x25C)
-#define PRCM_ARMITVAL31TO0	(prcmu_base + 0x260)
-#define PRCM_ARMITVAL63TO32	(prcmu_base + 0x264)
-#define PRCM_ARMITVAL95TO64	(prcmu_base + 0x268)
-#define PRCM_ARMITVAL127TO96	(prcmu_base + 0x26C)
-
 #define PRCM_HOSTACCESS_REQ	(prcmu_base + 0x334)
 #define PRCM_HOSTACCESS_REQ_HOSTACCESS_REQ 0x1
 #define PRCM_HOSTACCESS_REQ_WAKE_REQ	BIT(16)
diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index 78cce23..892ad9a 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -17,8 +17,6 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 
-#include <mach/hardware.h>
-
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 0d9713e..54028cf 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -21,8 +21,6 @@
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/platform_data/asoc-ux500-msp.h>
 
-#include <mach/hardware.h>
-
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
 
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index a582007..f2db6c9 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -22,8 +22,6 @@
 #include <linux/of.h>
 #include <linux/platform_data/asoc-ux500-msp.h>
 
-#include <mach/hardware.h>
-
 #include <sound/soc.h>
 
 #include "ux500_msp_i2s.h"
-- 
1.7.11.3
