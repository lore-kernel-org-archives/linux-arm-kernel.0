From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 21 Jan 2013 02:02:19 -0800
Subject: [PATCH v4 4/7] ARM: Exynos: allow dt based discovery of mct
 controller using clocksource_of_init
In-Reply-To: <1358762542-19008-1-git-send-email-thomas.abraham@linaro.org>
References: <1358762542-19008-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1358762542-19008-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entries to __clksrc_of_table so that Exynos MCT controller is discoverable
using call to clocksource_of_init. With this change, it would be appropriate to
rename the function 'exynos4_timer_init' as 'mct_init' since it aptly describes
this function. Additionally, the 'init_time' callback of all machine descriptors
for exynos platforms that were previously set to 'exynos4_timer_init' are now
set to either 'mct_init' or 'clocksource_of_init'.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/Kconfig           |    2 ++
 arch/arm/mach-exynos/common.h          |    2 +-
 arch/arm/mach-exynos/mach-armlex4210.c |    2 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c |    3 ++-
 arch/arm/mach-exynos/mach-exynos5-dt.c |    3 ++-
 arch/arm/mach-exynos/mach-nuri.c       |    2 +-
 arch/arm/mach-exynos/mach-origen.c     |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c   |    4 ++--
 arch/arm/mach-exynos/mach-smdkv310.c   |    4 ++--
 arch/arm/mach-exynos/mct.c             |   12 ++++++------
 10 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e103c29..8bdeaa5 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -416,6 +416,7 @@ config MACH_EXYNOS4_DT
 	select PINCTRL
 	select PINCTRL_EXYNOS4
 	select USE_OF
+	select CLKSRC_OF
 	help
 	  Machine support for Samsung Exynos4 machine with device tree enabled.
 	  Select this if a fdt blob is available for the Exynos4 SoC based board.
@@ -428,6 +429,7 @@ config MACH_EXYNOS5_DT
 	depends on ARCH_EXYNOS5
 	select ARM_AMBA
 	select USE_OF
+	select CLKSRC_OF
 	help
 	  Machine support for Samsung EXYNOS5 machine with device tree enabled.
 	  Select this if a fdt blob is available for the EXYNOS5 SoC based board.
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 3ab3c03..be3ea62 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -12,7 +12,7 @@
 #ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
 #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
 
-extern void exynos4_timer_init(void);
+extern void mct_init(void);
 
 struct map_desc;
 void exynos_init_io(struct map_desc *mach_desc, int size);
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index 2f18130..27b51d2 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -204,6 +204,6 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= armlex4210_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= exynos4_timer_init,
+	.init_time	= mct_init,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 2a2c96a..6a75e96 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -13,6 +13,7 @@
 
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
+#include <linux/clocksource.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
@@ -111,7 +112,7 @@ DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device Tree)")
 	.init_early	= exynos_firmware_init,
 	.init_machine	= exynos4_dt_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= exynos4_timer_init,
+	.init_time	= clocksource_of_init,
 	.dt_compat	= exynos4_dt_compat,
 	.restart        = exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 4e074c6..39563ce 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -14,6 +14,7 @@
 #include <linux/serial_core.h>
 #include <linux/memblock.h>
 #include <linux/io.h>
+#include <linux/clocksource.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
@@ -182,7 +183,7 @@ DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= exynos5_dt_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= exynos4_timer_init,
+	.init_time	= clocksource_of_init,
 	.dt_compat	= exynos5_dt_compat,
 	.restart        = exynos5_restart,
 	.reserve	= exynos5_reserve,
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index dccd1d1..e4a7ae5 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1382,7 +1382,7 @@ MACHINE_START(NURI, "NURI")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= nuri_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= exynos4_timer_init,
+	.init_time	= mct_init,
 	.reserve        = &nuri_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 4e11563..16a7019 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -817,7 +817,7 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= origen_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= exynos4_timer_init,
+	.init_time	= mct_init,
 	.reserve	= &origen_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index e9c9c29..a66e916e 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -378,7 +378,7 @@ MACHINE_START(SMDK4212, "SMDK4212")
 	.map_io		= smdk4x12_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
-	.init_time	= exynos4_timer_init,
+	.init_time	= mct_init,
 	.restart	= exynos4_restart,
 	.reserve	= &smdk4x12_reserve,
 MACHINE_END
@@ -393,7 +393,7 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= exynos4_timer_init,
+	.init_time	= mct_init,
 	.restart	= exynos4_restart,
 	.reserve	= &smdk4x12_reserve,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index b228ab9..ecf4723 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -425,7 +425,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	.map_io		= smdkv310_map_io,
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
-	.init_time	= exynos4_timer_init,
+	.init_time	= mct_init,
 	.reserve	= &smdkv310_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
@@ -439,7 +439,7 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= exynos4_timer_init,
+	.init_time	= mct_init,
 	.reserve	= &smdkv310_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 2942bee..1d3c3f4 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/clocksource.h>
 
 #include <asm/arch_timer.h>
 #include <asm/hardware/gic.h>
@@ -518,17 +519,12 @@ static const struct of_device_id exynos_mct_ids[] = {
 	{ .compatible = "samsung,exynos4412-mct", .data = (void *)MCT_INT_PPI },
 };
 
-void __init exynos4_timer_init(void)
+void __init mct_init(void)
 {
 	struct device_node *np = NULL;
 	const struct of_device_id *match;
 	u32 nr_irqs, i;
 
-	if (soc_is_exynos5440()) {
-		arch_timer_of_register();
-		return;
-	}
-
 #ifdef CONFIG_OF
 	np = of_find_matching_node_and_match(NULL, exynos_mct_ids, &match);
 #endif
@@ -561,3 +557,7 @@ void __init exynos4_timer_init(void)
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
 }
+#ifdef CONFIG_CLKSRC_OF
+CLOCKSOURCE_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init)
+CLOCKSOURCE_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init)
+#endif
-- 
1.7.5.4
