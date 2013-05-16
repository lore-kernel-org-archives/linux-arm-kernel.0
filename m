From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 May 2013 17:39:16 +0100
Subject: [RFC] ARM: Allow user selection HZ values
Message-ID: <20130516163916.GU18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow users to configure the Hz rate on implementations which do not have
a fixed clock rate.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Whenever HZ_FIXED is not set through one of its "default" settings, the
user is allowed to select a tick rate from 100, 200, 250, 300, 500Hz
and 1kHz.  This is slightly more choice than with the generic HZ
selection in kernel/Kconfig.hz (which only does 100, 250, 300Hz and
1kHz).  The reason for including 200Hz is that a greater number of
other platforms want that via the fixed rate, and 500Hz just seemed
to be a better middle value than 300Hz (which is of course stupidly
close to 250.)

 arch/arm/Kconfig |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..dcd16ff 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1646,14 +1646,50 @@ config ARCH_NR_GPIO
 
 source kernel/Kconfig.preempt
 
-config HZ
+config HZ_FIXED
 	int
 	default 200 if ARCH_EBSA110 || ARCH_S3C24XX || ARCH_S5P64X0 || \
 		ARCH_S5PV210 || ARCH_EXYNOS4
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
 	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
-	default 100
+
+choice
+	depends on !HZ_FIXED
+	prompt "Timer frequency"
+
+config HZ_100
+	bool "100 Hz"
+
+config HZ_200
+	bool "200 Hz"
+
+config HZ_250
+	bool "250 Hz"
+
+config HZ_300
+	bool "300 Hz"
+
+config HZ_500
+	bool "500 Hz"
+
+config HZ_1000
+	bool "1000 Hz"
+
+endchoice
+
+config HZ
+	int
+	default HZ_FIXED if HZ_FIXED
+	default 100 if HZ_100
+	default 200 if HZ_200
+	default 250 if HZ_250
+	default 300 if HZ_300
+	default 500 if HZ_500
+	default 1000
+
+config SCHED_HRTICK
+	def_bool HIGH_RES_TIMERS
 
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode"
-- 
1.7.4.4
