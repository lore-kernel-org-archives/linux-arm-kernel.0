From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 27 Mar 2012 14:56:04 +0530
Subject: [PATCH 3/4] ARM: Exynos5: Fix incorrect initialization of GIC
In-Reply-To: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
References: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1332840365-24827-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the of_irq_init() call to setup the gic which also properly registers
the gic device node pointer with gic irq domain, without which all interrupt
specifier translations for gic fail.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index f265dc4..3bf39a8 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -542,7 +542,7 @@ void __init exynos5_init_irq(void)
 {
 	int irq;
 
-	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
+	of_irq_init(exynos4_dt_irq_match);
 
 	for (irq = 0; irq < EXYNOS5_MAX_COMBINER_NR; irq++) {
 		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
-- 
1.6.6.rc2
