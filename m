From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 14:43:59 +0900
Subject: [PATCH 03/04] ARM: shmobile: Add EMEV2 and KZM9D to
 ARCH_SHMOBILE_MULTI
In-Reply-To: <20130709054331.14007.66068.sendpatchset@w520>
References: <20130709054331.14007.66068.sendpatchset@w520>
Message-ID: <20130709054359.14007.23619.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable build of EMEV2 and KZM9D DT Reference in
case of ARCH_MULTIPLATFORM and ARCH_SHMOBILE_MULTI.

A weak symbol covers the case when the clock-emev2.c
file is not built when COMMON_CLK=y.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile           |    1 +
 arch/arm/mach-shmobile/Kconfig       |   15 +++++++++++++++
 arch/arm/mach-shmobile/setup-emev2.c |    5 +++++
 3 files changed, 21 insertions(+)

--- 0002/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-07-09 13:10:52.000000000 +0900
@@ -171,6 +171,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
 	sh73a0-kzm9g-reference.dtb \
 	r8a73a4-ape6evm.dtb \
 	sh7372-mackerel.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
--- 0004/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-07-09 13:03:45.000000000 +0900
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
--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-07-09 13:03:45.000000000 +0900
@@ -190,6 +190,11 @@ void __init emev2_add_standard_devices(v
 	emev2_register_pmu();
 }
 
+void __init __weak emev2_clock_init(void)
+{
+	/* in case legacy clocks are disabled then do nothing */
+}
+
 void __init emev2_init_delay(void)
 {
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
