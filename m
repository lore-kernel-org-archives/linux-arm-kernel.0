From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 07 Nov 2013 08:31:25 +0900
Subject: [PATCH 03/03] ARM: shmobile: r7s72100 Genmai Multiplatform
In-Reply-To: <20131106233032.8117.71968.sendpatchset@w520>
References: <20131106233032.8117.71968.sendpatchset@w520>
Message-ID: <20131106233125.8117.70912.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add r7s72100 Genmai to SHMOBILE_MULTI.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/mach-shmobile/Kconfig                  |    7 +++++++
 arch/arm/mach-shmobile/Makefile                 |    1 +
 arch/arm/mach-shmobile/board-genmai-reference.c |    5 +++++
 4 files changed, 14 insertions(+)

--- 0015/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-11-06 19:18:41.000000000 +0900
@@ -216,6 +216,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
+	r7s72100-genmai-reference.dtb \
 	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
--- 0016/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-11-06 19:20:36.000000000 +0900
@@ -20,12 +20,19 @@ comment "SH-Mobile System Type"
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
 
+config ARCH_R7S72100
+	bool "RZ/A1H (R7S72100)"
+
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
 	select RENESAS_IRQC
 
 comment "SH-Mobile Board Type"
 
+config MACH_GENMAI
+	bool "Genmai board"
+	depends on ARCH_R7S72100
+
 config MACH_KOELSCH
 	bool "Koelsch board"
 	depends on ARCH_R8A7791
--- 0016/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-11-06 19:20:59.000000000 +0900
@@ -56,6 +56,7 @@ obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
+obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
 else
--- 0016/arch/arm/mach-shmobile/board-genmai-reference.c
+++ work/arch/arm/mach-shmobile/board-genmai-reference.c	2013-11-06 19:19:53.000000000 +0900
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <mach/common.h>
@@ -27,7 +28,11 @@
 
 static void __init genmai_add_standard_devices(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	of_clk_init(NULL);
+#else
 	r7s72100_clock_init();
+#endif
 	r7s72100_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
