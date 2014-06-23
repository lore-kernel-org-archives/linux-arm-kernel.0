From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:21 +0900
Subject: [PATCH 08/24] ARM: shmobile: r8a7779: Initial multiplatform support
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <5016c81bf92eb01741fc71ce7fb8380183a6f66a.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Marzen and r8a7779 to CONFIG_SHMOBILE_MULTI. At this
point CCF is not yet supported so you cannot run this code
yet. For CCF support to happen several different components
are needed, and this is one simple portion that moves us
forward. Other patches need to build on top of this one.

Marzen board support exists in 3 flavours:
1) SHMOBILE_MULTI, MACH_MARZEN - board-marzen-reference.c (CCF + DT)
2) SHMOBILE, MACH_MARZEN_REFERENCE - board-marzen-reference.c (DT)
3) SHMOBILE, MACH_MARZEN - board-marzen.c (legacy C code)

When CCF is done then 2) will be removed. When 1) includes same features
as 3) then 3) will be removed.

Based on work for the Koelsch and r8a7791 by Magnus Damm.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      |  3 ++-
 arch/arm/mach-shmobile/Kconfig                  | 10 ++++++++++
 arch/arm/mach-shmobile/Makefile                 |  1 +
 arch/arm/mach-shmobile/board-marzen-reference.c |  5 +++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5986ff6..f44df11 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -339,7 +339,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
-	r8a7790-lager.dtb
+	r8a7790-lager.dtb \
+	r8a7779-marzen-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index dbd954e..d7f8285 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -25,6 +25,11 @@ config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 	select SYS_SUPPORTS_SH_MTU2
 
+config ARCH_R8A7779
+	bool "R-Car H1 (R8A77790)"
+	select RENESAS_INTC_IRQPIN
+	select SYS_SUPPORTS_SH_TMU
+
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
 	select RENESAS_IRQC
@@ -51,6 +56,11 @@ config MACH_LAGER
 	depends on ARCH_R8A7790
 	select MICREL_PHY if SH_ETH
 
+config MACH_MARZEN
+	bool "MARZEN board"
+	depends on ARCH_R8A7779
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+
 comment "Renesas ARM SoCs System Configuration"
 endif
 
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 38d5fe8..2309906 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -59,6 +59,7 @@ ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
+obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 46ed17a..d90843b 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -19,6 +19,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk-provider.h>
 #include <linux/of_platform.h>
 #include <mach/r8a7779.h>
 #include <asm/irq.h>
@@ -28,7 +29,11 @@
 
 static void __init marzen_init(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	of_clk_init(NULL);
+#else
 	r8a7779_clock_init();
+#endif
 	r8a7779_add_standard_devices_dt();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
-- 
2.0.0.rc2
