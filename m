From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 23 Feb 2010 15:43:01 +0530
Subject: [PATCH 3/4] ux500: add support for u8500 v1 revision
In-Reply-To: <1266919983-32759-1-git-send-email-rabin.vincent@stericsson.com>
References: <1266919983-32759-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1266919983-32759-4-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpu_is_u8500{ed/v1}() functions to determine the variant based on
the CPU id, add the changed peripheral addresses, and fixup the MTU
address.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/cpu-u8500.c             |   19 +++++++++++++++-
 arch/arm/mach-ux500/include/mach/hardware.h |   29 ++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 588b059..f368504 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -40,15 +40,27 @@ static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_UART2_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GIC_CPU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_TWD_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),
 };
 
+static struct map_desc u8500ed_io_desc[] __initdata = {
+	__IO_DEV_DESC(U8500_MTU0_BASE_ED, SZ_4K),
+};
+
+static struct map_desc u8500v1_io_desc[] __initdata = {
+	__IO_DEV_DESC(U8500_MTU0_BASE_V1, SZ_4K),
+};
+
 void __init u8500_map_io(void)
 {
 	iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
+
+	if (cpu_is_u8500ed())
+		iotable_init(u8500ed_io_desc, ARRAY_SIZE(u8500ed_io_desc));
+	else
+		iotable_init(u8500v1_io_desc, ARRAY_SIZE(u8500v1_io_desc));
 }
 
 void __init u8500_init_irq(void)
@@ -75,7 +87,10 @@ static void __init u8500_timer_init(void)
 	twd_base = __io_address(U8500_TWD_BASE);
 #endif
 	/* Setup the MTU base */
-	mtu_base = __io_address(U8500_MTU0_BASE);
+	if (cpu_is_u8500ed())
+		mtu_base = __io_address(U8500_MTU0_BASE_ED);
+	else
+		mtu_base = __io_address(U8500_MTU0_BASE_V1);
 
 	nmdk_timer_init();
 }
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 04ea836..f29a43d 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -56,16 +56,19 @@
 #define U8500_TWD_SIZE		0x100
 
 /* per7 base addressess */
-#define U8500_CR_BASE		(U8500_PER7_BASE + 0x8000)
-#define U8500_MTU0_BASE		(U8500_PER7_BASE + 0xa000)
-#define U8500_MTU1_BASE		(U8500_PER7_BASE + 0xb000)
-#define U8500_TZPC0_BASE	(U8500_PER7_BASE + 0xc000)
-#define U8500_CLKRST7_BASE	(U8500_PER7_BASE + 0xf000)
+#define U8500_CR_BASE_ED	(U8500_PER7_BASE + 0x8000)
+#define U8500_MTU0_BASE_ED	(U8500_PER7_BASE + 0xa000)
+#define U8500_MTU1_BASE_ED	(U8500_PER7_BASE + 0xb000)
+#define U8500_TZPC0_BASE_ED	(U8500_PER7_BASE + 0xc000)
+#define U8500_CLKRST7_BASE_ED	(U8500_PER7_BASE + 0xf000)
 
 /* per6 base addressess */
 #define U8500_RNG_BASE		(U8500_PER6_BASE + 0x0000)
 #define U8500_PKA_BASE		(U8500_PER6_BASE + 0x1000)
 #define U8500_PKAM_BASE		(U8500_PER6_BASE + 0x2000)
+#define U8500_MTU0_BASE_V1	(U8500_PER6_BASE + 0x6000)
+#define U8500_MTU1_BASE_V1	(U8500_PER6_BASE + 0x7000)
+#define U8500_CR_BASE_V1	(U8500_PER6_BASE + 0x8000)
 #define U8500_CRYPTO0_BASE	(U8500_PER6_BASE + 0xa000)
 #define U8500_CRYPTO1_BASE	(U8500_PER6_BASE + 0xb000)
 #define U8500_CLKRST6_BASE	(U8500_PER6_BASE + 0xf000)
@@ -128,4 +131,20 @@
 /* ST-Ericsson modified pl022 id */
 #define SSP_PER_ID		0x01080022
 
+#ifndef __ASSEMBLY__
+
+#include <asm/cputype.h>
+
+static inline bool cpu_is_u8500ed(void)
+{
+	return (read_cpuid_id() & 15) == 0;
+}
+
+static inline bool cpu_is_u8500v1(void)
+{
+	return (read_cpuid_id() & 15) == 1;
+}
+
+#endif
+
 #endif				/* __MACH_HARDWARE_H */
-- 
1.7.0
