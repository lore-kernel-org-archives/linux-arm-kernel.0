From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 31 Jan 2012 18:40:45 +0200
Subject: [PATCH v2 7/8] ARM: tegra: support for Tegra30 CPU powerdomains
In-Reply-To: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
References: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1328028051-24271-8-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Secondary CPU powerdomains can be powergated on Tegra30. Add the necessary
functions to do this. This will be used to boot the secondary CPUs later on.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/common.c                 |    3 +++
 arch/arm/mach-tegra/include/mach/powergate.h |    3 +++
 arch/arm/mach-tegra/powergate.c              |   19 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 51dcbdff..0ad5c23 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -28,6 +28,7 @@
 
 #include <mach/iomap.h>
 #include <mach/system.h>
+#include <mach/powergate.h>
 
 #include "board.h"
 #include "clock.h"
@@ -117,6 +118,7 @@ void __init tegra20_init_early(void)
 	tegra2_init_clocks();
 	tegra_clk_init_from_table(tegra20_clk_init_table);
 	tegra_init_cache(0x331, 0x441);
+	tegra_powergate_init();
 }
 #endif
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
@@ -125,5 +127,6 @@ void __init tegra30_init_early(void)
 	tegra_init_fuse();
 	tegra30_init_clocks();
 	tegra_init_cache(0x441, 0x551);
+	tegra_powergate_init();
 }
 #endif
diff --git a/arch/arm/mach-tegra/include/mach/powergate.h b/arch/arm/mach-tegra/include/mach/powergate.h
index ca41186..4752b1a 100644
--- a/arch/arm/mach-tegra/include/mach/powergate.h
+++ b/arch/arm/mach-tegra/include/mach/powergate.h
@@ -38,6 +38,9 @@
 #define TEGRA_POWERGATE_CPU0	TEGRA_POWERGATE_CPU
 #define TEGRA_POWERGATE_3D0	TEGRA_POWERGATE_3D
 
+int  __init tegra_powergate_init(void);
+
+int tegra_cpu_powergate_id(int cpuid);
 int tegra_powergate_is_powered(int id);
 int tegra_powergate_power_on(int id);
 int tegra_powergate_power_off(int id);
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 7120ad7..c238699 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -41,6 +41,14 @@
 #define PWRGATE_STATUS		0x38
 
 static int tegra_num_powerdomains;
+static int tegra_num_cpu_domains;
+static u8 *tegra_cpu_domains;
+static u8 tegra30_cpu_domains[] = {
+	TEGRA_POWERGATE_CPU0,
+	TEGRA_POWERGATE_CPU1,
+	TEGRA_POWERGATE_CPU2,
+	TEGRA_POWERGATE_CPU3,
+};
 
 static DEFINE_SPINLOCK(tegra_powergate_lock);
 
@@ -161,6 +169,14 @@ err_power:
 	return ret;
 }
 
+int tegra_cpu_powergate_id(int cpuid)
+{
+	if (cpuid > 0 && cpuid < tegra_num_cpu_domains)
+		return tegra_cpu_domains[cpuid];
+
+	return -EINVAL;
+}
+
 int __init tegra_powergate_init(void)
 {
 	switch (tegra_chip_id) {
@@ -169,6 +185,8 @@ int __init tegra_powergate_init(void)
 		break;
 	case TEGRA30:
 		tegra_num_powerdomains = 14;
+		tegra_num_cpu_domains = 4;
+		tegra_cpu_domains = tegra30_cpu_domains;
 		break;
 	default:
 		/* Unknown Tegra variant. Disable powergating */
@@ -178,7 +196,6 @@ int __init tegra_powergate_init(void)
 
 	return 0;
 }
-arch_initcall(tegra_powergate_init);
 
 #ifdef CONFIG_DEBUG_FS
 
-- 
1.7.7.rc0.72.g4b5ea.dirty
