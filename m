From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Jun 2013 18:47:32 +0800
Subject: [PATCH V2 1/4] ARM: tegra: cpuidle: move the init function behind the
 suspend init function
In-Reply-To: <1370342855-32705-1-git-send-email-josephl@nvidia.com>
References: <1370342855-32705-1-git-send-email-josephl@nvidia.com>
Message-ID: <1370342855-32705-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the state of CPUidle on Tegra can power gate the CPU and the
vdd_cpu rail. But it depends on some configurations from DT and a common
hook function for different Tegra SoCs to power gate the CPU rail. And
these stuffs are initialized after common Tegra suspend init function. So
we move the CPUidle init behind the suspend init function. And making the
CPUidle driver more generic.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* no change
---
 arch/arm/mach-tegra/common.c  |  2 ++
 arch/arm/mach-tegra/cpuidle.c | 14 ++++----------
 arch/arm/mach-tegra/cpuidle.h |  6 ++++++
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 95ce2a0..b25153e 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -29,6 +29,7 @@
 
 #include "board.h"
 #include "common.h"
+#include "cpuidle.h"
 #include "fuse.h"
 #include "iomap.h"
 #include "irq.h"
@@ -108,5 +109,6 @@ void __init tegra_init_early(void)
 void __init tegra_init_late(void)
 {
 	tegra_init_suspend();
+	tegra_cpuidle_init();
 	tegra_powergate_debugfs_init();
 }
diff --git a/arch/arm/mach-tegra/cpuidle.c b/arch/arm/mach-tegra/cpuidle.c
index 4b744c4..4a7a788 100644
--- a/arch/arm/mach-tegra/cpuidle.c
+++ b/arch/arm/mach-tegra/cpuidle.c
@@ -27,25 +27,19 @@
 #include "fuse.h"
 #include "cpuidle.h"
 
-static int __init tegra_cpuidle_init(void)
+void __init tegra_cpuidle_init(void)
 {
-	int ret;
-
 	switch (tegra_chip_id) {
 	case TEGRA20:
-		ret = tegra20_cpuidle_init();
+		tegra20_cpuidle_init();
 		break;
 	case TEGRA30:
-		ret = tegra30_cpuidle_init();
+		tegra30_cpuidle_init();
 		break;
 	case TEGRA114:
-		ret = tegra114_cpuidle_init();
+		tegra114_cpuidle_init();
 		break;
 	default:
-		ret = -ENODEV;
 		break;
 	}
-
-	return ret;
 }
-device_initcall(tegra_cpuidle_init);
diff --git a/arch/arm/mach-tegra/cpuidle.h b/arch/arm/mach-tegra/cpuidle.h
index d733f75..9bcf61f 100644
--- a/arch/arm/mach-tegra/cpuidle.h
+++ b/arch/arm/mach-tegra/cpuidle.h
@@ -35,4 +35,10 @@ int tegra114_cpuidle_init(void);
 static inline int tegra114_cpuidle_init(void) { return -ENODEV; }
 #endif
 
+#ifdef CONFIG_CPU_IDLE
+void tegra_cpuidle_init(void);
+#else
+static inline void tegra_cpuidle_init(void) {}
+#endif
+
 #endif
-- 
1.8.3
