From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 25 Feb 2015 11:26:50 +0000
Subject: [PATCH] ARM: fix exynos randconfig build error
Message-ID: <E1YQa78-0000O0-A4@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following error was observed with SMP=n in v4.0-rc1:

arch/arm/mach-exynos/pm.c: In function 'exynos_cpu0_enter_aftr':
arch/arm/mach-exynos/pm.c:246:4: error: implicit declaration of function 'arch_send_wakeup_ipi_mask' [-Werror=implicit-function-declaration]

As the code unconditionally calls a function only available with SMP=y,
make the Exynos PM support depend on SMP.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Alternatively, the code needs fixing not to call this function on non-SMP
platforms.

 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 603820e5aba7..55a1ada28350 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -131,6 +131,7 @@ config EXYNOS5420_MCPM
 
 config EXYNOS_CPU_SUSPEND
 	bool
+	depends on SMP
 	select ARM_CPU_SUSPEND
 	default PM_SLEEP || ARM_EXYNOS_CPUIDLE
 
-- 
1.8.3.1
