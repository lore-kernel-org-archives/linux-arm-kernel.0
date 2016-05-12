From: briannorris@chromium.org (Brian Norris)
Date: Thu, 12 May 2016 15:43:05 -0700
Subject: [PATCH 3/4] phy: rockchip-emmc: configure default output tap delay
In-Reply-To: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
Message-ID: <1463092986-61777-3-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The output tap delay controls helps maintain the hold requirements for
eMMC. The exact value is dependent on the SoC and other factors, though
it isn't really an exact science. But the default of 0 is not very good,
as it doesn't give the eMMC much hold time, so let's bump up to 4
(approx 90 degree phase?). If we need to configure this any further
(e.g., based on board or speed factors), we may need to consider a
device tree representation.

Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/phy/phy-rockchip-emmc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
index 5641dede32f6..f94d3a6587ed 100644
--- a/drivers/phy/phy-rockchip-emmc.c
+++ b/drivers/phy/phy-rockchip-emmc.c
@@ -69,6 +69,11 @@
 #define PHYCTRL_DR_66OHM	0x2
 #define PHYCTRL_DR_100OHM	0x3
 #define PHYCTRL_DR_40OHM	0x4
+#define PHYCTRL_OTAPDLYENA		0x1
+#define PHYCTRL_OTAPDLYENA_MASK		0x1
+#define PHYCTRL_OTAPDLYENA_SHIFT	0xb
+#define PHYCTRL_OTAPDLYSEL_MASK		0xf
+#define PHYCTRL_OTAPDLYSEL_SHIFT	0x7
 
 struct rockchip_emmc_phy {
 	unsigned int	reg_offset;
@@ -181,6 +186,20 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
 				   PHYCTRL_DR_MASK,
 				   PHYCTRL_DR_SHIFT));
 
+	/* Output tap delay: enable */
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
+		     HIWORD_UPDATE(PHYCTRL_OTAPDLYENA,
+				   PHYCTRL_OTAPDLYENA_MASK,
+				   PHYCTRL_OTAPDLYENA_SHIFT));
+
+	/* Output tap delay */
+	regmap_write(rk_phy->reg_base,
+		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
+		     HIWORD_UPDATE(4,
+				   PHYCTRL_OTAPDLYSEL_MASK,
+				   PHYCTRL_OTAPDLYSEL_SHIFT));
+
 	/* Power up emmc phy analog blocks */
 	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
 	if (ret)
-- 
2.8.0.rc3.226.g39d4020
