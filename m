From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 17:20:09 +0800
Subject: [PATCH 5/7] ARM: tegra: hook the LP1 iram code area and sleep_core
 function for Tegra124
In-Reply-To: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381310411-11391-6-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support LP1, we need to hook sleep_core function. That will turn off
MMU and jump to the IRAM to execute the rest of LP1 suspend function.
And we need the the LP1 IRAM addr to backup the original content and
replace it with LP1 low level support code.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/Makefile | 1 +
 arch/arm/mach-tegra/pm.c     | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index de3748e..019bb17 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -36,6 +36,7 @@ ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
 endif
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= sleep-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= pm-tegra30.o
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= cpuidle-tegra114.o
 endif
diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 14e75b7..4ae0286 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -218,8 +218,10 @@ static bool tegra_lp1_iram_hook(void)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) ||
-		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC))
 			tegra30_lp1_iram_hook();
 		break;
 	default:
@@ -246,8 +248,10 @@ static bool tegra_sleep_core_init(void)
 		break;
 	case TEGRA30:
 	case TEGRA114:
+	case TEGRA124:
 		if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) ||
-		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC))
 			tegra30_sleep_core_init();
 		break;
 	default:
-- 
1.8.4
