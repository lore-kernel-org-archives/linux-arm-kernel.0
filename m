From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 11 Oct 2013 17:57:32 +0800
Subject: [PATCH V2 4/4] ARM: tegra: enable CPU idle for Tegra124
In-Reply-To: <1381485452-3561-1-git-send-email-josephl@nvidia.com>
References: <1381485452-3561-1-git-send-email-josephl@nvidia.com>
Message-ID: <1381485452-3561-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPUIdle function of Tegra124 is identical to Tegra114, so we share
the same driver with Tegra114.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/mach-tegra/Makefile  | 3 +++
 arch/arm/mach-tegra/cpuidle.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 04ca2b3..de3748e 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -36,5 +36,8 @@ ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
 endif
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= sleep-tegra30.o
+ifeq ($(CONFIG_CPU_IDLE),y)
+obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= cpuidle-tegra114.o
+endif
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-paz00.o
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index 0961dfc..7bc5d8d 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -39,7 +39,9 @@ void __init tegra_cpuidle_init(void)
 			tegra30_cpuidle_init();
 		break;
 	case TEGRA114:
-		if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC))
+	case TEGRA124:
+		if (IS_ENABLED(CONFIG_ARCH_TEGRA_114_SOC) ||
+		    IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC))
 			tegra114_cpuidle_init();
 		break;
 	}
-- 
1.8.4
