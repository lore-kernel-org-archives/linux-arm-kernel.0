From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 13 Nov 2014 11:08:18 +0530
Subject: [PATCH] ARM: b.L: fix unmet dependency for CPU_PM
Message-ID: <1415857098-16928-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If BL_SWITCHER is enabled but SUSPEND and CPU_IDLE is not enabled
we are getting following config warning.

warning: (BL_SWITCHER) selects CPU_PM which has unmet direct
dependencies (SUSPEND || CPU_IDLE)

So BL_SWITCHER should enable CPU_PM only if either of SUSPEND or
CPU_IDLE is selected.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9d580d0..fe3d969 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1417,7 +1417,7 @@ config BL_SWITCHER
 	bool "big.LITTLE switcher support"
 	depends on BIG_LITTLE && MCPM && HOTPLUG_CPU
 	select ARM_CPU_SUSPEND
-	select CPU_PM
+	select CPU_PM if (SUSPEND || CPU_IDLE)
 	help
 	  The big.LITTLE "switcher" provides the core functionality to
 	  transparently handle transition between a cluster of A15's
-- 
1.7.9.5
