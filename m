From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:09 +0900
Subject: [PATCH 13/26] ARM: shmobile: r7s72100 Genmai Multiplatform
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <7d91c4691207a302c50308ab38706b8a3d6039cd.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add r7s72100 Genmai to SHMOBILE_MULTI.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      | 1 +
 arch/arm/mach-shmobile/Kconfig                  | 7 +++++++
 arch/arm/mach-shmobile/Makefile                 | 1 +
 arch/arm/mach-shmobile/board-genmai-reference.c | 5 +++++
 4 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b17de79..5ef42fc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -234,6 +234,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
+	r7s72100-genmai-reference.dtb \
 	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8bc7308..bb0837b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -24,12 +24,19 @@ comment "SH-Mobile System Type"
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
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index d2b8342..1c13104 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
+obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
 else
diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 34c9881..7630c10 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
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
-- 
1.8.4
