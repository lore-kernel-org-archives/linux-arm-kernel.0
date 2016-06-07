From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 18:14:56 +0100
Subject: [PATCH] phy-sun4i-usb: fix missing __iomem *
Message-ID: <1465319696-1275-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the missing __iomem attribute in sun4i_usb_phy_write()
function. This fixes the following sparse warnings:

drivers/phy/phy-sun4i-usb.c:178:39: warning: incorrect type in initializer (different address spaces)
drivers/phy/phy-sun4i-usb.c:178:39:    expected void *phyctl
drivers/phy/phy-sun4i-usb.c:178:39:    got void [noderef] <asn:2>*
drivers/phy/phy-sun4i-usb.c:185:17: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/phy-sun4i-usb.c:185:17:    expected void volatile [noderef] <asn:2>*addr
drivers/phy/phy-sun4i-usb.c:185:17:    got void *phyctl
drivers/phy/phy-sun4i-usb.c:189:24: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/phy-sun4i-usb.c:189:24:    expected void const volatile [noderef] <asn:2>*addr
drivers/phy/phy-sun4i-usb.c:189:24:    got void *phyctl
drivers/phy/phy-sun4i-usb.c:196:17: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/phy-sun4i-usb.c:196:17:    expected void volatile [noderef] <asn:2>*addr
drivers/phy/phy-sun4i-usb.c:196:17:    got void *phyctl
drivers/phy/phy-sun4i-usb.c:199:24: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/phy-sun4i-usb.c:199:24:    expected void const volatile [noderef] <asn:2>*addr
drivers/phy/phy-sun4i-usb.c:199:24:    got void *phyctl
drivers/phy/phy-sun4i-usb.c:205:17: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/phy-sun4i-usb.c:205:17:    expected void volatile [noderef] <asn:2>*addr
drivers/phy/phy-sun4i-usb.c:205:17:    got void *phyctl
drivers/phy/phy-sun4i-usb.c:208:24: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/phy-sun4i-usb.c:208:24:    expected void const volatile [noderef] <asn:2>*addr
drivers/phy/phy-sun4i-usb.c:208:24:    got void *phyctl
drivers/phy/phy-sun4i-usb.c:210:17: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/phy-sun4i-usb.c:210:17:    expected void volatile [noderef] <asn:2>*addr
drivers/phy/phy-sun4i-usb.c:210:17:    got void *phyctl
drivers/phy/phy-sun4i-usb.c:212:24: warning: incorrect type in argument 1 (different address spaces)
drivers/phy/phy-sun4i-usb.c:212:24:    expected void const volatile [noderef] <asn:2>*addr
drivers/phy/phy-sun4i-usb.c:212:24:    got void *phyctl
drivers/phy/phy-sun4i-usb.c:214:17: warning: incorrect type in argument 2 (different address spaces)
drivers/phy/phy-sun4i-usb.c:214:17:    expected void volatile [noderef] <asn:2>*addr
drivers/phy/phy-sun4i-usb.c:214:17:    got void *phyctl

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/phy/phy-sun4i-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index bae54f7..9de9991 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -175,7 +175,7 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
 {
 	struct sun4i_usb_phy_data *phy_data = to_sun4i_usb_phy_data(phy);
 	u32 temp, usbc_bit = BIT(phy->index * 2);
-	void *phyctl = phy_data->base + phy_data->cfg->phyctl_offset;
+	void __iomem *phyctl = phy_data->base + phy_data->cfg->phyctl_offset;
 	int i;
 
 	mutex_lock(&phy_data->mutex);
-- 
2.8.1
