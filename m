From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 19 Dec 2017 17:59:45 +0100
Subject: [PATCH net 1/3] net: mvneta: clear interface link status on port
 disable
In-Reply-To: <20171219165947.28516-1-gregory.clement@free-electrons.com>
References: <20171219165947.28516-1-gregory.clement@free-electrons.com>
Message-ID: <20171219165947.28516-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yelena Krivosheev <yelena@marvell.com>

When port connect to PHY in polling mode (with poll interval 1 sec),
port and phy link status must be synchronize in order don't loss link
change event.

[gregory.clement at free-electrons.com: add fixes tag]
Cc: <stable@vger.kernel.org>
Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP network unit")
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
Tested-by: Dmitri Epshtein <dima@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index bc93b69cfd1e..16b2bfb2cf51 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1214,6 +1214,10 @@ static void mvneta_port_disable(struct mvneta_port *pp)
 	val &= ~MVNETA_GMAC0_PORT_ENABLE;
 	mvreg_write(pp, MVNETA_GMAC_CTRL_0, val);
 
+	pp->link = 0;
+	pp->duplex = -1;
+	pp->speed = 0;
+
 	udelay(200);
 }
 
-- 
2.15.1
