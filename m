From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 20 Oct 2016 09:58:39 +0200
Subject: [PATCH 1/2] ARM: mxs: drop last board file user of enet_out
Message-ID: <20161020075840.16406-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethernet at 800f0000 node in the device tree for apx4devkit references
the enet_out clk (inherited from imx28.dtsi). This should be good enough
to drop its handling from the board file.

As this removes the last user of enable_clk_enet_out remove this
function, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/mach-mxs.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index e4f21086b42b..8f759d160828 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -233,14 +233,6 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
 	}
 }
 
-static inline void enable_clk_enet_out(void)
-{
-	struct clk *clk = clk_get_sys("enet_out", NULL);
-
-	if (!IS_ERR(clk))
-		clk_prepare_enable(clk);
-}
-
 static void __init imx28_evk_init(void)
 {
 	update_fec_mac_prop(OUI_FSL);
@@ -261,8 +253,6 @@ static int apx4devkit_phy_fixup(struct phy_device *phy)
 
 static void __init apx4devkit_init(void)
 {
-	enable_clk_enet_out();
-
 	if (IS_BUILTIN(CONFIG_PHYLIB))
 		phy_register_fixup_for_uid(PHY_ID_KSZ8051, MICREL_PHY_ID_MASK,
 					   apx4devkit_phy_fixup);
-- 
2.9.3
