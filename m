From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 11:34:27 -0300
Subject: [PATCH 03/15] ARM: mvebu: Add watchdog RSTOUT enable in
 system-controller init
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377614079-10000-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matching the other orion platforms, enable the watchdog RSTOUT at
initialization time to allow watchdog support.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/system-controller.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index f875124..1dddd08 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -35,6 +35,7 @@ struct mvebu_system_controller {
 	u32 system_soft_reset_offset;
 
 	u32 rstoutn_mask_reset_out_en;
+	u32 rstoutn_mask_reset_wdt_en;
 	u32 system_soft_reset;
 };
 static struct mvebu_system_controller *mvebu_sc;
@@ -43,6 +44,7 @@ const struct mvebu_system_controller armada_370_xp_system_controller = {
 	.rstoutn_mask_offset = 0x60,
 	.system_soft_reset_offset = 0x64,
 	.rstoutn_mask_reset_out_en = 0x1,
+	.rstoutn_mask_reset_wdt_en = 0x100,
 	.system_soft_reset = 0x1,
 };
 
@@ -50,6 +52,7 @@ const struct mvebu_system_controller orion_system_controller = {
 	.rstoutn_mask_offset = 0x108,
 	.system_soft_reset_offset = 0x10c,
 	.rstoutn_mask_reset_out_en = 0x4,
+	.rstoutn_mask_reset_wdt_en = 0x2,
 	.system_soft_reset = 0x1,
 };
 
@@ -87,6 +90,24 @@ void mvebu_restart(enum reboot_mode mode, const char *cmd)
 		;
 }
 
+static void __init mvebu_wdt_rstout_init(struct device_node *np)
+{
+	void __iomem *wdt_rstout_base;
+	u32 reg;
+
+	if (of_device_is_compatible(np, "marvell,orion-system-controller"))
+		wdt_rstout_base = system_controller_base +
+				  mvebu_sc->rstoutn_mask_offset;
+	else
+		wdt_rstout_base = of_iomap(np, 1);
+
+	if (WARN_ON(!wdt_rstout_base))
+		return;
+	reg = readl(wdt_rstout_base);
+	reg |= mvebu_sc->rstoutn_mask_reset_wdt_en;
+	writel(reg, wdt_rstout_base);
+};
+
 static int __init mvebu_system_controller_init(void)
 {
 	struct device_node *np;
@@ -98,6 +119,7 @@ static int __init mvebu_system_controller_init(void)
 		BUG_ON(!match);
 		system_controller_base = of_iomap(np, 0);
 		mvebu_sc = (struct mvebu_system_controller *)match->data;
+		mvebu_wdt_rstout_init(np);
 	}
 
 	return 0;
-- 
1.8.1.5
