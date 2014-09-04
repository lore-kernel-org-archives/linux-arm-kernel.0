From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:34 +0900
Subject: [PATCH 3/9] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen2
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
Message-ID: <0d91843346049d3131c2f75ff21d6b405cb68741.1409792454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a Kconfig entry for R-Car Generation 2 SoCs that
enables CMT timer and the IRQC interrupt driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig  | 17 +++++++++--------
 arch/arm/mach-shmobile/Makefile | 12 ++++++------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 258d730..73d6d3d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -6,6 +6,11 @@ config ARCH_RCAR_GEN1
 	select RENESAS_INTC_IRQPIN
 	select SYS_SUPPORTS_SH_TMU
 
+config ARCH_RCAR_GEN2
+	bool
+	select RENESAS_IRQC
+	select SYS_SUPPORTS_SH_CMT
+
 config ARCH_RMOBILE
 	bool
 	select SYS_SUPPORTS_SH_CMT
@@ -42,13 +47,11 @@ config ARCH_R8A7779
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
+	select ARCH_RCAR_GEN2
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
+	select ARCH_RCAR_GEN2
 
 comment "Renesas ARM SoCs Board Type"
 
@@ -134,24 +137,22 @@ config ARCH_R8A7779
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
+	select ARCH_RCAR_GEN2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
+	select ARCH_RCAR_GEN2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
 	select MIGHT_HAVE_PCI
 	select SH_CLK_CPG
-	select RENESAS_IRQC
-	select SYS_SUPPORTS_SH_CMT
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
 config ARCH_R7S72100
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fe3878a..ddc91fd 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -15,8 +15,7 @@ obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
-obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o setup-rcar-gen2.o
-obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o setup-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
@@ -36,8 +35,9 @@ endif
 
 # CPU reset vector handling objects
 cpu-y				:= platsmp.o headsmp.o
-cpu-$(CONFIG_ARCH_R8A7790)	+= platsmp-apmu.o
-cpu-$(CONFIG_ARCH_R8A7791)	+= platsmp-apmu.o
+
+# Shared SoC family objects
+obj-$(CONFIG_ARCH_RCAR_GEN2)	+= setup-rcar-gen2.o platsmp-apmu.o $(cpu-y)
 
 # SMP objects
 smp-y				:= $(cpu-y)
@@ -55,8 +55,8 @@ obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
-obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o $(cpu-y)
-obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o $(cpu-y)
+obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
+obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o
 
 # IRQ objects
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
-- 
2.0.1
