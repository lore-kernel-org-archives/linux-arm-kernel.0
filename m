From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 18 Jul 2018 18:10:56 +0200
Subject: [PATCH net-next v3 7/8] net: mvneta: Verify hardware checksum only
 when offload checksum feature is set
In-Reply-To: <20180718161057.28704-1-gregory.clement@bootlin.com>
References: <20180718161057.28704-1-gregory.clement@bootlin.com>
Message-ID: <20180718161057.28704-8-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yelena Krivosheev <yelena@marvell.com>

If the checksum offload feature is not set, then there is no point to
check the status of the hardware.

[gregory: extract from a larger patch]
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 6af583ef2af2..079b515c54c1 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1720,7 +1720,8 @@ static void mvneta_rx_error(struct mvneta_port *pp,
 static void mvneta_rx_csum(struct mvneta_port *pp, u32 status,
 			   struct sk_buff *skb)
 {
-	if ((status & MVNETA_RXD_L3_IP4) &&
+	if ((pp->dev->features & NETIF_F_RXCSUM) &&
+	    (status & MVNETA_RXD_L3_IP4) &&
 	    (status & MVNETA_RXD_L4_CSUM_OK)) {
 		skb->csum = 0;
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
-- 
2.18.0
