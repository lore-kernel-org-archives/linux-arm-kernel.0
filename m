From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 11 Jun 2013 10:09:45 +0200
Subject: [PATCH] cpuidle: Fix ARCH_NEEDS_CPU_IDLE_COUPLED dependency warning
Message-ID: <1370938185-5019-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before the commit d6f346f2d2bf511c2c59176121a6e42ce60173a0, the
ARCH_NEEDS_CPU_IDLE_COUPLED option was not depending on the CPU_IDLE but now
it has been moved under the CPU_IDLE menuconfig option.

That raises the following warnings:

warning: (ARCH_OMAP4 && ARCH_TEGRA_2x_SOC) selects ARCH_NEEDS_CPU_IDLE_COUPLED
which has unmet direct dependencies (CPU_IDLE)
warning: (ARCH_OMAP4 && ARCH_TEGRA_2x_SOC) selects ARCH_NEEDS_CPU_IDLE_COUPLED
which has unmet direct dependencies (CPU_IDLE)

The tegra2 and omap4 Kconfig files select this option but without checking
CPU_IDLE is set.

Fix that by moving the option out of the CPU_IDLE option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index a7d2e83..81de5d9 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -29,9 +29,6 @@ config CPU_IDLE_GOV_MENU
 	bool "Menu governor (for tickless system)"
 	default y
 
-config ARCH_NEEDS_CPU_IDLE_COUPLED
-	def_bool n
-
 config CPU_IDLE_CALXEDA
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARCH_HIGHBANK
@@ -45,3 +42,6 @@ config CPU_IDLE_ZYNQ
 	  Select this to enable cpuidle on Xilinx Zynq processors.
 
 endif
+
+config ARCH_NEEDS_CPU_IDLE_COUPLED
+	def_bool n
-- 
1.7.9.5
