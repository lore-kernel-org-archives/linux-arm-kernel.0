From: netz.kernel@gmail.com (Marty Plummer)
Date: Thu, 15 Sep 2016 16:05:04 -0500
Subject: [RFC PATCH v2 4/5] ARM: hisi: enable devicetree support for hi3520
In-Reply-To: <20160915210505.21878-1-netz.kernel@gmail.com>
References: <20160915210505.21878-1-netz.kernel@gmail.com>
Message-ID: <20160915210505.21878-5-netz.kernel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GIC removed from the ARCH_HISI namespace and placed in individual SoC as
hi3520 uses a VIC instead and doesn't require a GIC

Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
---
 arch/arm/mach-hisi/Kconfig     | 28 +++++++++++++++++++---------
 arch/arm/mach-hisi/hisilicon.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 8a552c3..ea4e5b1 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -1,8 +1,7 @@
 config ARCH_HISI
 	bool "Hisilicon SoC Support"
-	depends on ARCH_MULTI_V7
+	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
 	select ARM_AMBA
-	select ARM_GIC
 	select ARM_TIMER_SP804
 	select POWER_RESET
 	select POWER_RESET_HISI
@@ -12,9 +11,17 @@ if ARCH_HISI
 
 menu "Hisilicon platform type"
 
+config ARCH_HI3520_1176
+	bool "Hisilicon	Hi3520 family"
+	depends on ARCH_MULTI_V6
+	select ARM_VIC
+	help
+	  Support for Hisilicon Hi3520 SoC family
+
 config ARCH_HI3620
 	bool "Hisilicon Hi3620 family"
 	depends on ARCH_MULTI_V7
+	select ARM_GIC
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
@@ -24,17 +31,19 @@ config ARCH_HI3620
 	  Support for Hisilicon Hi36xx SoC family
 
 config ARCH_HIP01
-       bool "Hisilicon HIP01 family"
-       depends on ARCH_MULTI_V7
-       select HAVE_ARM_SCU if SMP
-       select HAVE_ARM_TWD if SMP
-       select ARM_GLOBAL_TIMER
-       help
-         Support for Hisilicon HIP01 SoC family
+	bool "Hisilicon HIP01 family"
+	depends on ARCH_MULTI_V7
+	select ARM_GIC
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select ARM_GLOBAL_TIMER
+	help
+	  Support for Hisilicon HIP01 SoC family
 
 config ARCH_HIP04
 	bool "Hisilicon HiP04 Cortex A15 family"
 	depends on ARCH_MULTI_V7
+	select ARM_GIC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
@@ -45,6 +54,7 @@ config ARCH_HIP04
 config ARCH_HIX5HD2
 	bool "Hisilicon X5HD2 family"
 	depends on ARCH_MULTI_V7
+	select ARM_GIC
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index dfa1ee8..7a15936 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -17,6 +17,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#define HI3520_1176_SYSCTRL_PHYS_BASE		0x20050000
+#define HI3520_1176_SYSCTRL_VIRT_BASE		0xfe350000
 #define HI3620_SYSCTRL_PHYS_BASE		0xfc802000
 #define HI3620_SYSCTRL_VIRT_BASE		0xfe802000
 
@@ -28,6 +30,16 @@
  * spaces wasted since ioremap() may be called multi times for the same
  * IO space.
  */
+static struct map_desc hi3520_1176_io_desc[] __initdata = {
+	{
+		/* sysctrl */
+		.virtual	= HI3520_1176_SYSCTRL_VIRT_BASE,
+		.pfn		= __phys_to_pfn(HI3520_1176_SYSCTRL_PHYS_BASE),
+		.length		= 0x10000,
+		.type		= MT_DEVICE,
+	},
+};
+
 static struct map_desc hi3620_io_desc[] __initdata = {
 	{
 		/* sysctrl */
@@ -38,17 +50,33 @@ static struct map_desc hi3620_io_desc[] __initdata = {
 	},
 };
 
+static void __init hi3520_1176_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(hi3520_1176_io_desc, ARRAY_SIZE(hi3520_1176_io_desc));
+}
+
 static void __init hi3620_map_io(void)
 {
 	debug_ll_io_init();
 	iotable_init(hi3620_io_desc, ARRAY_SIZE(hi3620_io_desc));
 }
 
+static const char *const hi3520_1176_compat[] __initconst = {
+	"hisilicon,hi3520-1176",
+	NULL,
+};
+
 static const char *const hi3620_compat[] __initconst = {
 	"hisilicon,hi3620-hi4511",
 	NULL,
 };
 
+DT_MACHINE_START(HI3520_1176, "Hisilicon Hi3520-1176 (Flattened Device Tree)")
+	.map_io		= hi3520_1176_map_io,
+	.dt_compat	= hi3520_1176_compat,
+MACHINE_END
+
 DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.map_io		= hi3620_map_io,
 	.dt_compat	= hi3620_compat,
-- 
2.9.3
