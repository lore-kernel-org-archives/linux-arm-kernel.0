From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:45 +0100
Subject: [PATCH 32/69] clocksource/drivers/exynos_mct: Fix Kconfig and add
 COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-32-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the platform's Kconfig to select the clock instead of having a reverse
dependency from the driver to the platform options.

Add the COMPILE_TEST option for the compilation test coverage. Due to the
non portable 'delay' code, this driver is only compilable on ARM.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 drivers/clocksource/Kconfig  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 3a10f1a..ff10539 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -27,6 +27,7 @@ menuconfig ARCH_EXYNOS
 	select SRAM
 	select THERMAL
 	select MFD_SYSCON
+	select CLKSRC_EXYNOS_MCT
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index e3ba5b4..2062783 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -231,8 +231,8 @@ config CLKSRC_METAG_GENERIC
 	  This option enables support for the Meta per-thread timers.
 
 config CLKSRC_EXYNOS_MCT
-	def_bool y if ARCH_EXYNOS
-	depends on !ARM64
+	bool "Exynos multi core timer driver" if COMPILE_TEST
+	depends on ARM
 	help
 	  Support for Multi Core Timer controller on Exynos SoCs.
 
-- 
1.9.1
