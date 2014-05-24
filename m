From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 24 May 2014 19:24:15 +0200
Subject: [PATCH] ARM: exynos: Fix kernel panic when unplugging CPU1 on 4210
In-Reply-To: <537FBE42.7050608@gmail.com>
References: <537FBE42.7050608@gmail.com>
Message-ID: <1400952255-13750-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A look at the code reveals use of S5P_VA_SYSRAM macro, in case of certain SoC
revisions, which is not valid any longer, after SYSRAM started to be mapped
dynamically. The new dynamic mapping is stored in sysram_base_addr variable,
which is declared static in platsmp.c

This fix makes sysram_base_addr non-static, declared it in common.h and used
in pm.c instead of S5P_VA_SYSRAM.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Suggested-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/common.h  |    1 +
 arch/arm/mach-exynos/platsmp.c |    2 +-
 arch/arm/mach-exynos/pm.c      |    4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index e2d0954..a012bc1 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -88,6 +88,7 @@ void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
 
 struct map_desc;
 extern void __iomem *sysram_ns_base_addr;
+extern void __iomem *sysram_base_addr;
 void exynos_init_io(void);
 void exynos_restart(enum reboot_mode mode, const char *cmd);
 void exynos_cpuidle_init(void);
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 9c16da2..f2bea78 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -32,7 +32,7 @@
 
 extern void exynos4_secondary_startup(void);
 
-static void __iomem *sysram_base_addr;
+void __iomem *sysram_base_addr;
 void __iomem *sysram_ns_base_addr;
 
 static void __init exynos_smp_prepare_sysram(void)
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index d10c351..87c0d34 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -168,10 +168,10 @@ int exynos_cluster_power_state(int cluster)
 
 #define EXYNOS_BOOT_VECTOR_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
 			S5P_INFORM7 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(S5P_VA_SYSRAM + 0x24) : S5P_INFORM0))
+			(sysram_base_addr + 0x24) : S5P_INFORM0))
 #define EXYNOS_BOOT_VECTOR_FLAG	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
 			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
-			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
+			(sysram_base_addr + 0x20) : S5P_INFORM1))
 
 #define S5P_CHECK_AFTR  0xFCBA0D10
 #define S5P_CHECK_SLEEP 0x00000BAD
-- 
1.7.9.5
