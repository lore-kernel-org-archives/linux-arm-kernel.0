From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 16:47:56 +0000
Subject: [PATCH v3 3/3] ARM: cache: assume 64-byte L1 cachelines for ARMv7 CPUs
In-Reply-To: <1326818876-4818-1-git-send-email-will.deacon@arm.com>
References: <1326818876-4818-1-git-send-email-will.deacon@arm.com>
Message-ID: <1326818876-4818-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To ensure correct alignment of cacheline-aligned data, the maximum
cacheline size needs to be known at compile time.

Since Cortex-A8 and Cortex-A15 have 64-byte cachelines (and it is likely
that there will be future ARMv7 implementations with the same line size)
then it makes sense to assume that CPU_V7 implies a 64-byte L1 cacheline
size. For CPUs with smaller caches, this will result in some harmless
padding but will help with single zImage work and avoid hitting subtle
bugs with misaligned data structures.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig            |    2 --
 arch/arm/mach-mx5/Kconfig   |    3 ---
 arch/arm/mach-omap2/Kconfig |    1 -
 arch/arm/mm/Kconfig         |    1 +
 4 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..6e40039 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -825,7 +825,6 @@ config ARCH_S5PC100
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
 	select CPU_V7
-	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
@@ -842,7 +841,6 @@ config ARCH_S5PV210
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SCHED_CLOCK
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index af0c212..9cf4c3c 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -15,7 +15,6 @@ config ARCH_MX53
 config SOC_IMX50
 	bool
 	select CPU_V7
-	select ARM_L1_CACHE_SHIFT_6
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
@@ -25,7 +24,6 @@ config SOC_IMX50
 config	SOC_IMX51
 	bool
 	select CPU_V7
-	select ARM_L1_CACHE_SHIFT_6
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
@@ -35,7 +33,6 @@ config	SOC_IMX51
 config	SOC_IMX53
 	bool
 	select CPU_V7
-	select ARM_L1_CACHE_SHIFT_6
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MX53
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 904bd1d..ac6b1d3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -33,7 +33,6 @@ config ARCH_OMAP3
 	default y
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI
-	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
 	select ARM_CPU_SUSPEND if PM
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 4cefb57..1a3ca24 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -882,6 +882,7 @@ config CACHE_XSC3L2
 
 config ARM_L1_CACHE_SHIFT_6
 	bool
+	default y if CPU_V7
 	help
 	  Setting ARM L1 cache line size to 64 Bytes.
 
-- 
1.7.4.1
