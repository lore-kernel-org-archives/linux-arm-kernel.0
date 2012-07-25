From: kbaidarov@dev.rtsoft.ru (Konstantin Baydarov)
Date: Wed, 25 Jul 2012 15:05:19 +0400
Subject: [PATCH v4 3/4] OMAP2+: use control module mfd driver in omap_type
Message-ID: <500FD2EF.4010304@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP system control module can be probed early, then
omap_type is safe to use its APIs.

TODO: add support for other omap versions

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
---
 arch/arm/mach-omap2/id.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 40373db..8018cad 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mfd/omap_control.h>
 
 #include <asm/cputype.h>
 
@@ -43,15 +44,15 @@ int omap_type(void)
 	u32 val = 0;
 
 	if (cpu_is_omap24xx()) {
-		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+		val = omap_control_status_read();
 	} else if (soc_is_am33xx()) {
-		val = omap_ctrl_readl(AM33XX_CONTROL_STATUS);
+		val = omap_control_status_read();
 	} else if (cpu_is_omap34xx()) {
-		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
+		val = omap_control_status_read();
 	} else if (cpu_is_omap44xx()) {
-		val = omap_ctrl_readl(OMAP4_CTRL_MODULE_CORE_STATUS);
+		val = omap_control_status_read();
 	} else if (soc_is_omap54xx()) {
-		val = omap_ctrl_readl(OMAP5XXX_CONTROL_STATUS);
+		val = omap_control_status_read();
 		val &= OMAP5_DEVICETYPE_MASK;
 		val >>= 6;
 		goto out;
-- 
1.7.7.6
