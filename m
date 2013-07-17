From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 18 Jul 2013 05:31:18 +0900
Subject: [PATCH v2 03/04] ARM: shmobile: Add EMEV2 and KZM9D to
 ARCH_SHMOBILE_MULTI
In-Reply-To: <20130717203049.27542.78385.sendpatchset@w520>
References: <20130717203049.27542.78385.sendpatchset@w520>
Message-ID: <20130717203118.27542.37940.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable build of EMEV2 and KZM9D DT Reference in
case of ARCH_MULTIPLATFORM and ARCH_SHMOBILE_MULTI.

IS_ENABLED() is leaves the clock-emev2.c file out
in case of COMMON_CLK=y.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - use IS_ENABLED() instead of weak symbol, thanks Arnd!

 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/mach-shmobile/Kconfig                 |   15 +++++++++++++++
 arch/arm/mach-shmobile/board-kzm9d-reference.c |    3 ++-
 arch/arm/mach-shmobile/setup-emev2.c           |    3 ++-
 4 files changed, 20 insertions(+), 2 deletions(-)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-07-18 05:06:46.000000000 +0900
@@ -195,6 +195,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
 	r8a73a4-ape6evm.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
--- 0003/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-07-18 05:06:46.000000000 +0900
@@ -17,6 +17,21 @@ if ARCH_SHMOBILE_MULTI
 
 comment "SH-Mobile System Type"
 
+config ARCH_EMEV2
+	bool "Emma Mobile EV2"
+
+comment "SH-Mobile Board Type"
+
+config MACH_KZM9D_REFERENCE
+	bool "KZM9D board - Reference Device Tree Implementation"
+	depends on ARCH_EMEV2
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	---help---
+	   Use reference implementation of KZM9D board support
+	   which makes a greater use of device tree at the expense
+	   of not supporting a number of devices.
+
+	   This is intended to aid developers
 endif
 
 if ARCH_SHMOBILE
--- 0001/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9d-reference.c	2013-07-18 05:12:08.000000000 +0900
@@ -26,7 +26,8 @@
 
 static void __init kzm9d_add_standard_devices(void)
 {
-	emev2_clock_init();
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		emev2_clock_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-07-18 05:12:17.000000000 +0900
@@ -175,7 +175,8 @@ static struct resource pmu_resources[] =
 
 void __init emev2_add_standard_devices(void)
 {
-	emev2_clock_init();
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		emev2_clock_init();
 
 	emev2_register_uart(0);
 	emev2_register_uart(1);
