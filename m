From: fitzsim@fitzsim.org (Thomas Fitzsimmons)
Date: Tue, 08 Jul 2014 19:44:07 -0400
Subject: [PATCH resend] net: mvneta: Fix big endian issue in
 mvneta_txq_desc_csum()
Message-ID: <m3wqbnpgag.fsf@fitzsim.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes the command value generated for CSUM calculation
when running in big endian mode.  The Ethernet protocol ID for IP was
being unconditionally byte-swapped in the layer 3 protocol check (with
swab16), which caused the mvneta driver to not function correctly in
big endian mode.  This patch byte-swaps the ID conditionally with
htons.

Cc: <stable@vger.kernel.org> # v3.13+
Signed-off-by: Thomas Fitzsimmons <fitzsim@fitzsim.org>
---
The mvneta driver existed prior to v3.13, but it has only supported big
endian from v3.13 onward.  If it's accepted, this patch needs to be
backported for stable only as far back as v3.13.

 drivers/net/ethernet/marvell/mvneta.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 45beca1..667cf65 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1207,7 +1207,7 @@ static u32 mvneta_txq_desc_csum(int l3_offs, int l3_proto,
 	command =  l3_offs    << MVNETA_TX_L3_OFF_SHIFT;
 	command |= ip_hdr_len << MVNETA_TX_IP_HLEN_SHIFT;
 
-	if (l3_proto == swab16(ETH_P_IP))
+	if (l3_proto == htons(ETH_P_IP))
 		command |= MVNETA_TXD_IP_CSUM;
 	else
 		command |= MVNETA_TX_L3_IP6;
-- 
1.7.1
