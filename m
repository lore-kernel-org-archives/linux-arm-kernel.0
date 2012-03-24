From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 24 Mar 2012 15:11:14 +0530
Subject: [PATCH v4 3/4] ARM: Exynos: Remove arch_initcall for wakeup interrupt
 initialization
In-Reply-To: <1332582075-16204-1-git-send-email-thomas.abraham@linaro.org>
References: <1332582075-16204-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1332582075-16204-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_irq_init function would be setup to invoke the exynos4_init_irq_eint
function when booting using device tree. The arch_initcall for
exynos4_init_irq_eint would duplicate its invocation in that case. Hence,
arch_initcall for exynos4_init_irq_eint is removed and this function is invoked
from the exynos4_init_irq for non-dt case.

Moreover, with single kernel image build, the exynos4_init_irq_eint has no checks
to ensure that it is running on a exynos4 platform. So it would be appropriate
to invoke it from exynos4_init_irq.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-exynos/common.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index b69f36a..7aa1919 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -64,6 +64,7 @@ static void exynos4_init_clocks(int xtal);
 static void exynos5_init_clocks(int xtal);
 static void exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 static int exynos_init(void);
+static int exynos_init_irq_eint(void);
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
@@ -608,6 +609,7 @@ void __init exynos4_init_irq(void)
 	 * uses GIC instead of VIC.
 	 */
 	s5p_init_irq(NULL, 0);
+	exynos_init_irq_eint();
 }
 
 void __init exynos5_init_irq(void)
@@ -620,6 +622,7 @@ void __init exynos5_init_irq(void)
 	 * uses GIC instead of VIC.
 	 */
 	s5p_init_irq(NULL, 0);
+	exynos_init_irq_eint();
 }
 
 struct bus_type exynos4_subsys = {
@@ -1048,4 +1051,3 @@ static int __init exynos_init_irq_eint(void)
 
 	return 0;
 }
-arch_initcall(exynos_init_irq_eint);
-- 
1.6.6.rc2
