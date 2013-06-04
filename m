From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Jun 2013 18:47:34 +0800
Subject: [PATCH V2 3/4] ARM: tegra: cpuidle: using IS_ENABLED for multi SoCs
 management in init func
In-Reply-To: <1370342855-32705-1-git-send-email-josephl@nvidia.com>
References: <1370342855-32705-1-git-send-email-josephl@nvidia.com>
Message-ID: <1370342855-32705-4-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the Tegra CPUidle init function by using IS_ENABLED for multi
SoCs management in the init function.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* fix the coding style of the runtime chip selection
---
 arch/arm/mach-tegra/cpuidle.c | 11 ++++++-----
 arch/arm/mach-tegra/cpuidle.h | 17 +----------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index 4a7a788..e85973c 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -31,15 +31,16 @@ void __init tegra_cpuidle_init(void)
 {
 	switch (tegra_chip_id) {
 	case TEGRA20:
-		tegra20_cpuidle_init();
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC))
+			tegra20_cpuidle_init();
 		break;
 	case TEGRA30:
-		tegra30_cpuidle_init();
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC))
+			tegra30_cpuidle_init();
 		break;
 	case TEGRA114:
-		tegra114_cpuidle_init();
-		break;
-	default:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
+			tegra114_cpuidle_init();
 		break;
 	}
 }
diff --git a/arch/arm/mach-tegra/cpuidle.h b/arch/arm/mach-tegra/cpuidle.h
index 9bcf61f..9ec2c1a 100644
--- a/arch/arm/mach-tegra/cpuidle.h
+++ b/arch/arm/mach-tegra/cpuidle.h
@@ -17,25 +17,10 @@
 #ifndef __MACH_TEGRA_CPUIDLE_H
 #define __MACH_TEGRA_CPUIDLE_H
 
-#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+#ifdef CONFIG_CPU_IDLE
 int tegra20_cpuidle_init(void);
-#else
-static inline int tegra20_cpuidle_init(void) { return -ENODEV; }
-#endif
-
-#ifdef CONFIG_ARCH_TEGRA_3x_SOC
 int tegra30_cpuidle_init(void);
-#else
-static inline int tegra30_cpuidle_init(void) { return -ENODEV; }
-#endif
-
-#ifdef CONFIG_ARCH_TEGRA_114_SOC
 int tegra114_cpuidle_init(void);
-#else
-static inline int tegra114_cpuidle_init(void) { return -ENODEV; }
-#endif
-
-#ifdef CONFIG_CPU_IDLE
 void tegra_cpuidle_init(void);
 #else
 static inline void tegra_cpuidle_init(void) {}
-- 
1.8.3
