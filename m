From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 14:24:13 +0900
Subject: [PATCH 3/4] ARM: shmobile: Add EMEV2 and KZM9D to ARCH_SHMOBILE_MULTI
In-Reply-To: <cover.1375161473.git.horms+renesas@verge.net.au>
References: <cover.1375161473.git.horms+renesas@verge.net.au>
Message-ID: <cbc60e7c04f3c1390144d4a881f0a7b98b49da98.1375161473.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable build of EMEV2 and KZM9D DT Reference in
case of ARCH_MULTIPLATFORM and ARCH_SHMOBILE_MULTI.

IS_ENABLED() is leaves the clock-emev2.c file out
in case of COMMON_CLK=y.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                     |  1 +
 arch/arm/mach-shmobile/Kconfig                 | 15 +++++++++++++++
 arch/arm/mach-shmobile/board-kzm9d-reference.c |  3 ++-
 arch/arm/mach-shmobile/setup-emev2.c           |  3 ++-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index af19e38..f3861de 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -193,6 +193,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	sh73a0-kzm9g-reference.dtb \
 	r8a73a4-ape6evm.dtb \
 	sh7372-mackerel.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4c54298..8914c9b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
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
diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
index a7b28b2..8f8bb2f 100644
--- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
@@ -26,7 +26,8 @@
 
 static void __init kzm9d_add_standard_devices(void)
 {
-	emev2_clock_init();
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		emev2_clock_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 19980be..1553af8 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -175,7 +175,8 @@ static struct resource pmu_resources[] = {
 
 void __init emev2_add_standard_devices(void)
 {
-	emev2_clock_init();
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		emev2_clock_init();
 
 	emev2_register_uart(0);
 	emev2_register_uart(1);
-- 
1.8.3.2
