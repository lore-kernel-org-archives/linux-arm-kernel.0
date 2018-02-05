From: robin.murphy@arm.com (Robin Murphy)
Date: Mon,  5 Feb 2018 18:39:42 +0000
Subject: [PATCH 1/5] drivers/bus: Move Arm CCN PMU driver
In-Reply-To: <cover.1517855839.git.robin.murphy@arm.com>
References: <cover.1517855839.git.robin.murphy@arm.com>
Message-ID: <b85ba78d3058cedfab43fa035d5a326b2e70baeb.1517855839.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm-ccn driver is purely a perf driver for the CCN PMU, not a bus
driver in the sense of the other residents of drivers/bus/, so let's
move it to the appropriate place for SoC PMU drivers. Not to mention
moving the documentation accordingly as well.

Acked-by: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../devicetree/bindings/{arm/ccn.txt => perf/arm-ccn.txt}         | 0
 Documentation/{arm/CCN.txt => perf/arm-ccn.txt}                   | 0
 drivers/bus/Kconfig                                               | 8 --------
 drivers/bus/Makefile                                              | 2 --
 drivers/perf/Kconfig                                              | 7 +++++++
 drivers/perf/Makefile                                             | 1 +
 drivers/{bus => perf}/arm-ccn.c                                   | 0
 7 files changed, 8 insertions(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/{arm/ccn.txt => perf/arm-ccn.txt} (100%)
 rename Documentation/{arm/CCN.txt => perf/arm-ccn.txt} (100%)
 rename drivers/{bus => perf}/arm-ccn.c (100%)

diff --git a/Documentation/devicetree/bindings/arm/ccn.txt b/Documentation/devicetree/bindings/perf/arm-ccn.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/ccn.txt
rename to Documentation/devicetree/bindings/perf/arm-ccn.txt
diff --git a/Documentation/arm/CCN.txt b/Documentation/perf/arm-ccn.txt
similarity index 100%
rename from Documentation/arm/CCN.txt
rename to Documentation/perf/arm-ccn.txt
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 57e011d36a79..116446c42c6b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -48,14 +48,6 @@ config ARM_CCI5xx_PMU
 
 	  If unsure, say Y
 
-config ARM_CCN
-	tristate "ARM CCN driver support"
-	depends on ARM || ARM64
-	depends on PERF_EVENTS
-	help
-	  PMU (perf) driver supporting the ARM CCN (Cache Coherent Network)
-	  interconnect.
-
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
 	depends on ARM || ARM64 || MIPS
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 9bcd0bf3954b..19733afddd0a 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -5,8 +5,6 @@
 
 # Interconnect bus drivers for ARM platforms
 obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
-obj-$(CONFIG_ARM_CCN)		+= arm-ccn.o
-
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
 obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
 obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index da5724cd89cf..331b6d992b5a 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -5,6 +5,13 @@
 menu "Performance monitor support"
 	depends on PERF_EVENTS
 
+config ARM_CCN
+	tristate "ARM CCN driver support"
+	depends on ARM || ARM64
+	help
+	  PMU (perf) driver supporting the ARM CCN (Cache Coherent Network)
+	  interconnect.
+
 config ARM_PMU
 	depends on ARM || ARM64
 	bool "ARM PMU framework"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index c2f27419bdf0..5004abee0f3a 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ARM_CCN) += arm-ccn.o
 obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
 obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
diff --git a/drivers/bus/arm-ccn.c b/drivers/perf/arm-ccn.c
similarity index 100%
rename from drivers/bus/arm-ccn.c
rename to drivers/perf/arm-ccn.c
-- 
2.16.1.dirty
