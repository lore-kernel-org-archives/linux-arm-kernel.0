From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 24 Mar 2012 15:11:12 +0530
Subject: [PATCH v4 1/4] ARM: Exynos: Simplify the wakeup interrupt setup code
In-Reply-To: <1332582075-16204-1-git-send-email-thomas.abraham@linaro.org>
References: <1332582075-16204-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1332582075-16204-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the wakeup interrupt setup code in order to add irq domain
and device tree support.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c |   32 +++++++++++---------------------
 1 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 36b5837..3768efa 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -995,16 +995,14 @@ static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 
 static int __init exynos_init_irq_eint(void)
 {
-	int irq;
+	int irq, *src_int;
+	unsigned int paddr;
 
-	if (soc_is_exynos5250())
-		exynos_eint_base = ioremap(EXYNOS5_PA_GPIO1, SZ_4K);
-	else
-		exynos_eint_base = ioremap(EXYNOS4_PA_GPIO2, SZ_4K);
-
-	if (exynos_eint_base == NULL) {
+	paddr = soc_is_exynos5250() ? EXYNOS5_PA_GPIO1 : EXYNOS4_PA_GPIO2;
+	exynos_eint_base = ioremap(paddr, SZ_4K);
+	if (!exynos_eint_base) {
 		pr_err("unable to ioremap for EINT base address\n");
-		return -ENOMEM;
+		return -ENXIO;
 	}
 
 	for (irq = 0 ; irq <= 31 ; irq++) {
@@ -1015,20 +1013,12 @@ static int __init exynos_init_irq_eint(void)
 
 	irq_set_chained_handler(EXYNOS_IRQ_EINT16_31, exynos_irq_demux_eint16_31);
 
-	for (irq = 0 ; irq <= 15 ; irq++) {
+	for (irq = 0 ; irq <= 15; irq++) {
 		eint0_15_data[irq] = IRQ_EINT(irq);
-
-		if (soc_is_exynos5250()) {
-			irq_set_handler_data(exynos5_eint0_15_src_int[irq],
-					     &eint0_15_data[irq]);
-			irq_set_chained_handler(exynos5_eint0_15_src_int[irq],
-						exynos_irq_eint0_15);
-		} else {
-			irq_set_handler_data(exynos4_eint0_15_src_int[irq],
-					     &eint0_15_data[irq]);
-			irq_set_chained_handler(exynos4_eint0_15_src_int[irq],
-						exynos_irq_eint0_15);
-		}
+		src_int = soc_is_exynos5250() ? exynos5_eint0_15_src_int :
+						exynos4_eint0_15_src_int;
+		irq_set_handler_data(src_int[irq], &eint0_15_data[irq]);
+		irq_set_chained_handler(src_int[irq], exynos_irq_eint0_15);
 	}
 
 	return 0;
-- 
1.6.6.rc2
