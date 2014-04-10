From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 10 Apr 2014 18:28:22 +0900
Subject: [PATCH 05/27] ARM: EXYNOS: Support secondary CPU boot of Exynos3250
In-Reply-To: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1397122124-15690-6-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the offset of CPU boot address and don't operate smc call
of SMC_CMD_CPU1BOOT command for Exynos3250.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/firmware.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 91a911d..8350007 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -30,10 +30,13 @@ static int exynos_do_idle(void)
 
 static int exynos_cpu_boot(int cpu)
 {
-	if (soc_is_exynos4212())
+	if (soc_is_exynos3250())
+		goto out;
+	else if (soc_is_exynos4212())
 		exynos_smc(SMC_CMD_CPU1BOOT, 0, 0, 0);
 	else
 		exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
+out:
 	return 0;
 }
 
@@ -41,7 +44,7 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 {
 	void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c;
 
-	if (soc_is_exynos4212())
+	if (soc_is_exynos4212() || soc_is_exynos3250())
 		goto out;
 	else
 		boot_reg += 4*cpu;
-- 
1.8.0
