From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 23:37:17 +0200
Subject: [PATCH v3 02/10] ARM: exynos: prepare for sparse IRQ
In-Reply-To: <1365716245-99231-1-git-send-email-arnd@arndb.de>
References: <1365716245-99231-1-git-send-email-arnd@arndb.de>
Message-ID: <1365716245-99231-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we enable CONFIG_SPARSE_IRQ, we have to set the value of NR_IRQS in
the machine_desc for legacy IRQ domains, and any file referring to the
number of interrupts or a specific number must include the mach/irqs.h
header file explicitly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/dev-uart.c          | 1 +
 arch/arm/mach-exynos/include/mach/irqs.h | 5 ++++-
 arch/arm/mach-exynos/mach-armlex4210.c   | 2 ++
 arch/arm/mach-exynos/mach-exynos4-dt.c   | 2 ++
 arch/arm/mach-exynos/mach-exynos5-dt.c   | 2 ++
 arch/arm/mach-exynos/mach-nuri.c         | 2 ++
 arch/arm/mach-exynos/mach-origen.c       | 2 ++
 arch/arm/mach-exynos/mach-smdk4x12.c     | 2 ++
 arch/arm/mach-exynos/mach-smdkv310.c     | 3 +++
 arch/arm/plat-samsung/irq-vic-timer.c    | 1 +
 arch/arm/plat-samsung/pm.c               | 1 +
 arch/arm/plat-samsung/s5p-irq.c          | 1 +
 12 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/dev-uart.c b/arch/arm/mach-exynos/dev-uart.c
index 7c42f4b..c48aff0 100644
--- a/arch/arm/mach-exynos/dev-uart.c
+++ b/arch/arm/mach-exynos/dev-uart.c
@@ -20,6 +20,7 @@
 #include <asm/mach/irq.h>
 #include <mach/hardware.h>
 #include <mach/map.h>
+#include <mach/irqs.h>
 
 #include <plat/devs.h>
 
diff --git a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-exynos/include/mach/irqs.h
index 1f4dc35..8bd5dde 100644
--- a/arch/arm/mach-exynos/include/mach/irqs.h
+++ b/arch/arm/mach-exynos/include/mach/irqs.h
@@ -466,7 +466,10 @@
 #define IRQ_TIMER_BASE			(IRQ_GPIO_END + 64)
 
 /* Set the default NR_IRQS */
+#define EXYNOS_NR_IRQS			(IRQ_TIMER_BASE + IRQ_TIMER_COUNT)
 
-#define NR_IRQS				(IRQ_TIMER_BASE + IRQ_TIMER_COUNT)
+#ifndef CONFIG_SPARSE_IRQ
+#define NR_IRQS				EXYNOS_NR_IRQS
+#endif
 
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index 685f291..cb95992 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -25,6 +25,7 @@
 #include <plat/regs-srom.h>
 #include <plat/sdhci.h>
 
+#include <mach/irqs.h>
 #include <mach/map.h>
 
 #include "common.h"
@@ -197,6 +198,7 @@ static void __init armlex4210_machine_init(void)
 MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	/* Maintainer: Alim Akhtar <alim.akhtar@samsung.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= EXYNOS_NR_IRQS,
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= armlex4210_map_io,
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 3358088..55aa611 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -16,6 +16,7 @@
 
 #include <asm/mach/arch.h>
 #include <mach/map.h>
+#include <mach/irqs.h>
 
 #include <plat/cpu.h>
 #include <plat/regs-serial.h>
@@ -137,6 +138,7 @@ static char const *exynos4_dt_compat[] __initdata = {
 
 DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	/* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
+	.nr_irqs	= EXYNOS_NR_IRQS,
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= exynos4_dt_map_io,
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index acaeb14..c674e7f 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -17,6 +17,7 @@
 
 #include <asm/mach/arch.h>
 #include <mach/map.h>
+#include <mach/irqs.h>
 #include <mach/regs-pmu.h>
 
 #include <plat/cpu.h>
@@ -211,6 +212,7 @@ static void __init exynos5_reserve(void)
 
 DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.nr_irqs	= EXYNOS_NR_IRQS,
 	.init_irq	= exynos5_init_irq,
 	.smp		= smp_ops(exynos_smp_ops),
 	.map_io		= exynos5_dt_map_io,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 1ea7973..fee0885 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -53,6 +53,7 @@
 #include <plat/fimc-core.h>
 #include <plat/camport.h>
 
+#include <mach/irqs.h>
 #include <mach/map.h>
 
 #include "common.h"
@@ -1375,6 +1376,7 @@ static void __init nuri_machine_init(void)
 MACHINE_START(NURI, "NURI")
 	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= EXYNOS_NR_IRQS,
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= nuri_map_io,
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 579d2d1..d1849d1 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -46,6 +46,7 @@
 #include <plat/hdmi.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
 
 #include <drm/exynos_drm.h>
 #include "common.h"
@@ -810,6 +811,7 @@ static void __init origen_machine_init(void)
 MACHINE_START(ORIGEN, "ORIGEN")
 	/* Maintainer: JeongHyeon Kim <jhkim@insignal.co.kr> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= EXYNOS_NR_IRQS,
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= origen_map_io,
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index fe61496..46c7fc7 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -39,6 +39,7 @@
 #include <plat/regs-serial.h>
 #include <plat/sdhci.h>
 
+#include <mach/irqs.h>
 #include <mach/map.h>
 
 #include <drm/exynos_drm.h>
@@ -385,6 +386,7 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= EXYNOS_NR_IRQS,
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdk4x12_map_io,
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index d716729..5187687 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -43,6 +43,7 @@
 #include <plat/clock.h>
 #include <plat/hdmi.h>
 
+#include <mach/irqs.h>
 #include <mach/map.h>
 
 #include <drm/exynos_drm.h>
@@ -419,6 +420,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= EXYNOS_NR_IRQS,
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
@@ -431,6 +433,7 @@ MACHINE_END
 MACHINE_START(SMDKC210, "SMDKC210")
 	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= EXYNOS_NR_IRQS,
 	.smp		= smp_ops(exynos_smp_ops),
 	.init_irq	= exynos4_init_irq,
 	.map_io		= smdkv310_map_io,
diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
index f980cf3..1113066 100644
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ b/arch/arm/plat-samsung/irq-vic-timer.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/irq-vic-timer.h>
 #include <plat/regs-timer.h>
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 002b147..53210ec 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -27,6 +27,7 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-irq.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 
 #include <plat/pm.h>
diff --git a/arch/arm/plat-samsung/s5p-irq.c b/arch/arm/plat-samsung/s5p-irq.c
index 103e371..ff1a760 100644
--- a/arch/arm/plat-samsung/s5p-irq.c
+++ b/arch/arm/plat-samsung/s5p-irq.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/irqchip/arm-vic.h>
 
+#include <mach/irqs.h>
 #include <mach/map.h>
 #include <plat/regs-timer.h>
 #include <plat/cpu.h>
-- 
1.8.1.2
