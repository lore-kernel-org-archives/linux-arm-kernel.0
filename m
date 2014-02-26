From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 26 Feb 2014 09:50:47 -0300
Subject: [PATCH 2/2] ARM: mvebu: system-controller: Add A375 initialization
In-Reply-To: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1393419047-10071-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370/375/XP SoC family watchdog controller has a dedicated
RSTOUT register to mask/unmask the watchdog reset. However, the A375
SoC has also a bit to mask the watchdog reset (WDT_RSTOUT), in the RSTOUT
global register that is handled by the system-controller.

Therefore, let's add a per-SoC initialization routine to unmask the watchdog
reset in the shared system-controller register, in this initialization.
The dedicated register for watchdog RSTOUT is handled by the watchdog
driver, just as is done for the rest of mvebu SoCs.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/system-controller.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 614ba68..96c0a68 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -29,6 +29,8 @@
 #include <linux/reboot.h>
 #include "common.h"
 
+#define A375_RSTOUT_WDT_MASK BIT(10)
+
 static void __iomem *system_controller_base;
 
 struct mvebu_system_controller {
@@ -37,9 +39,33 @@ struct mvebu_system_controller {
 
 	u32 rstoutn_mask_reset_out_en;
 	u32 system_soft_reset;
+
+	int (*init)(void);
 };
 static struct mvebu_system_controller *mvebu_sc;
 
+int armada_375_system_controller_init(void)
+{
+	u32 reg;
+
+	/*
+	 * The Armada 370/375/XP SoC family watchdog controller has a
+	 * dedicated RSTOUT register to mask/unmask the watchdog reset.
+	 * However, the A375 SoC also has a bit to mask the watchdog reset
+	 * (WDT_RSTOUT), in the RSTOUT global register that is handled by the
+	 * system-controller.
+	 *
+	 * Therefore, we unmask the watchdog reset in the shared
+	 * system-controller register, in this initialization. The dedicated
+	 * register for watchdog RSTOUT is handled by the watchdog driver.
+	 */
+	reg = readl(system_controller_base + mvebu_sc->rstoutn_mask_offset);
+	reg &= ~A375_RSTOUT_WDT_MASK;
+	writel(reg, system_controller_base + mvebu_sc->rstoutn_mask_offset);
+
+	return 0;
+}
+
 static const struct mvebu_system_controller armada_370_xp_system_controller = {
 	.rstoutn_mask_offset = 0x60,
 	.system_soft_reset_offset = 0x64,
@@ -52,6 +78,7 @@ static const struct mvebu_system_controller armada_375_system_controller = {
 	.system_soft_reset_offset = 0x58,
 	.rstoutn_mask_reset_out_en = 0x1,
 	.system_soft_reset = 0x1,
+	.init = armada_375_system_controller_init,
 };
 
 static const struct mvebu_system_controller orion_system_controller = {
@@ -109,6 +136,9 @@ static int __init mvebu_system_controller_init(void)
 		system_controller_base = of_iomap(np, 0);
 		mvebu_sc = (struct mvebu_system_controller *)match->data;
 		of_node_put(np);
+
+		if (mvebu_sc->init)
+			mvebu_sc->init();
 	}
 
 	return 0;
-- 
1.8.1.5
