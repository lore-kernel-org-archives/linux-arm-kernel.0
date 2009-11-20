From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 20 Nov 2009 14:42:35 +0100
Subject: [PATCH 03/20] ARM: S5PC1XX: prepare common cpu&clocks code for S5PC110
	sub-platform
In-Reply-To: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258724572-19176-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

CLK_OTHER register block is specific for S5PC100 SoC, so move the
definition to mach-s5pc100/cpu.c. Size of CLK and PWR register block is
different on S5PC100 and S5PC110, thus new defines are introduced.

Clock and pll hierarchy is completely different between S5PC100 and
S5PC110 SoCs, so move related includes to new sub-platform and rename
plat-s5pc1xx/clocks.c and plat-s5pc1xx/s5pc100-clock.c to
s5pc100-clocks.c (periperal clocks definition) and s5pc100-plls.c (core
pll hierarchy definition).

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig                      |    2 --
 arch/arm/mach-s5pc100/Makefile                     |    3 +++
 .../clock.c => mach-s5pc100/clocks.c}              |    4 ++--
 arch/arm/mach-s5pc100/cpu.c                        |    6 ++++++
 arch/arm/mach-s5pc100/include/mach/map.h           |    2 ++
 .../include/plat/regs-clock.h                      |    2 +-
 .../include/plat/regs-power.h                      |    2 +-
 .../s5pc100-clock.c => mach-s5pc100/plls.c}        |    2 +-
 .../s5pc100-init.c => mach-s5pc100/uarts.c}        |    2 +-
 arch/arm/plat-s5pc1xx/Kconfig                      |   12 +-----------
 arch/arm/plat-s5pc1xx/Makefile                     |    4 ----
 arch/arm/plat-s5pc1xx/cpu.c                        |   18 ++++++------------
 12 files changed, 24 insertions(+), 35 deletions(-)
 rename arch/arm/{plat-s5pc1xx/clock.c => mach-s5pc100/clocks.c} (99%)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/include/plat/regs-clock.h (99%)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/include/plat/regs-power.h (98%)
 rename arch/arm/{plat-s5pc1xx/s5pc100-clock.c => mach-s5pc100/plls.c} (99%)
 rename arch/arm/{plat-s5pc1xx/s5pc100-init.c => mach-s5pc100/uarts.c} (94%)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index d72f881..1dbb5f1 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -11,8 +11,6 @@ if ARCH_S5PC100
 
 config CPU_S5PC100
 	bool
-	select CPU_S5PC100_INIT
-	select CPU_S5PC100_CLOCK
 	help
 	  Enable S5PC100 CPU support
 
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 809ff10..dc6b0ff 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -12,6 +12,9 @@ obj-				:=
 # Core support for S5PC100 system
 
 obj-$(CONFIG_CPU_S5PC100)	+= cpu.o
+obj-$(CONFIG_CPU_S5PC100)	+= clocks.o
+obj-$(CONFIG_CPU_S5PC100)	+= plls.o
+obj-$(CONFIG_CPU_S5PC100)	+= uarts.o
 
 # Helper and device support
 
diff --git a/arch/arm/plat-s5pc1xx/clock.c b/arch/arm/mach-s5pc100/clocks.c
similarity index 99%
rename from arch/arm/plat-s5pc1xx/clock.c
rename to arch/arm/mach-s5pc100/clocks.c
index 26c21d8..a191beb 100644
--- a/arch/arm/plat-s5pc1xx/clock.c
+++ b/arch/arm/mach-s5pc100/clocks.c
@@ -1,8 +1,8 @@
-/* linux/arch/arm/plat-s5pc1xx/clock.c
+/* linux/arch/arm/mach-s5pc100/clocks.c
  *
  * Copyright 2009 Samsung Electronics Co.
  *
- * S5PC1XX Base clock support
+ * S5PC100 - Clocks support
  *
  * Based on plat-s3c64xx/clock.c
  *
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index d79e757..41fdecf 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -46,6 +46,12 @@
 /* Initial IO mappings */
 
 static struct map_desc s5pc100_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5PC1XX_VA_CLK_OTHER,
+		.pfn		= __phys_to_pfn(S5PC1XX_PA_CLK_OTHER),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}
 };
 
 static void s5pc100_idle(void)
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index f90c033..88f267a 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -46,6 +46,8 @@
 #define S5PC1XX_VA_CLK		(S3C_VA_SYS + 0x10000)
 #define S5PC1XX_VA_PWR		(S3C_VA_SYS + 0x20000)
 #define S5PC1XX_VA_CLK_OTHER	(S3C_VA_SYS + 0x30000)
+#define S5PC1XX_SZ_CLK		SZ_4K
+#define S5PC1XX_SZ_PWR		SZ_4K
 
 /* GPIO */
 #define S5PC100_PA_GPIO		(0xE0300000)
diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h b/arch/arm/mach-s5pc100/include/plat/regs-clock.h
similarity index 99%
rename from arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
rename to arch/arm/mach-s5pc100/include/plat/regs-clock.h
index c5cc86e..f0a007b 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/regs-clock.h
+++ b/arch/arm/mach-s5pc100/include/plat/regs-clock.h
@@ -3,7 +3,7 @@
  * Copyright 2009 Samsung Electronics Co.
  *	Byungho Min <bhmin@samsung.com>
  *
- * S5PC1XX clock register definitions
+ * S5PC100 clock register definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-power.h b/arch/arm/mach-s5pc100/include/plat/regs-power.h
similarity index 98%
rename from arch/arm/plat-s5pc1xx/include/plat/regs-power.h
rename to arch/arm/mach-s5pc100/include/plat/regs-power.h
index 02ffa49..50a9679 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/regs-power.h
+++ b/arch/arm/mach-s5pc100/include/plat/regs-power.h
@@ -3,7 +3,7 @@
  * Copyright 2009 Samsung Electronics Co.
  *	Jongse Won <jongse.won@samsung.com>
  *
- * S5PC1XX clock register definitions
+ * S5PC100 power controll register definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/plat-s5pc1xx/s5pc100-clock.c b/arch/arm/mach-s5pc100/plls.c
similarity index 99%
rename from arch/arm/plat-s5pc1xx/s5pc100-clock.c
rename to arch/arm/mach-s5pc100/plls.c
index b436d44..cd3f6a7 100644
--- a/arch/arm/plat-s5pc1xx/s5pc100-clock.c
+++ b/arch/arm/mach-s5pc100/plls.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5pc1xx/s5pc100-clock.c
+/* linux/arch/arm/mach-s5pc100/s5pc100-plls.c
  *
  * Copyright 2009 Samsung Electronics, Co.
  *	Byungho Min <bhmin@samsung.com>
diff --git a/arch/arm/plat-s5pc1xx/s5pc100-init.c b/arch/arm/mach-s5pc100/uarts.c
similarity index 94%
rename from arch/arm/plat-s5pc1xx/s5pc100-init.c
rename to arch/arm/mach-s5pc100/uarts.c
index c587108..32972f2 100644
--- a/arch/arm/plat-s5pc1xx/s5pc100-init.c
+++ b/arch/arm/mach-s5pc100/uarts.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5pc1xx/s5pc100-init.c
+/* linux/arch/arm/mach-s5pc100/uarts.c
  *
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index eee2abb..7131ce9 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -33,17 +33,7 @@ config ARCH_S5PC100
 endchoice
 
 
-# Configuration options shared by all S3C64XX implementations
-
-config CPU_S5PC100_INIT
-	bool
-	help
-	  Common initialisation code for the S5PC1XX
-
-config CPU_S5PC100_CLOCK
-	bool
-	help
-	  Common clock support code for the S5PC1XX
+# configuration options shared by all S5PC1XX implementations
 
 # platform specific device setup
 
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index 278f268..39dd0a1 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -14,14 +14,10 @@ obj-				:=
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= irq.o irq-gpio.o irq-eint.o
-obj-y				+= clock.o
 obj-y				+= gpiolib.o
 
 # CPU support
 
-obj-$(CONFIG_CPU_S5PC100_INIT)	+= s5pc100-init.o
-obj-$(CONFIG_CPU_S5PC100_CLOCK)	+= s5pc100-clock.o
-
 # Device setup
 
 obj-$(CONFIG_S5P_GPIO_CFG_S5PC1XX) += gpio-config.o
diff --git a/arch/arm/plat-s5pc1xx/cpu.c b/arch/arm/plat-s5pc1xx/cpu.c
index 02baeaa..ecd6d38 100644
--- a/arch/arm/plat-s5pc1xx/cpu.c
+++ b/arch/arm/plat-s5pc1xx/cpu.c
@@ -50,18 +50,11 @@ static struct cpu_table cpu_ids[] __initdata = {
 };
 /* minimal IO mapping */
 
-/* see notes on uart map in arch/arm/mach-s5pc100/include/mach/debug-macro.S */
-#define UART_OFFS (S3C_PA_UART & 0xffff)
 
 static struct map_desc s5pc1xx_iodesc[] __initdata = {
 	{
-		.virtual	= (unsigned long)S5PC1XX_VA_CLK_OTHER,
-		.pfn		= __phys_to_pfn(S5PC1XX_PA_CLK_OTHER),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5PC1XX_VA_GPIO,
-		.pfn		= __phys_to_pfn(S5PC100_PA_GPIO),
+		.pfn		= __phys_to_pfn(S5PC1XX_PA_GPIO),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
@@ -72,15 +65,15 @@ static struct map_desc s5pc1xx_iodesc[] __initdata = {
 	}, {
 		.virtual	= (unsigned long)S5PC1XX_VA_CLK,
 		.pfn		= __phys_to_pfn(S5PC1XX_PA_CLK),
-		.length		= SZ_4K,
+		.length		= S5PC1XX_SZ_CLK,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)S5PC1XX_VA_PWR,
 		.pfn		= __phys_to_pfn(S5PC1XX_PA_PWR),
-		.length		= SZ_4K,
+		.length		= S5PC1XX_SZ_PWR,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)(S5PC1XX_VA_UART),
+		.virtual	= (unsigned long)S5PC1XX_VA_UART,
 		.pfn		= __phys_to_pfn(S5PC1XX_PA_UART),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
@@ -115,8 +108,9 @@ void __init s5pc1xx_init_io(struct map_desc *mach_desc, int size)
 
 	/* initialise the io descriptors we need for initialisation */
 	iotable_init(s5pc1xx_iodesc, ARRAY_SIZE(s5pc1xx_iodesc));
-	iotable_init(mach_desc, size);
 
 	idcode = __raw_readl(S5PC1XX_VA_CHIPID);
 	s3c_init_cpu(idcode, cpu_ids, ARRAY_SIZE(cpu_ids));
+
+	iotable_init(mach_desc, size);
 }
-- 
1.6.4
