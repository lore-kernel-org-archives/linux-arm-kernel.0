From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 20 Sep 2010 15:38:05 +0900
Subject: [PATCH 1/2] ARM: S5PV310: Add support RTC
Message-ID: <1284964685-15717-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds support RTC for S5PV310 and S5PC210.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Jemings Ko <jemings@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
NOTE: tested on SMDKV310 and SMDKC210.

 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-s5pv310/Kconfig             |    2 ++
 arch/arm/mach-s5pv310/clock.c             |    5 +++++
 arch/arm/mach-s5pv310/include/mach/irqs.h |    3 +++
 arch/arm/mach-s5pv310/include/mach/map.h  |    2 ++
 arch/arm/mach-s5pv310/mach-smdkc210.c     |    7 +++++++
 arch/arm/mach-s5pv310/mach-smdkv310.c     |    7 +++++++
 7 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bce9193..efa8d7e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -734,6 +734,7 @@ config ARCH_S5PV310
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select GENERIC_CLOCKEVENTS
+	select HAVE_S3C_RTC
 	help
 	  Samsung S5PV310 series based systems
 
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 9ac29fe..4de5d72 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -33,6 +33,7 @@ config MACH_SMDKC210
 	bool "SMDKC210"
 	select CPU_S5PV310
 	select ARCH_SPARSEMEM_ENABLE
+	select S3C_DEV_RTC
 	help
 	  Machine support for Samsung SMDKC210
 	  S5PC210(MCP) is one of package option of S5PV310
@@ -53,6 +54,7 @@ config MACH_SMDKV310
 	bool "SMDKV310"
 	select CPU_S5PV310
 	select ARCH_SPARSEMEM_ENABLE
+	select S3C_DEV_RTC
 	help
 	  Machine support for Samsung SMDKV310
 
diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 262a46f..8ffd80e 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -472,6 +472,11 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv310_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 15),
 	}, {
+		.name		= "rtc",
+		.id		= -1,
+		.enable		= s5pv310_clk_ip_perir_ctrl,
+		.ctrlbit	= (1 << 15),
+	}, {
 		.name		= "watchdog",
 		.id		= -1,
 		.enable		= s5pv310_clk_ip_perir_ctrl,
diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index 7b4b09f..e81332f 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -60,6 +60,9 @@
 #define IRQ_TIMER3_VIC		COMBINER_IRQ(22, 3)
 #define IRQ_TIMER4_VIC		COMBINER_IRQ(22, 4)
 
+#define IRQ_RTC_ALARM		COMBINER_IRQ(23, 0)
+#define IRQ_RTC_TIC		COMBINER_IRQ(23, 1)
+
 #define IRQ_UART0		COMBINER_IRQ(26, 0)
 #define IRQ_UART1		COMBINER_IRQ(26, 1)
 #define IRQ_UART2		COMBINER_IRQ(26, 2)
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index aff6d23..7523653 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -40,6 +40,7 @@
 #define S5PV310_PA_CMU			(0x10030000)
 
 #define S5PV310_PA_WATCHDOG		(0x10060000)
+#define S5PV310_PA_RTC			(0x10070000)
 
 #define S5PV310_PA_COMBINER		(0x10448000)
 
@@ -81,6 +82,7 @@
 #define S3C_PA_HSMMC2			S5PV310_PA_HSMMC(2)
 #define S3C_PA_HSMMC3			S5PV310_PA_HSMMC(3)
 #define S3C_PA_IIC			S5PV310_PA_IIC0
+#define S3C_PA_RTC			S5PV310_PA_RTC
 #define S3C_PA_WDT			S5PV310_PA_WATCHDOG
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index 71a3bec..5b34d9e 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -17,6 +17,7 @@
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
 
 #include <mach/map.h>
 
@@ -65,6 +66,10 @@ static struct s3c2410_uartcfg smdkc210_uartcfgs[] __initdata = {
 	},
 };
 
+static struct platform_device *smdkc210_devices[] __initdata = {
+	&s3c_device_rtc,
+};
+
 static void __init smdkc210_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -77,6 +82,8 @@ static void __init smdkc210_machine_init(void)
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
+
+	platform_add_devices(smdkc210_devices, ARRAY_SIZE(smdkc210_devices));
 }
 
 MACHINE_START(SMDKC210, "SMDKC210")
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 0d6ab77..06062c8 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -17,6 +17,7 @@
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
 
 #include <mach/map.h>
 
@@ -65,6 +66,10 @@ static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
 	},
 };
 
+static struct platform_device *smdkv310_devices[] __initdata = {
+	&s3c_device_rtc,
+};
+
 static void __init smdkv310_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -77,6 +82,8 @@ static void __init smdkv310_machine_init(void)
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
+
+	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
 }
 
 MACHINE_START(SMDKV310, "SMDKV310")
-- 
1.6.2.5
