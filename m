From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:06 +0100
Subject: [PATCH 11/39] arm/mx2: split generic.c into mm-imx2[17].c
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes some #ifdefs and prepares moving the files in a directory
with more than imx21 and imx27 support.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/Makefile                  |    7 ++--
 arch/arm/mach-mx2/{generic.c => mm-imx21.c} |   46 +++++++++-----------------
 arch/arm/mach-mx2/{generic.c => mm-imx27.c} |   44 +++++++++-----------------
 3 files changed, 34 insertions(+), 63 deletions(-)
 copy arch/arm/mach-mx2/{generic.c => mm-imx21.c} (66%)
 rename arch/arm/mach-mx2/{generic.c => mm-imx27.c} (67%)

diff --git a/arch/arm/mach-mx2/Makefile b/arch/arm/mach-mx2/Makefile
index ce10d41..e3254fa 100644
--- a/arch/arm/mach-mx2/Makefile
+++ b/arch/arm/mach-mx2/Makefile
@@ -4,13 +4,12 @@
 
 # Object file lists.
 
-obj-y	:=  generic.o devices.o serial.o
-CFLAGS_generic.o = -DIMX_NEEDS_DEPRECATED_SYMBOLS
+obj-y	:=  devices.o serial.o
 
-obj-$(CONFIG_MACH_MX21) += clock_imx21.o
+obj-$(CONFIG_MACH_MX21) += clock_imx21.o mm-imx21.o
 
 obj-$(CONFIG_MACH_MX27) += cpu_imx27.o
-obj-$(CONFIG_MACH_MX27) += clock_imx27.o
+obj-$(CONFIG_MACH_MX27) += clock_imx27.o mm-imx27.o
 
 obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
 obj-$(CONFIG_MACH_MX27ADS) += mach-mx27ads.o
diff --git a/arch/arm/mach-mx2/generic.c b/arch/arm/mach-mx2/mm-imx21.c
similarity index 66%
copy from arch/arm/mach-mx2/generic.c
copy to arch/arm/mach-mx2/mm-imx21.c
index ae8f759..6413431 100644
--- a/arch/arm/mach-mx2/generic.c
+++ b/arch/arm/mach-mx2/mm-imx21.c
@@ -1,5 +1,5 @@
 /*
- * generic.c
+ * arch/arm/mach-mx2/mm-imx21.c
  *
  * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
  *
@@ -25,8 +25,8 @@
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 
-/* MX27 memory map definition */
-static struct map_desc mxc_io_desc[] __initdata = {
+/* MX21 memory map definition */
+static struct map_desc imx21_io_desc[] __initdata = {
 	/*
 	 * this fixed mapping covers:
 	 * - AIPI1
@@ -36,9 +36,9 @@ static struct map_desc mxc_io_desc[] __initdata = {
 	 * - and some reserved space
 	 */
 	{
-		.virtual = AIPI_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(AIPI_BASE_ADDR),
-		.length = AIPI_SIZE,
+		.virtual = MX21_AIPI_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX21_AIPI_BASE_ADDR),
+		.length = MX21_AIPI_SIZE,
 		.type = MT_DEVICE
 	},
 	/*
@@ -47,9 +47,9 @@ static struct map_desc mxc_io_desc[] __initdata = {
 	 * - ATA
 	 */
 	{
-		.virtual = SAHB1_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(SAHB1_BASE_ADDR),
-		.length = SAHB1_SIZE,
+		.virtual = MX21_SAHB1_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX21_SAHB1_BASE_ADDR),
+		.length = MX21_SAHB1_SIZE,
 		.type = MT_DEVICE
 	},
 	/*
@@ -57,11 +57,11 @@ static struct map_desc mxc_io_desc[] __initdata = {
 	 * - EMI
 	 */
 	{
-		.virtual = X_MEMC_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(X_MEMC_BASE_ADDR),
-		.length = X_MEMC_SIZE,
+		.virtual = MX21_X_MEMC_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX21_X_MEMC_BASE_ADDR),
+		.length = MX21_X_MEMC_SIZE,
 		.type = MT_DEVICE
-	}
+	},
 };
 
 /*
@@ -72,26 +72,12 @@ static struct map_desc mxc_io_desc[] __initdata = {
 void __init mx21_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX21);
-	mxc_arch_reset_init(IO_ADDRESS(WDOG_BASE_ADDR));
-
-	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
-}
-
-void __init mx27_map_io(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX27);
-	mxc_arch_reset_init(IO_ADDRESS(WDOG_BASE_ADDR));
+	mxc_arch_reset_init(MX21_IO_ADDRESS(MX21_WDOG_BASE_ADDR));
 
-	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
-}
-
-void __init mx27_init_irq(void)
-{
-	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
+	iotable_init(imx21_io_desc, ARRAY_SIZE(imx21_io_desc));
 }
 
 void __init mx21_init_irq(void)
 {
-	mx27_init_irq();
+	mxc_init_irq(MX21_IO_ADDRESS(MX21_AVIC_BASE_ADDR));
 }
-
diff --git a/arch/arm/mach-mx2/generic.c b/arch/arm/mach-mx2/mm-imx27.c
similarity index 67%
rename from arch/arm/mach-mx2/generic.c
rename to arch/arm/mach-mx2/mm-imx27.c
index ae8f759..3366ed4 100644
--- a/arch/arm/mach-mx2/generic.c
+++ b/arch/arm/mach-mx2/mm-imx27.c
@@ -1,5 +1,5 @@
 /*
- * generic.c
+ * arch/arm/mach-mx2/mm-imx27.c
  *
  * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
  *
@@ -26,7 +26,7 @@
 #include <asm/mach/map.h>
 
 /* MX27 memory map definition */
-static struct map_desc mxc_io_desc[] __initdata = {
+static struct map_desc imx27_io_desc[] __initdata = {
 	/*
 	 * this fixed mapping covers:
 	 * - AIPI1
@@ -36,9 +36,9 @@ static struct map_desc mxc_io_desc[] __initdata = {
 	 * - and some reserved space
 	 */
 	{
-		.virtual = AIPI_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(AIPI_BASE_ADDR),
-		.length = AIPI_SIZE,
+		.virtual = MX27_AIPI_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX27_AIPI_BASE_ADDR),
+		.length = MX27_AIPI_SIZE,
 		.type = MT_DEVICE
 	},
 	/*
@@ -47,9 +47,9 @@ static struct map_desc mxc_io_desc[] __initdata = {
 	 * - ATA
 	 */
 	{
-		.virtual = SAHB1_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(SAHB1_BASE_ADDR),
-		.length = SAHB1_SIZE,
+		.virtual = MX27_SAHB1_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX27_SAHB1_BASE_ADDR),
+		.length = MX27_SAHB1_SIZE,
 		.type = MT_DEVICE
 	},
 	/*
@@ -57,11 +57,11 @@ static struct map_desc mxc_io_desc[] __initdata = {
 	 * - EMI
 	 */
 	{
-		.virtual = X_MEMC_BASE_ADDR_VIRT,
-		.pfn = __phys_to_pfn(X_MEMC_BASE_ADDR),
-		.length = X_MEMC_SIZE,
+		.virtual = MX27_X_MEMC_BASE_ADDR_VIRT,
+		.pfn = __phys_to_pfn(MX27_X_MEMC_BASE_ADDR),
+		.length = MX27_X_MEMC_SIZE,
 		.type = MT_DEVICE
-	}
+	},
 };
 
 /*
@@ -69,29 +69,15 @@ static struct map_desc mxc_io_desc[] __initdata = {
  * system startup to create static physical to virtual
  * memory map for the IO modules.
  */
-void __init mx21_map_io(void)
-{
-	mxc_set_cpu_type(MXC_CPU_MX21);
-	mxc_arch_reset_init(IO_ADDRESS(WDOG_BASE_ADDR));
-
-	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
-}
-
 void __init mx27_map_io(void)
 {
 	mxc_set_cpu_type(MXC_CPU_MX27);
-	mxc_arch_reset_init(IO_ADDRESS(WDOG_BASE_ADDR));
+	mxc_arch_reset_init(MX27_IO_ADDRESS(MX27_WDOG_BASE_ADDR));
 
-	iotable_init(mxc_io_desc, ARRAY_SIZE(mxc_io_desc));
+	iotable_init(imx27_io_desc, ARRAY_SIZE(imx27_io_desc));
 }
 
 void __init mx27_init_irq(void)
 {
-	mxc_init_irq(IO_ADDRESS(AVIC_BASE_ADDR));
+	mxc_init_irq(MX27_IO_ADDRESS(MX27_AVIC_BASE_ADDR));
 }
-
-void __init mx21_init_irq(void)
-{
-	mx27_init_irq();
-}
-
-- 
1.6.6.2
