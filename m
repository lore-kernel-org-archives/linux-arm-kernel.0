From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:18 +0900
Subject: [PATCH 02/11] ARM: shmobile: sh73a0: Add Multiplatform support
In-Reply-To: <cover.1425518682.git.horms+renesas@verge.net.au>
References: <cover.1425518682.git.horms+renesas@verge.net.au>
Message-ID: <8e8bffffdaf6b75fb1380bfbb80481d3073086c5.1425518682.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable sh73a0 Multiplatform support for the generic sh73a0
machine vector. No board support is enabled, and the board
code for KZM9G DT Reference is left by itself.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig      | 5 +++++
 arch/arm/mach-shmobile/Makefile     | 4 ++--
 arch/arm/mach-shmobile/smp-sh73a0.c | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2f36c85..8ee2f28 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -78,6 +78,11 @@ config ARCH_R8A7794
 	bool "R-Car E2 (R8A77940)"
 	select ARCH_RCAR_GEN2
 
+config ARCH_SH73A0
+	bool "SH-Mobile AG5 (R8A73A00)"
+	select ARCH_RMOBILE
+	select RENESAS_INTC_IRQPIN
+
 comment "Renesas ARM SoCs Board Type"
 
 config MACH_MARZEN
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index d53996e..b400f5f 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -7,7 +7,7 @@ obj-y				:= timer.o console.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o pm-sh7372.o
-obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o pm-sh73a0.o
+obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
@@ -65,7 +65,7 @@ obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
-obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
+obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o intc-sh73a0.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 endif
 
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index c16dbfe..2106d6b 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -33,7 +33,7 @@
 
 #define SH73A0_SCU_BASE 0xf0000000
 
-#ifdef CONFIG_HAVE_ARM_TWD
+#if defined(CONFIG_HAVE_ARM_TWD) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, SH73A0_SCU_BASE + 0x600, 29);
 void __init sh73a0_register_twd(void)
 {
-- 
2.1.4
