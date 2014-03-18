From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 18 Mar 2014 18:16:01 +0100
Subject: [PATCH v2 3/6] ARM: EXYNOS: Fix compilation error in cpuidle.c
In-Reply-To: <1395162964-5916-1-git-send-email-t.figa@samsung.com>
References: <1395162964-5916-1-git-send-email-t.figa@samsung.com>
Message-ID: <1395162964-5916-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The big series refactoring Exynos suspend to RAM handling missed the
cpuidle driver that is disabled in exynos_defconfig, leaving it
including old mach/pm_core.h header and using old s3c_cpu_resume symbol
instead of new exynos_cpu_resume, resulting in compilation failures with
CONFIG_ARCH_EXYNOS and CONFIG_CPU_IDLE enabled.

This patch fixes that silly mistake and performs necessary modification
to arhc/arm/exynos/cpuidle.c to make it compile again.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index f57cb91..b530231 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -26,7 +26,6 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
-#include <mach/pm-core.h>
 #include <mach/map.h>
 
 #include "common.h"
@@ -127,7 +126,7 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
 
-	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
+	__raw_writel(virt_to_phys(exynos_cpu_resume), REG_DIRECTGO_ADDR);
 	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
 
 	save_cpu_arch_register();
-- 
1.9.0
