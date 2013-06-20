From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Jun 2013 17:34:33 +0200
Subject: [PATCH 3/3] ARM: i.MX6: add ethernet phy fixup for KSZ9031
In-Reply-To: <1371742473-28026-1-git-send-email-s.hauer@pengutronix.de>
References: <1371742473-28026-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1371742473-28026-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KSZ9031 is used on the i.MX6 based Data Modul eDM-QMX6
board. It needs the same fixup to the rx/tx delays as other
i.MX6 boards.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-imx6q.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 69fae87..2f02875 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -113,6 +113,27 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
+static void mmd_write_reg(struct phy_device *dev, int device, int reg, int val)
+{
+	phy_write(dev, 0x0d, device);
+	phy_write(dev, 0x0e, reg);
+	phy_write(dev, 0x0d, (1 << 14) | device);
+	phy_write(dev, 0x0e, val);
+}
+
+static int ksz9031rn_phy_fixup(struct phy_device *dev)
+{
+	/*
+	 * min rx data delay, max rx/tx clock delay,
+	 * min rx/tx control delay
+	 */
+	mmd_write_reg(dev, 2, 4, 0);
+	mmd_write_reg(dev, 2, 5, 0);
+	mmd_write_reg(dev, 2, 8, 0x003ff);
+
+	return 0;
+}
+
 static int ar8031_phy_fixup(struct phy_device *dev)
 {
 	u16 val;
@@ -167,6 +188,8 @@ static void __init imx6q_enet_phy_init(void)
 	if (IS_BUILTIN(CONFIG_PHYLIB)) {
 		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
 				ksz9021rn_phy_fixup);
+		phy_register_fixup_for_uid(PHY_ID_KSZ9031, MICREL_PHY_ID_MASK,
+				ksz9031rn_phy_fixup);
 		phy_register_fixup_for_uid(PHY_ID_AR8031, 0xffffffff,
 				ar8031_phy_fixup);
 	}
-- 
1.8.3.1
