From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 13:11:35 +0200
Subject: [PATCH 7/7] ARM: nuc900: make NUC970 multiplatform
In-Reply-To: <20160714111135.2476095-1-arnd@arndb.de>
References: <20160714111135.2476095-1-arnd@arndb.de>
Message-ID: <20160714111135.2476095-7-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables multiplatform support for NUC9xx, which should work fine
for NUC970, though the others are still lacking a common-clk driver
to actually work.

As a consequence, I'm leaving both options present -- separate builds
using ARCH_W90X900_SINGLE and a multiplatform build using the new
ARCH_NUC900 option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                  |  2 +-
 arch/arm/configs/nuc910_defconfig |  2 +-
 arch/arm/configs/nuc950_defconfig |  2 +-
 arch/arm/configs/nuc960_defconfig |  2 +-
 arch/arm/configs/nuc970_defconfig |  4 +++-
 arch/arm/mach-w90x900/Kconfig     | 41 +++++++++++++++++++++++++--------------
 arch/arm/mach-w90x900/Makefile    |  8 +++++---
 arch/arm/mach-w90x900/cpu.c       |  6 ++++++
 arch/arm/mach-w90x900/cpu.h       |  4 ++++
 9 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 160dbf993660..2a3113bd437a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -496,7 +496,7 @@ config ARCH_KS8695
 	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
 	  System-on-Chip devices.
 
-config ARCH_W90X900
+config ARCH_W90X900_SINGLE
 	bool "Nuvoton W90X900 CPU"
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
diff --git a/arch/arm/configs/nuc910_defconfig b/arch/arm/configs/nuc910_defconfig
index 10180cfde162..bb229dab9d72 100644
--- a/arch/arm/configs/nuc910_defconfig
+++ b/arch/arm/configs/nuc910_defconfig
@@ -8,7 +8,7 @@ CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
-CONFIG_ARCH_W90X900=y
+CONFIG_ARCH_W90X900_SINGLE=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/ram0 console=ttyS0,115200n8 rdinit=/sbin/init mem=64M"
diff --git a/arch/arm/configs/nuc950_defconfig b/arch/arm/configs/nuc950_defconfig
index 27aa8731330b..b3b43f0f2238 100644
--- a/arch/arm/configs/nuc950_defconfig
+++ b/arch/arm/configs/nuc950_defconfig
@@ -8,7 +8,7 @@ CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
-CONFIG_ARCH_W90X900=y
+CONFIG_ARCH_W90X900_SINGLE=y
 # CONFIG_MACH_W90P910EVB is not set
 CONFIG_MACH_W90P950EVB=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/nuc960_defconfig b/arch/arm/configs/nuc960_defconfig
index 56fd7ad0ff13..4c6b0315a49b 100644
--- a/arch/arm/configs/nuc960_defconfig
+++ b/arch/arm/configs/nuc960_defconfig
@@ -8,7 +8,7 @@ CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
-CONFIG_ARCH_W90X900=y
+CONFIG_ARCH_W90X900_SINGLE=y
 # CONFIG_MACH_W90P910EVB is not set
 CONFIG_MACH_W90N960EVB=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/nuc970_defconfig b/arch/arm/configs/nuc970_defconfig
index b39a406c6495..972e3286eaf8 100644
--- a/arch/arm/configs/nuc970_defconfig
+++ b/arch/arm/configs/nuc970_defconfig
@@ -19,7 +19,9 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_ARCH_W90X900=y
+CONFIG_ARCH_MULTIPLATFORM=y
+CONFIG_ARCH_MULTI_V5=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_SOC_NUC970=y
 # CONFIG_MACH_W90P910EVB is not set
 CONFIG_PREEMPT=y
diff --git a/arch/arm/mach-w90x900/Kconfig b/arch/arm/mach-w90x900/Kconfig
index 56f19aac6dab..3cfb29fc2abe 100644
--- a/arch/arm/mach-w90x900/Kconfig
+++ b/arch/arm/mach-w90x900/Kconfig
@@ -1,22 +1,12 @@
-if ARCH_W90X900
+menuconfig ARCH_NUC900
+	bool "Nuvoton CPU_W90P910/NUC9xx support"
+	depends on ARCH_MULTI_V5
 
-config CPU_W90P910
-	bool
-	help
-	  Support for W90P910 of Nuvoton W90X900 CPUs.
-
-config CPU_NUC950
-	bool
-	help
-	  Support for NUCP950 of Nuvoton NUC900 CPUs.
-
-config CPU_NUC960
-	bool
-	help
-	  Support for NUCP960 of Nuvoton NUC900 CPUs.
+if ARCH_NUC900 || ARCH_W90X900_SINGLE
 
 config SOC_NUC970
 	bool "Nuvoton NUC970 SoC support"
+	select ARCH_W90X900
 	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select HAVE_CLK_PREPARE
@@ -35,6 +25,27 @@ config SOC_NUC970
 	  https://github.com/zswan/nuc900-document/blob/master/
 	  NUC970_TechnicalReferenceManual_EN_Rev1.30.pdf
 
+config ARCH_W90X900
+	def_bool ARCH_W90X900_SINGLE || ARCH_NUC900
+
+config CPU_W90P910
+	bool
+	select ARCH_W90X900
+	help
+	  Support for W90P910 of Nuvoton W90X900 CPUs.
+
+config CPU_NUC950
+	bool
+	select ARCH_W90X900
+	help
+	  Support for NUCP950 of Nuvoton NUC900 CPUs.
+
+config CPU_NUC960
+	bool
+	select ARCH_W90X900
+	help
+	  Support for NUCP960 of Nuvoton NUC900 CPUs.
+
 menu "W90P910 Machines"
 
 config MACH_W90P910EVB
diff --git a/arch/arm/mach-w90x900/Makefile b/arch/arm/mach-w90x900/Makefile
index d13ba5adb74b..f93996785494 100644
--- a/arch/arm/mach-w90x900/Makefile
+++ b/arch/arm/mach-w90x900/Makefile
@@ -4,10 +4,12 @@
 
 # Object file lists.
 
-ifeq ($(CONFIG_SOC_NUC970),)
-obj-y				:= irq.o time.o mfp.o gpio.o clock.o
-obj-y				+= clksel.o dev.o cpu.o
+obj-y				+= mfp.o irq.o time.o gpio.o dev.o cpu.o
+
+ifndef CONFIG_COMMON_CLK
+obj-y				+= clksel.o clock.o
 endif
+
 # W90X900 CPU support files
 
 obj-$(CONFIG_CPU_W90P910)	+= nuc910.o
diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 7a9bbc75ad9b..1bc92485eca5 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -52,6 +52,7 @@ static struct map_desc nuc900_iodesc[] __initdata = {
 	IODESC_ENT(GPIO),
 };
 
+#ifndef CONFIG_COMMON_CLK
 /* Initial clock declarations. */
 static DEFINE_CLK(lcd, 0);
 static DEFINE_CLK(audio, 1);
@@ -106,6 +107,7 @@ static struct clk_lookup nuc900_clkregs[] = {
 	DEF_CLKLOOK(&clk_timer3, NULL, "timer3"),
 	DEF_CLKLOOK(&clk_timer4, NULL, "timer4"),
 };
+#endif
 
 /* Initial serial platform data */
 
@@ -122,6 +124,7 @@ struct platform_device nuc900_serial_device = {
 	},
 };
 
+#ifndef CONFIG_COMMON_CLK
 /*Set NUC900 series cpu frequence*/
 static int __init nuc900_set_clkval(unsigned int cpufreq)
 {
@@ -199,6 +202,7 @@ static int __init nuc900_set_cpufreq(char *str)
 }
 
 __setup("cpufreq=", nuc900_set_cpufreq);
+#endif
 
 /*Init NUC900 evb io*/
 
@@ -222,10 +226,12 @@ void __init nuc900_map_io(struct map_desc *mach_desc, int mach_size)
 
 /*Init NUC900 clock*/
 
+#ifndef CONFIG_COMMON_CLK
 void __init nuc900_init_clocks(void)
 {
 	clkdev_add_table(nuc900_clkregs, ARRAY_SIZE(nuc900_clkregs));
 }
+#endif
 
 #define	WTCR	(TMR_BA + 0x1C)
 #define	WTCLK	(1 << 10)
diff --git a/arch/arm/mach-w90x900/cpu.h b/arch/arm/mach-w90x900/cpu.h
index f8730b60bd76..407f5edd8af6 100644
--- a/arch/arm/mach-w90x900/cpu.h
+++ b/arch/arm/mach-w90x900/cpu.h
@@ -46,7 +46,11 @@
 /* extern file from cpu.c */
 
 extern void nuc900_clock_source(struct device *dev, unsigned char *src);
+#ifdef CONFIG_COMMON_CLK
+static inline void nuc900_init_clocks(void) {}
+#else
 extern void nuc900_init_clocks(void);
+#endif
 extern void nuc900_map_io(struct map_desc *mach_desc, int mach_size);
 extern void nuc900_board_init(struct platform_device **device, int size);
 
-- 
2.9.0
