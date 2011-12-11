From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 11 Dec 2011 12:21:40 +0530
Subject: [PATCH v2 3/4] ARM: Exynos4: Remove arch_initcall for wakeup interrupt
 initialization
In-Reply-To: <1323586301-24537-3-git-send-email-thomas.abraham@linaro.org>
References: <1323586301-24537-1-git-send-email-thomas.abraham@linaro.org>
 <1323586301-24537-2-git-send-email-thomas.abraham@linaro.org>
 <1323586301-24537-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1323586301-24537-4-git-send-email-thomas.abraham@linaro.org>
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
---
 arch/arm/mach-exynos/cpu.c                   |    1 +
 arch/arm/mach-exynos/irq-eint.c              |    2 --
 arch/arm/plat-samsung/include/plat/exynos4.h |    1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/cpu.c b/arch/arm/mach-exynos/cpu.c
index 14f86ba..2e6ae21 100644
--- a/arch/arm/mach-exynos/cpu.c
+++ b/arch/arm/mach-exynos/cpu.c
@@ -289,6 +289,7 @@ void __init exynos4_init_irq(void)
 	 * uses GIC instead of VIC.
 	 */
 	s5p_init_irq(NULL, 0);
+	exynos4_init_irq_eint();
 }
 
 struct sysdev_class exynos4_sysclass = {
diff --git a/arch/arm/mach-exynos/irq-eint.c b/arch/arm/mach-exynos/irq-eint.c
index 41aaca8..c8bad66 100644
--- a/arch/arm/mach-exynos/irq-eint.c
+++ b/arch/arm/mach-exynos/irq-eint.c
@@ -233,5 +233,3 @@ int __init exynos4_init_irq_eint(void)
 
 	return 0;
 }
-
-arch_initcall(exynos4_init_irq_eint);
diff --git a/arch/arm/plat-samsung/include/plat/exynos4.h b/arch/arm/plat-samsung/include/plat/exynos4.h
index f546e88..a501461 100644
--- a/arch/arm/plat-samsung/include/plat/exynos4.h
+++ b/arch/arm/plat-samsung/include/plat/exynos4.h
@@ -24,6 +24,7 @@ extern void exynos4_init_irq(void);
 extern void exynos4_map_io(void);
 extern void exynos4_init_clocks(int xtal);
 extern struct sys_timer exynos4_timer;
+extern int exynos4_init_irq_eint(void);
 
 #define exynos4_init_uarts exynos4_common_init_uarts
 
-- 
1.6.6.rc2
