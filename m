From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:56:08 +0000
Subject: [PATCH 3/5] ARM: restart: exynos4: use new restart hook XXX WIP XXX
 WHY IS THERE NO LOCAL HEADERS IN arch/arm/mach-exynos4 XXX
In-Reply-To: <20111106175457.GK12913@n2100.arm.linux.org.uk>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6wy-0001aV-VK@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-exynos4/cpu.c                 |    6 +-----
 arch/arm/mach-exynos4/mach-armlex4210.c     |    1 +
 arch/arm/mach-exynos4/mach-nuri.c           |    1 +
 arch/arm/mach-exynos4/mach-origen.c         |    1 +
 arch/arm/mach-exynos4/mach-smdk4x12.c       |    2 ++
 arch/arm/mach-exynos4/mach-smdkv310.c       |    2 ++
 arch/arm/mach-exynos4/mach-universal_c210.c |    1 +
 7 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 5b1765b..5b1ee56 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -27,7 +27,6 @@
 #include <plat/fb-core.h>
 #include <plat/fimc-core.h>
 #include <plat/iic-core.h>
-#include <plat/reset.h>
 #include <plat/tv-core.h>
 
 #include <mach/regs-irq.h>
@@ -145,7 +144,7 @@ static void exynos4_idle(void)
 	local_irq_enable();
 }
 
-static void exynos4_sw_reset(void)
+void exynos4_restart(char mode, const char *cmd)
 {
 	__raw_writel(0x1, S5P_SWRESET);
 }
@@ -286,8 +285,5 @@ int __init exynos4_init(void)
 	/* set idle function */
 	pm_idle = exynos4_idle;
 
-	/* set sw_reset function */
-	s5p_reset_hook = exynos4_sw_reset;
-
 	return sysdev_register(&exynos4_sysdev);
 }
diff --git a/arch/arm/mach-exynos4/mach-armlex4210.c b/arch/arm/mach-exynos4/mach-armlex4210.c
index f0ca6c1..9bb7e6c 100644
--- a/arch/arm/mach-exynos4/mach-armlex4210.c
+++ b/arch/arm/mach-exynos4/mach-armlex4210.c
@@ -212,4 +212,5 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.map_io		= armlex4210_map_io,
 	.init_machine	= armlex4210_machine_init,
 	.timer		= &exynos4_timer,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index 236bbe1..3504f56 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -1336,4 +1336,5 @@ MACHINE_START(NURI, "NURI")
 	.init_machine	= nuri_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve        = &nuri_reserve,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-origen.c b/arch/arm/mach-exynos4/mach-origen.c
index f80b563..161e5ee 100644
--- a/arch/arm/mach-exynos4/mach-origen.c
+++ b/arch/arm/mach-exynos4/mach-origen.c
@@ -697,4 +697,5 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.init_machine	= origen_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve	= &origen_reserve,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-smdk4x12.c b/arch/arm/mach-exynos4/mach-smdk4x12.c
index fcf2e0e..020284c 100644
--- a/arch/arm/mach-exynos4/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos4/mach-smdk4x12.c
@@ -289,6 +289,7 @@ MACHINE_START(SMDK4212, "SMDK4212")
 	.map_io		= smdk4x12_map_io,
 	.init_machine	= smdk4x12_machine_init,
 	.timer		= &exynos4_timer,
+	.restart	= exynos4_restart,
 MACHINE_END
 
 MACHINE_START(SMDK4412, "SMDK4412")
@@ -299,4 +300,5 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	.map_io		= smdk4x12_map_io,
 	.init_machine	= smdk4x12_machine_init,
 	.timer		= &exynos4_timer,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index cec2afa..fdf5535 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -378,6 +378,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	.init_machine	= smdkv310_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve	= &smdkv310_reserve,
+	.restart	= exynos4_restart,
 MACHINE_END
 
 MACHINE_START(SMDKC210, "SMDKC210")
@@ -387,4 +388,5 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.map_io		= smdkv310_map_io,
 	.init_machine	= smdkv310_machine_init,
 	.timer		= &exynos4_timer,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos4/mach-universal_c210.c b/arch/arm/mach-exynos4/mach-universal_c210.c
index a2a177f..4bdd30c 100644
--- a/arch/arm/mach-exynos4/mach-universal_c210.c
+++ b/arch/arm/mach-exynos4/mach-universal_c210.c
@@ -1061,4 +1061,5 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.init_machine	= universal_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve        = &universal_reserve,
+	.restart	= exynos4_restart,
 MACHINE_END
-- 
1.7.4.4
