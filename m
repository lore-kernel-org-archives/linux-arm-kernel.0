From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 10:04:20 +0200
Subject: [PATCH 1/3] phy: mvebu-cp110-comphy: fix mux error check
Message-ID: <20170918080422.28972-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mux value is retrieved from the mvebu_comphy_get_mux() function
which returns an int. In mvebu_comphy_power_on() this int is stored to a
u32 and a check is made to ensure it's not negative. Which is wrong.
This fixes it.

Fixes: d0438bd6aa09 ("phy: add the mvebu cp110 comphy driver")
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index 73ebad6634a7..514a1a47e1fd 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -468,8 +468,8 @@ static int mvebu_comphy_power_on(struct phy *phy)
 {
 	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
 	struct mvebu_comphy_priv *priv = lane->priv;
-	int ret;
-	u32 mux, val;
+	int ret, mux;
+	u32 val;
 
 	mux = mvebu_comphy_get_mux(lane->id, lane->port, lane->mode);
 	if (mux < 0)
-- 
2.13.5
