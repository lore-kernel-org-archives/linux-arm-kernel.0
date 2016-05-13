From: briannorris@chromium.org (Brian Norris)
Date: Fri, 13 May 2016 14:09:43 -0700
Subject: [PATCH v2 2/4] phy: rockchip-emmc: configure frequency range and
 drive impedance
In-Reply-To: <1463092986-61777-2-git-send-email-briannorris@chromium.org>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <1463092986-61777-2-git-send-email-briannorris@chromium.org>
Message-ID: <20160513210943.GB99074@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Signal integrity analysis has suggested we set these values. Do this in
power_on(), so that they get reconfigured after suspend/resume.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v2:
 * Sent only patch 2/4 with version 2, to avoid spamming; will move on to v3
   for all patches if I need to send another
 * Drop 170 MHz comment; this was only applicable to a subtly different Arasan
   PHY

 drivers/phy/phy-rockchip-emmc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
index 48cbe691a889..f2f75cf69af1 100644
--- a/drivers/phy/phy-rockchip-emmc.c
+++ b/drivers/phy/phy-rockchip-emmc.c
@@ -56,6 +56,19 @@
 #define PHYCTRL_DLLRDY_SHIFT	0x5
 #define PHYCTRL_DLLRDY_DONE	0x1
 #define PHYCTRL_DLLRDY_GOING	0x0
+#define PHYCTRL_FREQSEL_200M	0x0
+#define PHYCTRL_FREQSEL_50M	0x1
+#define PHYCTRL_FREQSEL_100M	0x2
+#define PHYCTRL_FREQSEL_150M	0x3
+#define PHYCTRL_FREQSEL_MASK	0x3
+#define PHYCTRL_FREQSEL_SHIFT	0xc
+#define PHYCTRL_DR_MASK		0x7
+#define PHYCTRL_DR_SHIFT	0x4
+#define PHYCTRL_DR_50OHM	0x0
+#define PHYCTRL_DR_33OHM	0x1
+#define PHYCTRL_DR_66OHM	0x2
+#define PHYCTRL_DR_100OHM	0x3
+#define PHYCTRL_DR_40OHM	0x4
 
 struct rockchip_emmc_phy {
 	unsigned int	reg_offset;
@@ -154,6 +167,20 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
 	int ret = 0;
 
+	/* DLL operation: 200 MHz */
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
+		     HIWORD_UPDATE(PHYCTRL_FREQSEL_200M,
+				   PHYCTRL_FREQSEL_MASK,
+				   PHYCTRL_FREQSEL_SHIFT));
+
+	/* Drive impedance: 50 Ohm */
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
+		     HIWORD_UPDATE(PHYCTRL_DR_50OHM,
+				   PHYCTRL_DR_MASK,
+				   PHYCTRL_DR_SHIFT));
+
 	/* Power up emmc phy analog blocks */
 	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
 	if (ret)
-- 
2.8.0.rc3.226.g39d4020
