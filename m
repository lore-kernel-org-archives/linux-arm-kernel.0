From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 23 Aug 2016 10:04:27 +0100
Subject: [PATCH] ARM: sa1100: clear reset status prior to reboot
Message-ID: <E1bc7dD-0005Gk-2F@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clear the current reset status prior to rebooting the platform.  This
adds the bit missing from 04fef228fb00 ("[ARM] pxa: introduce
reset_status and clear_reset_status for driver's usage").

Fixes: 04fef228fb00 ("[ARM] pxa: introduce reset_status and clear_reset_status for driver's usage")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/generic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 2e2c35b8e0d4..3e09beddb6e8 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -34,6 +34,7 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
+#include <mach/reset.h>
 
 #include "generic.h"
 #include <clocksource/pxa.h>
@@ -95,6 +96,8 @@ static void sa1100_power_off(void)
 
 void sa11x0_restart(enum reboot_mode mode, const char *cmd)
 {
+	clear_reset_status(RESET_STATUS_ALL);
+
 	if (mode == REBOOT_SOFT) {
 		/* Jump into ROM at address 0 */
 		soft_restart(0);
-- 
2.1.0
