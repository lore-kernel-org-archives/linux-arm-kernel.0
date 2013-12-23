From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:06 +0900
Subject: [PATCH 10/26] ARM: shmobile: Initial r8a7791 and Koelsch
 multiplatform support
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <6d75bc6439ec3f4ae45db1e501177382d0582591.1387763524.git.horms+renesas@verge.net.au>
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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                       | 3 ++-
 arch/arm/mach-shmobile/Kconfig                   | 8 ++++++++
 arch/arm/mach-shmobile/Makefile                  | 1 +
 arch/arm/mach-shmobile/board-koelsch-reference.c | 5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5839077..8254bfc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -232,7 +232,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
+	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8eac47f..17a4f40 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -24,8 +24,16 @@ comment "SH-Mobile System Type"
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
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 8bca9b5..021775d 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
+obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index beecc8b..25b558f 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
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
-- 
1.8.4
