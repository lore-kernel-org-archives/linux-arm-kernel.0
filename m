From: digetx@gmail.com (Dmitry Osipenko)
Date: Sun, 20 May 2018 13:15:42 +0300
Subject: [PATCH v1 5/5] ARM: tegra: Always boot CPU in ARM-mode
In-Reply-To: <20180520101542.12206-1-digetx@gmail.com>
References: <20180520101542.12206-1-digetx@gmail.com>
Message-ID: <20180520101542.12206-6-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU always jumps into the reset handler in ARM-mode from the Trusted
Foundations firmware, hence make CPU to always jump into kernel in
ARM-mode regardless of the firmware presence to support Thumb2 kernel + TF
case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 arch/arm/mach-tegra/reset.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index d84c74a95806..7e15c3bdf118 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -115,6 +115,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index b02ae7699842..3f1ef4561298 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -97,7 +97,7 @@ void __init tegra_cpu_reset_handler_init(void)
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
 		*((u32 *)cpu_possible_mask);
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_SECONDARY] =
-		__pa_symbol((void *)secondary_startup);
+		__pa_symbol((void *)secondary_startup_arm);
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.17.0
