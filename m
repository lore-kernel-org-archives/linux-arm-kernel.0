From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:18:08 +0900
Subject: [PATCH 04/12] ARM: shmobile: lager-reference: Enable multiplaform
 kernel support
In-Reply-To: <cover.1387891831.git.horms+renesas@verge.net.au>
References: <cover.1387891831.git.horms+renesas@verge.net.au>
Message-ID: <0ef3cde4d906041a497bfc585568a45ae84b4a8f.1387891831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Enable multiplaform ARM architecture support for the Lager reference
board. Common clock framework initialization will be handled by the
rcar_gen2_init_timer() call, we just need to remove the legacy clock
code initialization.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                     | 1 +
 arch/arm/mach-shmobile/Kconfig                 | 8 ++++++++
 arch/arm/mach-shmobile/Makefile                | 1 +
 arch/arm/mach-shmobile/board-lager-reference.c | 2 ++
 4 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5ef42fc..9e22bd4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -235,6 +235,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
+	r8a7790-lager-reference.dtb \
 	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index cd89d63..e7033a8 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -28,6 +28,10 @@ config ARCH_EMEV2
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 
+config ARCH_R8A7790
+	bool "R-Car H2 (R8A77900)"
+	select RENESAS_IRQC
+
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
 	select RENESAS_IRQC
@@ -47,6 +51,10 @@ config MACH_KZM9D
 	depends on ARCH_EMEV2
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
+config MACH_LAGER
+	bool "Lager board"
+	depends on ARCH_R8A7790
+
 comment "Renesas ARM SoCs System Configuration"
 endif
 
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 1c13104..9daa9c1 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -59,6 +59,7 @@ ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
+obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 51a3bcc..fc43f7c 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -27,7 +27,9 @@
 
 static void __init lager_add_standard_devices(void)
 {
+#ifndef CONFIG_COMMON_CLK
 	r8a7790_clock_init();
+#endif
 	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.8.4
