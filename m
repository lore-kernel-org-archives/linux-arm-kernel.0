From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 30 Sep 2013 13:00:21 +0900
Subject: [PATCH 2/5] ARM: shmobile: Lager: add Micrel KSZ8041 PHY fixup
In-Reply-To: <cover.1380513421.git.horms+renesas@verge.net.au>
References: <cover.1380513421.git.horms+renesas@verge.net.au>
Message-ID: <48c8b96f21817aad695246ef020b849d466cc502.1380513421.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Currently on the Lager board NFS timeouts/delays are seen when booting.  That
turned out to happen because the SoC's ETH_LINK signal turns on and off after
each packet.  It is connected to Micrel KSZ8041 PHY's LED0 signal. Ether LEDs
on the Lager board are named LINK and ACTIVE which corresponds to non-default
01 setting of the PHY control register 1 bits 14-15. The 'sh_eth' driver resets
the PHY when opening the network device, so we have to set the mentioned bits
back to 01 from the default 00 value which causes bouncing of ETH_LINK.  That
can be achieved using the PHY platform fixup mechanism if we also modify the
driver to use it..

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index ffb6f0a..5930af8 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -29,6 +29,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
+#include <linux/phy.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
@@ -155,6 +156,30 @@ static void __init lager_add_standard_devices(void)
 					  &ether_pdata, sizeof(ether_pdata));
 }
 
+/*
+ * Ether LEDs on the Lager board are named LINK and ACTIVE which corresponds
+ * to non-default 01 setting of the Micrel KSZ8041 PHY control register 1 bits
+ * 14-15. We have to set them back to 01 from the default 00 value each time
+ * the PHY is reset. It's also important because the PHY's LED0 signal is
+ * connected to SoC's ETH_LINK signal and in the PHY's default mode it will
+ * bounce on and off after each packet, which we apparently want to avoid.
+ */
+static int lager_ksz8041_fixup(struct phy_device *phydev)
+{
+	u16 phyctrl1 = phy_read(phydev, 0x1e);
+
+	phyctrl1 &= ~0xc000;
+	phyctrl1 |= 0x4000;
+	return phy_write(phydev, 0x1e, phyctrl1);
+}
+
+static void __init lager_init(void)
+{
+	lager_add_standard_devices();
+
+	phy_register_fixup_for_id("r8a7790-ether-ff:01", lager_ksz8041_fixup);
+}
+
 static const char *lager_boards_compat_dt[] __initdata = {
 	"renesas,lager",
 	NULL,
@@ -163,6 +188,6 @@ static const char *lager_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(LAGER_DT, "lager")
 	.init_early	= r8a7790_init_delay,
 	.init_time	= r8a7790_timer_init,
-	.init_machine	= lager_add_standard_devices,
+	.init_machine	= lager_init,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
-- 
1.8.4
