From: tommy.lin.1101@gmail.com (Tommy Lin)
Date: Fri,  8 Jul 2011 13:59:23 +0800
Subject: [PATCH 1/2] arch: arm: Correct the dependency of HAVE_ARM_TWD
Message-ID: <1310104763-12948-1-git-send-email-tommy.lin@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Original mpcore_wdt config dependency is as follow:
MPCORE_WATCHDOG -> HAVE_ARM_TWD -> SMP -> (CPU_V6K || CPU_V7)
This patch will remove SMP and made the dependency as follow:
MPCORE_WATCHDOG -> HAVE_ARM_TWD -> (CPU_V6K || CPU_V7)

The MPCore watchdog (and timer) can be found at ARM11 MPCore (CPU_V6K) and
Cortex A9 MPCore (CPU_V7). The dependency between MPCORE_WATCHDOG and
(CPU_V6K || CPUV7) is necessary, but the dependency of SMP is redundant.
The MPCore watchdog should function normally even SMP is not turned on with
ARM11 or Cortex A9 CPU.

Signed-off-by: Tommy Lin <tommy.lin@caviumnetworks.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3262b15..c148326 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1353,7 +1353,7 @@ config HAVE_ARM_SCU
 
 config HAVE_ARM_TWD
 	bool
-	depends on SMP
+	depends on CPU_V6K || CPU_V7
 	select TICK_ONESHOT
 	help
 	  This options enables support for the ARM timer and watchdog unit
-- 
1.7.6
