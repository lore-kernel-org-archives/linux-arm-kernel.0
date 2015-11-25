From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:18 +0100
Subject: [PATCH 05/10] ARM: realview: remove private barrier implementation
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The realview barrier implementation tries to avoid calling outer_sync in order
to not lock up as a result of a bug in the l220 cache controller.

This gets in the way of the multiplatform support, but we can still remove
it if we make sure that the outer_sync function never gets called, by replacing
the function pointer with NULL, right after initialization.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/Kconfig                 | 2 --
 arch/arm/mach-realview/include/mach/barriers.h | 8 --------
 arch/arm/mach-realview/realview_eb.c           | 6 ++++++
 arch/arm/mach-realview/realview_pb11mp.c       | 5 +++++
 4 files changed, 11 insertions(+), 10 deletions(-)
 delete mode 100644 arch/arm/mach-realview/include/mach/barriers.h

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 0fe63b543f5b..055e7355ec14 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -36,7 +36,6 @@ config REALVIEW_EB_A9MP
 config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore Tile"
 	depends on MACH_REALVIEW_EB
-	select ARCH_HAS_BARRIERS if SMP
 	select CPU_V6K
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
@@ -57,7 +56,6 @@ config REALVIEW_EB_ARM11MP_REVB
 
 config MACH_REALVIEW_PB11MP
 	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
-	select ARCH_HAS_BARRIERS if SMP
 	select ARM_GIC
 	select CPU_V6K
 	select HAVE_ARM_SCU if SMP
diff --git a/arch/arm/mach-realview/include/mach/barriers.h b/arch/arm/mach-realview/include/mach/barriers.h
deleted file mode 100644
index 9a732195aa1c..000000000000
--- a/arch/arm/mach-realview/include/mach/barriers.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/*
- * Barriers redefined for RealView ARM11MPCore platforms with L220 cache
- * controller to work around hardware errata causing the outer_sync()
- * operation to deadlock the system.
- */
-#define mb()		dsb()
-#define rmb()		dsb()
-#define wmb()		mb()
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index b3869cbbcc68..4d29535abeba 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -450,6 +450,12 @@ static void __init realview_eb_init(void)
 		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
 		 */
 		l2x0_init(__io_address(REALVIEW_EB11MP_L220_BASE), 0x00790000, 0xfe000fff);
+
+		/*
+		 * due to a bug in the l220 cache controller, we must not call
+		 * the sync function. stub it out here instead!
+		 */
+		outer_cache.sync = NULL;
 #endif
 		pmu_device.name = core_tile_a9mp() ? "armv7-pmu" : "armv6-pmu";
 		platform_device_register(&pmu_device);
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 15c45e25095f..f9817bb5d8fa 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -345,6 +345,11 @@ static void __init realview_pb11mp_init(void)
 	 * Bits:  .... ...0 0111 1001 0000 .... .... ....
 	 */
 	l2x0_init(__io_address(REALVIEW_TC11MP_L220_BASE), 0x00790000, 0xfe000fff);
+	/*
+	 * due to a bug in the l220 cache controller, we must not call
+	 * the sync function. stub it out here instead!
+	 */
+	outer_cache.sync = NULL;
 #endif
 
 	realview_flash_register(realview_pb11mp_flash_resource,
-- 
2.1.0.rc2
