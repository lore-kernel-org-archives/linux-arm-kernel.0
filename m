From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 11 Oct 2018 10:55:08 +0200
Subject: [PATCH 2/2] [RFC] ARM: shmobile: Move SoC Kconfig symbols to
 drivers/soc/renesas/
In-Reply-To: <20181011085508.5234-1-geert+renesas@glider.be>
References: <20181011085508.5234-1-geert+renesas@glider.be>
Message-ID: <20181011085508.5234-3-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with arm64, where vendors have a single Kconfig symbol
in arch/arm64/Kconfig.platforms.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Note that drivers/clk/ is included before drivers/soc/.  Hence when
COMPILE_TEST=y, questions will be asked about clock drivers before they
can be auto-selected by SoC support.

Question: Should the family-specific Kconfig symbols be moved, too?
	  Not much would be left in arch/arm/mach-shmobile/Kconfig,
	  though.
---
 arch/arm/mach-shmobile/Kconfig | 101 ---------------------------
 drivers/soc/renesas/Kconfig    | 120 ++++++++++++++++++++++++++++++---
 2 files changed, 112 insertions(+), 109 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index b100c26a858f9015..50267ad76f990f11 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -36,104 +36,3 @@ menuconfig ARCH_RENESAS
 	select PINCTRL
 	select SOC_BUS
 	select ZONE_DMA if ARM_LPAE
-
-if ARCH_RENESAS
-
-#comment "Renesas ARM SoCs System Type"
-
-config ARCH_EMEV2
-	bool "Emma Mobile EV2"
-	select SYS_SUPPORTS_EM_STI
-
-config ARCH_R7S72100
-	bool "RZ/A1H (R7S72100)"
-	select PM
-	select PM_GENERIC_DOMAINS
-	select SYS_SUPPORTS_SH_MTU2
-	select RENESAS_OSTM
-
-config ARCH_R7S9210
-	bool "RZ/A2 (R7S9210)"
-	select PM
-	select PM_GENERIC_DOMAINS
-	select RENESAS_OSTM
-
-config ARCH_R8A73A4
-	bool "R-Mobile APE6 (R8A73A40)"
-	select ARCH_RMOBILE
-	select ARM_ERRATA_798181 if SMP
-	select HAVE_ARM_ARCH_TIMER
-	select RENESAS_IRQC
-
-config ARCH_R8A7740
-	bool "R-Mobile A1 (R8A77400)"
-	select ARCH_RMOBILE
-	select RENESAS_INTC_IRQPIN
-
-config ARCH_R8A7743
-	bool "RZ/G1M (R8A77430)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-
-config ARCH_R8A7744
-	bool "RZ/G1N (R8A77440)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-
-config ARCH_R8A7745
-	bool "RZ/G1E (R8A77450)"
-	select ARCH_RCAR_GEN2
-
-config ARCH_R8A77470
-	bool "RZ/G1C (R8A77470)"
-	select ARCH_RCAR_GEN2
-
-config ARCH_R8A7778
-	bool "R-Car M1A (R8A77781)"
-	select ARCH_RCAR_GEN1
-
-config ARCH_R8A7779
-	bool "R-Car H1 (R8A77790)"
-	select ARCH_RCAR_GEN1
-
-config ARCH_R8A7790
-	bool "R-Car H2 (R8A77900)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-	select I2C
-
-config ARCH_R8A7791
-	bool "R-Car M2-W (R8A77910)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-	select I2C
-
-config ARCH_R8A7792
-	bool "R-Car V2H (R8A77920)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-
-config ARCH_R8A7793
-	bool "R-Car M2-N (R8A7793)"
-	select ARCH_RCAR_GEN2
-	select ARM_ERRATA_798181 if SMP
-	select I2C
-
-config ARCH_R8A7794
-	bool "R-Car E2 (R8A77940)"
-	select ARCH_RCAR_GEN2
-
-config ARCH_R9A06G032
-	bool "RZ/N1D (R9A06G032)"
-	select ARCH_RZN1
-
-config ARCH_RZN1
-	bool "RZ/N1 (R9A06G0xx) Family"
-	select ARM_AMBA
-	select CPU_V7
-
-config ARCH_SH73A0
-	bool "SH-Mobile AG5 (R8A73A00)"
-	select ARCH_RMOBILE
-	select RENESAS_INTC_IRQPIN
-endif
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 0ab62024fd20be56..5089c65b544909c2 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -4,17 +4,121 @@ config SOC_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
 	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2
-	select SYSC_R8A7743 if ARCH_R8A7743 || ARCH_R8A7744
-	select SYSC_R8A7745 if ARCH_R8A7745
-	select SYSC_R8A77470 if ARCH_R8A77470
-	select SYSC_R8A7779 if ARCH_R8A7779
-	select SYSC_R8A7790 if ARCH_R8A7790
-	select SYSC_R8A7791 if ARCH_R8A7791 || ARCH_R8A7793
-	select SYSC_R8A7792 if ARCH_R8A7792
-	select SYSC_R8A7794 if ARCH_R8A7794
 
 if SOC_RENESAS
 
+if ARM
+
+#comment "Renesas ARM SoCs System Type"
+
+config ARCH_EMEV2
+	bool "Emma Mobile EV2"
+	select SYS_SUPPORTS_EM_STI
+
+config ARCH_R7S72100
+	bool "RZ/A1H (R7S72100)"
+	select PM
+	select PM_GENERIC_DOMAINS
+	select SYS_SUPPORTS_SH_MTU2
+	select RENESAS_OSTM
+
+config ARCH_R7S9210
+	bool "RZ/A2 (R7S9210)"
+	select PM
+	select PM_GENERIC_DOMAINS
+	select RENESAS_OSTM
+
+config ARCH_R8A73A4
+	bool "R-Mobile APE6 (R8A73A40)"
+	select ARCH_RMOBILE
+	select ARM_ERRATA_798181 if SMP
+	select HAVE_ARM_ARCH_TIMER
+	select RENESAS_IRQC
+
+config ARCH_R8A7740
+	bool "R-Mobile A1 (R8A77400)"
+	select ARCH_RMOBILE
+	select RENESAS_INTC_IRQPIN
+
+config ARCH_R8A7743
+	bool "RZ/G1M (R8A77430)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select SYSC_R8A7743
+
+config ARCH_R8A7744
+	bool "RZ/G1N (R8A77440)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select SYSC_R8A7743
+
+config ARCH_R8A7745
+	bool "RZ/G1E (R8A77450)"
+	select ARCH_RCAR_GEN2
+	select SYSC_R8A7745
+
+config ARCH_R8A77470
+	bool "RZ/G1C (R8A77470)"
+	select ARCH_RCAR_GEN2
+	select SYSC_R8A77470
+
+config ARCH_R8A7778
+	bool "R-Car M1A (R8A77781)"
+	select ARCH_RCAR_GEN1
+
+config ARCH_R8A7779
+	bool "R-Car H1 (R8A77790)"
+	select ARCH_RCAR_GEN1
+	select SYSC_R8A7779
+
+config ARCH_R8A7790
+	bool "R-Car H2 (R8A77900)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select I2C
+	select SYSC_R8A7790
+
+config ARCH_R8A7791
+	bool "R-Car M2-W (R8A77910)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select I2C
+	select SYSC_R8A7791
+
+config ARCH_R8A7792
+	bool "R-Car V2H (R8A77920)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select SYSC_R8A7792
+
+config ARCH_R8A7793
+	bool "R-Car M2-N (R8A7793)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+	select I2C
+	select SYSC_R8A7791
+
+config ARCH_R8A7794
+	bool "R-Car E2 (R8A77940)"
+	select ARCH_RCAR_GEN2
+	select SYSC_R8A7794
+
+config ARCH_R9A06G032
+	bool "RZ/N1D (R9A06G032)"
+	select ARCH_RZN1
+
+config ARCH_RZN1
+	bool "RZ/N1 (R9A06G0xx) Family"
+	select ARM_AMBA
+	select CPU_V7
+
+config ARCH_SH73A0
+	bool "SH-Mobile AG5 (R8A73A00)"
+	select ARCH_RMOBILE
+	select RENESAS_INTC_IRQPIN
+
+endif # ARM
+
 if ARM64
 
 config ARCH_R8A774A1
-- 
2.17.1
