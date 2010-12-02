From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 2 Dec 2010 16:20:42 +0100
Subject: [PATCH v2] ARM: ux500: prcmu db8500 v2 support
Message-ID: <1291303242-27000-1-git-send-email-mattias.wallin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for db8500 chip version 2.
The TCDM memory address of the PRCMU is changed and
dynamic detection of that is added.

Signed-off-by: Mattias Wallin <mattias.wallin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
v2 of this patch allows the prcmu to be used on HW version early drop (ed).
---
 arch/arm/mach-ux500/cpu-db8500.c               |   18 +++++++++++-----
 arch/arm/mach-ux500/cpu.c                      |    2 +
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    3 +-
 arch/arm/mach-ux500/include/mach/prcmu.h       |    1 +
 arch/arm/mach-ux500/prcmu.c                    |   25 +++++++++++++++++++----
 5 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 5966f35..b78970c 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -40,7 +40,6 @@ static struct platform_device *platform_devs[] __initdata = {
 /* minimum static i/o mapping required to boot U8500 platforms */
 static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
@@ -48,13 +47,18 @@ static struct map_desc u8500_io_desc[] __initdata = {
 	__MEM_DEV_DESC(U8500_BOOT_ROM_BASE, SZ_1M),
 };
 
-static struct map_desc u8500ed_io_desc[] __initdata = {
+static struct map_desc u8500_ed_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_MTU0_BASE_ED, SZ_4K),
 	__IO_DEV_DESC(U8500_CLKRST7_BASE_ED, SZ_8K),
 };
 
-static struct map_desc u8500v1_io_desc[] __initdata = {
+static struct map_desc u8500_v1_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE_V1, SZ_4K),
+};
+
+static struct map_desc u8500_v2_io_desc[] __initdata = {
+	__IO_DEV_DESC(U8500_PRCMU_TCDM_BASE, SZ_4K),
 };
 
 /*
@@ -127,9 +131,11 @@ void __init u8500_map_io(void)
 	iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
 
 	if (cpu_is_u8500ed())
-		iotable_init(u8500ed_io_desc, ARRAY_SIZE(u8500ed_io_desc));
-	else
-		iotable_init(u8500v1_io_desc, ARRAY_SIZE(u8500v1_io_desc));
+		iotable_init(u8500_ed_io_desc, ARRAY_SIZE(u8500_ed_io_desc));
+	else if (cpu_is_u8500v1())
+		iotable_init(u8500_v1_io_desc, ARRAY_SIZE(u8500_v1_io_desc));
+	else if (cpu_is_u8500v2())
+		iotable_init(u8500_v2_io_desc, ARRAY_SIZE(u8500_v2_io_desc));
 
 	/* Read out the ASIC ID as early as we can */
 	get_db8500_asic_id();
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 0db48cc..f316484 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -19,6 +19,7 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
+#include <mach/prcmu.h>
 
 #include "clock.h"
 
@@ -58,6 +59,7 @@ void __init ux500_init_irq(void)
 	 * Init clocks here so that they are available for system timer
 	 * initialization.
 	 */
+	prcmu_early_init();
 	clk_init();
 }
 
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/include/mach/db8500-regs.h
index f07d098..0fefb34 100644
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ b/arch/arm/mach-ux500/include/mach/db8500-regs.h
@@ -92,7 +92,8 @@
 #define U8500_SCR_BASE		(U8500_PER4_BASE + 0x05000)
 #define U8500_DMC_BASE		(U8500_PER4_BASE + 0x06000)
 #define U8500_PRCMU_BASE	(U8500_PER4_BASE + 0x07000)
-#define U8500_PRCMU_TCDM_BASE	(U8500_PER4_BASE + 0x0f000)
+#define U8500_PRCMU_TCDM_BASE_V1 (U8500_PER4_BASE + 0x0f000)
+#define U8500_PRCMU_TCDM_BASE   (U8500_PER4_BASE + 0x68000)
 
 /* per3 base addresses */
 #define U8500_FSMC_BASE		(U8500_PER3_BASE + 0x0000)
diff --git a/arch/arm/mach-ux500/include/mach/prcmu.h b/arch/arm/mach-ux500/include/mach/prcmu.h
index 549843f..daa9d3a 100644
--- a/arch/arm/mach-ux500/include/mach/prcmu.h
+++ b/arch/arm/mach-ux500/include/mach/prcmu.h
@@ -9,6 +9,7 @@
 #ifndef __MACH_PRCMU_H
 #define __MACH_PRCMU_H
 
+void __init prcmu_early_init(void);
 int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
 int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size);
 
diff --git a/arch/arm/mach-ux500/prcmu.c b/arch/arm/mach-ux500/prcmu.c
index 293274d..3ba3e32 100644
--- a/arch/arm/mach-ux500/prcmu.c
+++ b/arch/arm/mach-ux500/prcmu.c
@@ -20,10 +20,11 @@
 #include <mach/hardware.h>
 #include <mach/prcmu-regs.h>
 
-#define PRCMU_TCDM_BASE __io_address(U8500_PRCMU_TCDM_BASE)
+/* Global var to runtime determine TCDM base for v2 or v1 */
+static __iomem void *tcdm_base;
 
-#define REQ_MB5 (PRCMU_TCDM_BASE + 0xE44)
-#define ACK_MB5 (PRCMU_TCDM_BASE + 0xDF4)
+#define REQ_MB5 (tcdm_base + 0xE44)
+#define ACK_MB5 (tcdm_base + 0xDF4)
 
 #define REQ_MB5_I2C_SLAVE_OP (REQ_MB5)
 #define REQ_MB5_I2C_HW_BITS (REQ_MB5 + 1)
@@ -33,8 +34,10 @@
 #define ACK_MB5_I2C_STATUS (ACK_MB5 + 1)
 #define ACK_MB5_I2C_VAL (ACK_MB5 + 3)
 
-#define I2C_WRITE(slave) ((slave) << 1)
-#define I2C_READ(slave) (((slave) << 1) | BIT(0))
+#define I2C_WRITE(slave) \
+	(((slave) << 1) | (cpu_is_u8500v2() ? BIT(6) : 0))
+#define I2C_READ(slave) \
+	(((slave) << 1) | (cpu_is_u8500v2() ? BIT(6) : 0) | BIT(0))
 #define I2C_STOP_EN BIT(3)
 
 enum ack_mb5_status {
@@ -217,6 +220,18 @@ static irqreturn_t prcmu_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+void __init prcmu_early_init(void)
+{
+	if (cpu_is_u8500v11() || cpu_is_u8500ed()) {
+		tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE_V1);
+	} else if (cpu_is_u8500v2()) {
+		tcdm_base = __io_address(U8500_PRCMU_TCDM_BASE);
+	} else {
+		pr_err("prcmu: Unsupported chip version\n");
+		BUG();
+	}
+}
+
 static int __init prcmu_init(void)
 {
 	mutex_init(&mb5_transfer.lock);
-- 
1.7.2.2
