From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 28 May 2014 09:43:01 +0530
Subject: [PATCH v2 Resend 1/2] ARM: EXYNOS: Update secondary boot addr for
 secure mode
Message-ID: <1401250382-24046-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost all Exynos-series of SoCs that run in secure mode don't need
additional offset for every CPU, with Exynos4412 being the only
exception.

Tested on Origen-Quad (Exynos4412) and Arndale-Octa (Exynos5420).

While at it, fix the coding style (space around *).

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-exynos/firmware.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index eb91d2350f8c..e8797bb78871 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -57,8 +57,13 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 
 	boot_reg = sysram_ns_base_addr + 0x1c;
 
-	if (!soc_is_exynos4212() && !soc_is_exynos3250())
-		boot_reg += 4*cpu;
+	/*
+	 * Almost all Exynos-series of SoCs that run in secure mode don't need
+	 * additional offset for every CPU, with Exynos4412 being the only
+	 * exception.
+	 */
+	if (soc_is_exynos4412())
+		boot_reg += 4 * cpu;
 
 	__raw_writel(boot_addr, boot_reg);
 	return 0;
-- 
1.7.9.5
