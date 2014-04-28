From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 28 Apr 2014 21:20:07 +0900
Subject: [RESUBMIT RFC PATCH v2 3/3] drivers: mfd: Add support for Exynos PMU
 driver
In-Reply-To: <1398687607-4554-1-git-send-email-pankaj.dubey@samsung.com>
References: <1398687607-4554-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1398687607-4554-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves Exynos PMU driver implementation from
"arm/mach-exynos" to "drivers/mfd".
This driver is mainly used for setting misc bits of register from PMU IP
of Exynos SoC which will be required to configure before Suspend/Resume.
Currently all these settings are done in "arch/arm/mach-exynos/pmu.c" but
moving ahead for ARM64 based SoC support, there is a need of DT based
implementation of PMU driver.
This driver uses already existing DT binding information.

CC: Sangbeom Kim <sbkim73@samsung.com>
CC: Samuel Ortiz <sameo@linux.intel.com>
CC: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                           |    2 ++
 arch/arm/mach-exynos/Makefile                          |    2 --
 drivers/mfd/Kconfig                                    |    9 +++++++++
 drivers/mfd/Makefile                                   |    1 +
 arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c |    0
 5 files changed, 12 insertions(+), 2 deletions(-)
 rename arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c (100%)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 2f60c90..79559b4 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -27,6 +27,7 @@ config ARCH_EXYNOS4
 	select PM_GENERIC_DOMAINS if PM_RUNTIME
 	select S5P_DEV_MFC
 	select MFD_SYSCON
+	select MFD_EXYNOS_PMU
 	help
 	  Samsung EXYNOS4 SoCs based systems
 
@@ -38,6 +39,7 @@ config ARCH_EXYNOS5
 	select HAVE_SMP
 	select PINCTRL
 	select MFD_SYSCON
+	select MFD_EXYNOS_PMU
 	help
 	  Samsung EXYNOS5 (Cortex-A15) SoC based systems
 
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index a656dbe..19fdf17 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -18,8 +18,6 @@ obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= pmu.o
-
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3383412..fd48870 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1203,6 +1203,15 @@ config MFD_STW481X
 	  in various ST Microelectronics and ST-Ericsson embedded
 	  Nomadik series.
 
+config MFD_EXYNOS_PMU
+	tristate "Support Exynos Power Managment Unit"
+	depends on ARM || ARM64
+	help
+	Exynos SoC have Power Management Unit (PMU) which controls power and
+	operation state of Exynos SoC in two different ways. This driver
+	provides impmentation of PMU driver and provides basic functionality
+	required during these operation state.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2851275..7c43d07 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -166,3 +166,4 @@ obj-$(CONFIG_MFD_RETU)		+= retu-mfd.o
 obj-$(CONFIG_MFD_AS3711)	+= as3711.o
 obj-$(CONFIG_MFD_AS3722)	+= as3722.o
 obj-$(CONFIG_MFD_STW481X)	+= stw481x.o
+obj-$(CONFIG_MFD_EXYNOS_PMU)	+= exynos-pmu.o
diff --git a/arch/arm/mach-exynos/pmu.c b/drivers/mfd/exynos-pmu.c
similarity index 100%
rename from arch/arm/mach-exynos/pmu.c
rename to drivers/mfd/exynos-pmu.c
-- 
1.7.10.4
