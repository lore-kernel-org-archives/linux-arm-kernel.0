From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  5 Jun 2017 01:53:23 +0800
Subject: [PATCH] net-next: stmmac: dwmac-sun8i: ensure the EPHY is properly
 reseted
Message-ID: <20170604175323.62124-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EPHY may be already enabled by bootloaders which have Ethernet
capability (e.g. current U-Boot). Thus it should be reseted properly
before doing the enabling sequence in the dwmac-sun8i driver, otherwise
the EMAC reset process may fail if no cable is plugged, and then fail
the dwmac-sun8i probing.

Tested on Orange Pi PC, One and Zero. All the boards fail to have
dwmac-sun8i probed with "EMAC reset timeout" without cable plugged
before, and with this fix they're now all able to successfully probe the
EMAC without cable plugged and then use the connection after a cable is
hot-plugged in.

Fixes: 9f93ac8d408 ("net-next: stmmac: Add dwmac-sun8i")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 1a6bfe6c958f..54f93ee53ef7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -750,6 +750,11 @@ static int sun8i_dwmac_power_internal_phy(struct stmmac_priv *priv)
 		return ret;
 	}
 
+	/* Make sure the EPHY is properly reseted, as U-Boot may leave
+	 * it at deasserted state, and thus it may fail to reset EMAC.
+	 */
+	reset_control_assert(gmac->rst_ephy);
+
 	ret = reset_control_deassert(gmac->rst_ephy);
 	if (ret) {
 		dev_err(priv->device, "Cannot deassert ephy\n");
-- 
2.12.2
