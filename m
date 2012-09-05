From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  5 Sep 2012 10:16:51 -0600
Subject: [PATCH] ARM: enable SUSPEND/ARCH_SUSPEND_POSSIBLE for ARCH_TEGRA
Message-ID: <1346861811-6597-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Even though system suspend/resume hasn't been validated on Tegra yet,
this Kconfig option needs to be enabled so that system shutdown is
reliable on an SMP system. Without it, I2C interrupts may be routed
to CPU0, whereas shutdown code may be running on CPU1, causing I2C
timeouts, preventing communication with the external PMIC.

This reverts 3d5e8af "ARM: disable SUSPEND/ARCH_SUSPEND_POSSIBLE for
ARCH_TEGRA".

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 88ff698..0dd1fca 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2247,7 +2247,7 @@ menu "Power management options"
 source "kernel/power/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
-	depends on !ARCH_S5PC100 && !ARCH_TEGRA
+	depends on !ARCH_S5PC100
 	depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
 		CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE || CPU_MOHAWK
 	def_bool y
-- 
1.7.0.4
