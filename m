From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  8 May 2012 21:46:25 +0800
Subject: [PATCH] ARM: imx6q: register phy fixup only when CONFIG_PHYLIB is
 enabled
In-Reply-To: <1336478520.23308.36.camel@sauron.fi.intel.com>
References: <1336478520.23308.36.camel@sauron.fi.intel.com>
Message-ID: <1336484785-8881-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It fixes the following compile error with network disabled in
imx_v6_v7_defconfig.

arch/arm/mach-imx/built-in.o: In function `ksz9021rn_phy_fixup':
imx53-dt.c:(.text+0x5f70): undefined reference to `mdiobus_write'
imx53-dt.c:(.text+0x5f84): undefined reference to `mdiobus_write'
imx53-dt.c:(.text+0x5f98): undefined reference to `mdiobus_write'
imx53-dt.c:(.text+0x5fac): undefined reference to `mdiobus_write'
imx53-dt.c:(.text+0x5fc0): undefined reference to `mdiobus_write'
arch/arm/mach-imx/built-in.o: In function `imx6q_init_machine':
imx53-dt.c:(.init.text+0x387c): undefined reference to `phy_register_fixup_for_uid'
make: *** [.tmp_vmlinux1] Error 1

Reported-by: Artem Bityutskiy <dedekind1@gmail.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index d25c5d8..2047d7d 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -63,21 +63,24 @@ soft:
 /* For imx6q sabrelite board: set KSZ9021RN RGMII pad skew */
 static int ksz9021rn_phy_fixup(struct phy_device *phydev)
 {
-	/* min rx data delay */
-	phy_write(phydev, 0x0b, 0x8105);
-	phy_write(phydev, 0x0c, 0x0000);
+	if (IS_ENABLED(CONFIG_PHYLIB)) {
+		/* min rx data delay */
+		phy_write(phydev, 0x0b, 0x8105);
+		phy_write(phydev, 0x0c, 0x0000);
 
-	/* max rx/tx clock delay, min rx/tx control delay */
-	phy_write(phydev, 0x0b, 0x8104);
-	phy_write(phydev, 0x0c, 0xf0f0);
-	phy_write(phydev, 0x0b, 0x104);
+		/* max rx/tx clock delay, min rx/tx control delay */
+		phy_write(phydev, 0x0b, 0x8104);
+		phy_write(phydev, 0x0c, 0xf0f0);
+		phy_write(phydev, 0x0b, 0x104);
+	}
 
 	return 0;
 }
 
 static void __init imx6q_sabrelite_init(void)
 {
-	phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
+	if (IS_ENABLED(CONFIG_PHYLIB))
+		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
 				ksz9021rn_phy_fixup);
 }
 
-- 
1.7.5.4
