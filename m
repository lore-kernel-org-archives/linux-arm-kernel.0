From: sbkim73@samsung.com (Sangbeom Kim)
Date: Mon,  7 Mar 2011 09:09:14 +0900
Subject: [PATCH 3/3] This patch update mach-s5p64x0 and mach-s5pv210 machine
	initialization for hrt support. S5P_HRT is added and applied in
	s5pv210,
	s5p64x0 machines. PWM Timer3 is used for default clockevent. PWM Timer4
	is used for defualt clocksource.
In-Reply-To: <1299456554-15280-1-git-send-email-sbkim73@samsung.com>
References: <1299456554-15280-1-git-send-email-sbkim73@samsung.com>
Message-ID: <1299456554-15280-4-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/Kconfig                   |    6 ++++--
 arch/arm/configs/s5p64x0_defconfig |    2 ++
 arch/arm/configs/s5pv210_defconfig |    2 ++
 arch/arm/mach-s5p64x0/Kconfig      |    2 ++
 arch/arm/mach-s5pv210/Kconfig      |    1 +
 arch/arm/plat-s5p/Kconfig          |    5 +++++
 6 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ec3bf98..f9f33d4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -715,7 +715,8 @@ config ARCH_S5P64X0
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select ARCH_USES_GETTIMEOFFSET
+	select GENERIC_CLOCKEVENTS
+	select HAVE_SCHED_CLOCK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	help
@@ -753,7 +754,8 @@ config ARCH_S5PV210
 	select HAVE_CLK
 	select ARM_L1_CACHE_SHIFT_6
 	select ARCH_HAS_CPUFREQ
-	select ARCH_USES_GETTIMEOFFSET
+	select GENERIC_CLOCKEVENTS
+	select HAVE_SCHED_CLOCK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
diff --git a/arch/arm/configs/s5p64x0_defconfig b/arch/arm/configs/s5p64x0_defconfig
index 2993ecd..ad6b61b 100644
--- a/arch/arm/configs/s5p64x0_defconfig
+++ b/arch/arm/configs/s5p64x0_defconfig
@@ -10,6 +10,8 @@ CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_MACH_SMDK6440=y
 CONFIG_MACH_SMDK6450=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CPU_32v6K=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x20800000,8M console=ttySAC1,115200 init=/linuxrc"
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 0488a1e..fa98990 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -13,6 +13,8 @@ CONFIG_MACH_AQUILA=y
 CONFIG_MACH_GONI=y
 CONFIG_MACH_SMDKC110=y
 CONFIG_MACH_SMDKV210=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index 08b0a5b..017af4c 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -10,12 +10,14 @@ if ARCH_S5P64X0
 config CPU_S5P6440
 	bool
 	select S3C_PL330_DMA
+	select S5P_HRT
 	help
 	  Enable S5P6440 CPU support
 
 config CPU_S5P6450
 	bool
 	select S3C_PL330_DMA
+	select S5P_HRT
 	help
 	  Enable S5P6450 CPU support
 
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index d7fd031..ac787ed 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -13,6 +13,7 @@ config CPU_S5PV210
 	bool
 	select S3C_PL330_DMA
 	select S5P_EXT_INT
+	select S5P_HRT
 	select S5PV210_PM if PM
 	help
 	  Enable S5PV210 CPU support
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 6390ac7..1ef3e09 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -74,3 +74,8 @@ config S5P_DEV_CSIS1
 	bool
 	help
 	  Compile in platform device definitions for MIPI-CSIS channel 1
+
+config S5P_HRT
+	bool
+	help
+	  Use the High Resolution timer support
-- 
1.7.1
