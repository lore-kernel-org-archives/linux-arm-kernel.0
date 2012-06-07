From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 07 Jun 2012 00:13:13 -0600
Subject: [PATCH 08/11] ARM: OMAP2+: CM: increase the module disable timeout
In-Reply-To: <20120607060901.25532.68354.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
Message-ID: <20120607061312.25532.68396.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the timeout for disabling an IP block to five milliseconds.
This is to handle the usb_host_fs idle latency, which takes almost
four milliseconds after a host controller reset.

This is the second of two patches needed to resolve the following
boot warning:

omap_hwmod: usb_host_fs: _wait_target_disable failed

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm.h                   |   11 +++++++++++
 arch/arm/mach-omap2/cminst44xx.c           |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 99978c7..cf67617 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -28,4 +28,15 @@
  */
 #define MAX_MODULE_READY_TIME		2000
 
+/*
+ * MAX_MODULE_DISABLE_TIME: max duration in microseconds to wait for
+ * the PRCM to request that a module enter the inactive state in the
+ * case of OMAP2 & 3.  In the case of OMAP4 this is the max duration
+ * in microseconds for the module to reach the inactive state from
+ * a functional state.
+ * XXX FSUSB on OMAP4430 takes ~4ms to idle after reset during
+ * kernel init.
+ */
+#define MAX_MODULE_DISABLE_TIME		5000
+
 #endif
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 8c86d29..1a39945 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -313,9 +313,9 @@ int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_off
 
 	omap_test_timeout((_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) ==
 			   CLKCTRL_IDLEST_DISABLED),
-			  MAX_MODULE_READY_TIME, i);
+			  MAX_MODULE_DISABLE_TIME, i);
 
-	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
+	return (i < MAX_MODULE_DISABLE_TIME) ? 0 : -EBUSY;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 02daacc..20e45a6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -30,6 +30,7 @@
 #include <plat/mmc.h>
 #include <plat/dmtimer.h>
 #include <plat/common.h>
+#include <plat/usb.h>
 
 #include "omap_hwmod_common_data.h"
 
