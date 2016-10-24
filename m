From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon, 24 Oct 2016 11:59:30 +0800
Subject: [PATCH 1/3] phy: sun4i: check PHY id when poking unknown bit of pmu
Message-ID: <20161024035930.20274-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoC's PHY 0, when used as OTG controller, have no pmu part.
The code that poke some unknown bit of PMU for H3/A64 didn't check
the PHY, and will cause kernel oops when PHY 0 is used.

Fixes: b3e0d141ca9f (phy: sun4i: add support for A64 usb phy)

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/phy/phy-sun4i-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index b9342a2..ff8e9dd 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -264,7 +264,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		return ret;
 	}
 
-	if (data->cfg->enable_pmu_unk1) {
+	if (phy->index != 0 && data->cfg->enable_pmu_unk1) {
 		val = readl(phy->pmu + REG_PMU_UNK1);
 		writel(val & ~2, phy->pmu + REG_PMU_UNK1);
 	}
-- 
2.10.1
