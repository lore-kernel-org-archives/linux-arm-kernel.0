From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 18:37:15 +0900
Subject: [PATCH 04/27] ARM: EXYNOS: Support secondary CPU boot of Exynos4212
In-Reply-To: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397122658-16013-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

This patch fix the offset of CPU boot address and change parameter of smc call
of SMC_CMD_CPU1BOOT command for Exynos4212.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/firmware.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 932129e..91a911d 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -18,6 +18,8 @@
 
 #include <mach/map.h>
 
+#include <plat/cpu.h>
+
 #include "smc.h"
 
 static int exynos_do_idle(void)
@@ -28,14 +30,22 @@ static int exynos_do_idle(void)
 
 static int exynos_cpu_boot(int cpu)
 {
-	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
+	if (soc_is_exynos4212())
+		exynos_smc(SMC_CMD_CPU1BOOT, 0, 0, 0);
+	else
+		exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
 	return 0;
 }
 
 static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 {
-	void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
+	void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c;
 
+	if (soc_is_exynos4212())
+		goto out;
+	else
+		boot_reg += 4*cpu;
+out:
 	__raw_writel(boot_addr, boot_reg);
 	return 0;
 }
-- 
1.8.0
