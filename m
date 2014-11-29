From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Sat, 29 Nov 2014 19:45:04 +0530
Subject: [PATCH v5 2/6] drivers: soc: Add support for Exynos PMU driver
In-Reply-To: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
References: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1417270508-11174-3-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves Exynos PMU driver implementation from "arm/mach-exynos"
to "drivers/soc/samsung". This driver is mainly used for setting misc
bits of register from PMU IP of Exynos SoC which will be required to
configure before Suspend/Resume. Currently all these settings are done
in "arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC
support, there is a need of this PMU driver in driver/* folder.

This driver uses existing DT binding information and there should
be no functionality change in the supported platforms.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 arch/arm/mach-exynos/Makefile                      |    2 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/samsung/Kconfig                        |   20 ++++++++++++++++++++
 drivers/soc/samsung/Makefile                       |    1 +
 .../pmu.c => drivers/soc/samsung/exynos-pmu.c      |    0
 6 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 rename arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c (100%)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index bcefb54..b91b382 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -9,7 +9,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
 
 # Core
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o exynos-smc.o firmware.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_PM_SLEEP)		+= suspend.o
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 76d6bd4..90f33b9 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -3,5 +3,6 @@ menu "SOC (System On Chip) specific Drivers"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/ti/Kconfig"
 source "drivers/soc/versatile/Kconfig"
+source "drivers/soc/samsung/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 063113d..fcd7e37 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_SOC_TI)		+= ti/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
+obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
new file mode 100644
index 0000000..6855cc4
--- /dev/null
+++ b/drivers/soc/samsung/Kconfig
@@ -0,0 +1,20 @@
+#
+# SAMSUNG SOC drivers
+#
+menu "Samsung SOC drivers support"
+
+config SOC_SAMSUNG
+	bool
+
+config EXYNOS_PMU
+	bool "Support Exynos Power Management Unit"
+	depends on ARCH_EXYNOS
+	default y
+	help
+	  Exynos SoC have Power Management Unit (PMU) which controls power and
+	  operation state of various components in Exynos SoC. This driver
+	  provides implementation of PMU driver and provides various
+	  functionality like initialisation and transition to various low power
+	  states.
+
+endmenu
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
new file mode 100644
index 0000000..5a879c6
--- /dev/null
+++ b/drivers/soc/samsung/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
diff --git a/arch/arm/mach-exynos/pmu.c b/drivers/soc/samsung/exynos-pmu.c
similarity index 100%
rename from arch/arm/mach-exynos/pmu.c
rename to drivers/soc/samsung/exynos-pmu.c
-- 
1.7.9.5
