From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 25 Apr 2014 10:16:08 +0900
Subject: [PATCHv4 3/7] ARM: EXYNOS: Support secondary CPU boot of Exynos3250
In-Reply-To: <1398388572-30239-1-git-send-email-cw00.choi@samsung.com>
References: <1398388572-30239-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1398388572-30239-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the offset of CPU boot address and don't need to send smc call
of SMC_CMD_CPU1BOOT command for secondary CPU boot because Exynos3250 removes
WFE in secure mode.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/firmware.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index aa01c42..386d01d 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -31,11 +31,17 @@ static int exynos_do_idle(void)
 static int exynos_cpu_boot(int cpu)
 {
 	/*
+	 * Exynos3250 doesn't need to send smc command for secondary CPU boot
+	 * because Exynos3250 removes WFE in secure mode.
+	 */
+	if (soc_is_exynos3250())
+		return 0;
+	/*
 	 * The second parameter of SMC_CMD_CPU1BOOT command means CPU id.
 	 * But, Exynos4212 has only one secondary CPU so second parameter
 	 * isn't used for informing secure firmware about CPU id.
 	 */
-	if (soc_is_exynos4212())
+	else if (soc_is_exynos4212())
 		cpu = 0;
 
 	exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0);
@@ -46,7 +52,7 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 {
 	void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c;
 
-	if (!soc_is_exynos4212())
+	if (!soc_is_exynos4212() && !soc_is_exynos3250())
 		boot_reg += 4*cpu;
 
 	__raw_writel(boot_addr, boot_reg);
-- 
1.8.0
