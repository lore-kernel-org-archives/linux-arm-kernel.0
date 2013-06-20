From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Jun 2013 17:34:31 +0200
Subject: [PATCH 1/3] ARM: i.MX6: call ksz9021 phy fixup for all i.MX6 boards
In-Reply-To: <1371742473-28026-1-git-send-email-s.hauer@pengutronix.de>
References: <1371742473-28026-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1371742473-28026-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current U-Boot the sabrelite, nitrogen6x and titanium all need
the same fixup for the ksz9021 phy. Instead of limiting the fixup
to a single board apply them for all.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx6q.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 5536fd8..e5f4a5b 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -137,12 +137,12 @@ put_clk:
 		clk_put(cko1);
 }
 
-static void __init imx6q_sabrelite_init(void)
+static void __init imx6q_enet_phy_init(void)
 {
-	if (IS_BUILTIN(CONFIG_PHYLIB))
+	if (IS_BUILTIN(CONFIG_PHYLIB)) {
 		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
 				ksz9021rn_phy_fixup);
-	imx6q_sabrelite_cko1_setup();
+	}
 }
 
 static void __init imx6q_1588_init(void)
@@ -164,7 +164,9 @@ static void __init imx6q_usb_init(void)
 static void __init imx6q_init_machine(void)
 {
 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
-		imx6q_sabrelite_init();
+		imx6q_sabrelite_cko1_setup();
+
+	imx6q_enet_phy_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.8.3.1
