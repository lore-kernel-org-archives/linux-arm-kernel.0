From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 23 Sep 2015 08:39:44 +0200
Subject: [PATCH v2 2/2] ARM: tegra: Disable cpuidle driver if PSCI is present
In-Reply-To: <cover.1442990383.git.jan.kiszka@siemens.com>
References: <cover.1442990383.git.jan.kiszka@siemens.com>
Message-ID: <5151ffebe8611545c55f8cc499cf2368b1b789c4.1442990383.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The firmware takes over the ownership of the flow controller when it
provides PSCI support. To avoid clashes, disable the Tegra cpuidle
driver if PSCI was detected.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/mach-tegra/Kconfig | 1 +
 arch/arm/mach-tegra/tegra.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 0fa4c5f..373768c 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -4,6 +4,7 @@ menuconfig ARCH_TEGRA
 	select ARCH_SUPPORTS_TRUSTED_FOUNDATIONS
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_PSCI
 	select CLKSRC_MMIO
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 2378fa56..d97c961 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -44,6 +44,7 @@
 #include <asm/mach-types.h>
 #include <asm/setup.h>
 #include <asm/trusted_foundations.h>
+#include <asm/psci.h>
 
 #include "board.h"
 #include "common.h"
@@ -136,7 +137,8 @@ static void __init tegra_dt_init_late(void)
 	int i;
 
 	tegra_init_suspend();
-	tegra_cpuidle_init();
+	if (!psci_smp_available())
+		tegra_cpuidle_init();
 
 	for (i = 0; i < ARRAY_SIZE(board_init_funcs); i++) {
 		if (of_machine_is_compatible(board_init_funcs[i].machine)) {
-- 
2.1.4
