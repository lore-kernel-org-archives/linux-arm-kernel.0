From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Nov 2013 19:40:01 +0900
Subject: [PATCH] ARM: shmobile: Initial r8a7791 and Koelsch multiplatform
 support
Message-ID: <20131106104001.6305.85689.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add Koelsch and r8a7791 to CONFIG_SHMOBILE_MULTI. At this
point CCF is not yet supported so you cannot run this code
yet. For CCF support to happen several different components
are needed, and this is one simple portion that moves us
forward. Other patches need to build on top of this one.

Koelsch board support exists in 3 flavors:
1) SHMOBILE_MULTI, MACH_KOELSCH - board-koelsch-reference.c (CCF + DT)
2) SHMOBILE, MACH_KOELSCH_REFERENCE - board-koelsch-reference.c (DT)
3) SHMOBILE, MACH_KOELSCH - board-koelsch.c (legacy C code)

When CCF is done then 2) will be removed. When 1) includes same features
as 3) then 3) will be removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Built against "renesas-devel-v3.12-rc7-20131101"

 arch/arm/boot/dts/Makefile                       |    3 ++-
 arch/arm/mach-shmobile/Kconfig                   |    8 ++++++++
 arch/arm/mach-shmobile/Makefile                  |    1 +
 arch/arm/mach-shmobile/board-koelsch-reference.c |    5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/Makefile
+++ work/arch/arm/boot/dts/Makefile	2013-11-06 19:06:45.000000000 +0900
@@ -214,7 +214,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm
 	r8a73a4-ape6evm.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
+	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
--- 0008/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-11-06 19:07:10.000000000 +0900
@@ -20,8 +20,16 @@ comment "SH-Mobile System Type"
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
 
+config ARCH_R8A7791
+	bool "R-Car M2 (R8A77910)"
+	select RENESAS_IRQC
+
 comment "SH-Mobile Board Type"
 
+config MACH_KOELSCH
+	bool "Koelsch board"
+	depends on ARCH_R8A7791
+
 config MACH_KZM9D
 	bool "KZM9D board"
 	depends on ARCH_EMEV2
--- 0004/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-11-06 19:07:22.000000000 +0900
@@ -56,6 +56,7 @@ obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
+obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
--- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2013-11-06 19:09:52.000000000 +0900
@@ -19,6 +19,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <mach/rcar-gen2.h>
@@ -27,7 +28,11 @@
 
 static void __init koelsch_add_standard_devices(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	of_clk_init(NULL);
+#else
 	r8a7791_clock_init();
+#endif
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
