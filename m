From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 13 Mar 2015 22:57:24 +0100
Subject: [PATCH v3 7/7] ARM: at91: drop AT91_TIMER_HZ
In-Reply-To: <1426283844-463-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426283844-463-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1426283844-463-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop AT91_TIMER_HZ as this can be handled using HZ_FIXED. Initial help message
was:

On AT91rm9200 chips where you're using a system clock derived
from the 32768 Hz hardware clock, this tick rate should divide
it exactly: use a power-of-two value, such as 128 or 256, to
reduce timing errors caused by rounding.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/Kconfig           |  2 +-
 arch/arm/mach-at91/Kconfig | 18 ------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a1d153098001..8d5c4f9c15f9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1502,7 +1502,7 @@ config HZ_FIXED
 	int
 	default 200 if ARCH_EBSA110 || ARCH_S3C24XX || \
 		ARCH_S5PV210 || ARCH_EXYNOS4
-	default AT91_TIMER_HZ if ARCH_AT91
+	default 128 if SOC_AT91RM9200
 	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE_LEGACY
 	default 0
 
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 4662eae06753..da977699c037 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -100,22 +100,4 @@ config SOC_SAMA5
 	select SOC_SAM_V7
 	select SRAM if PM
 
-comment "Atmel SoCs Feature Selections"
-
-config AT91_TIMER_HZ
-	int "Kernel HZ (jiffies per second)"
-	range 32 1024
-	depends on ARCH_AT91
-	default "128" if SOC_AT91RM9200
-	default "100"
-	help
-	  On AT91rm9200 chips where you're using a system clock derived
-	  from the 32768 Hz hardware clock, this tick rate should divide
-	  it exactly: use a power-of-two value, such as 128 or 256, to
-	  reduce timing errors caused by rounding.
-
-	  On AT91sam926x chips, or otherwise when using a higher precision
-	  system clock (of at least several MHz), rounding is less of a
-	  problem so it can be safer to use a decimal values like 100.
-
 endif
-- 
2.1.0
