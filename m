From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Fri, 30 Mar 2018 04:59:48 -0700
Subject: [PATCH v2 2/7] net: thunderx: add MAC address filter tracking for LMAC
In-Reply-To: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180330115953.17154-3-Vadim.Lomovtsev@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The ThunderX NIC has two Ethernet Interfaces (BGX) each of them could has
up to four Logical MACs configured. Each of BGX has 32 filters to be
configured for filtering ingress packets. The number of filters available
to particular LMAC is from 8 (if we have four LMACs configured per BGX)
up to 32 (in case of only one LMAC is configured per BGX).

At the same time the NIC could present up to 128 VFs to OS as network
interfaces, each of them kernel will configure with set of MAC addresses
for filtering. So to prevent dupes in BGX filter registers from different
network interfaces it is required to cache and track all filter
configuration requests prior to applying them onto BGX filter registers.

This commit is to update LMAC structures with control fields to
allocate/releasing filters tracking list along with implementing
dmac array allocate/release per LMAC.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 44 +++++++++++++++--------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 0dd211605eb1..de90e6aa5a4f 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -37,9 +37,18 @@ enum MCAST_MODE {
 #define MCAST_MODE_MASK   0x3
 #define BGX_MCAST_MODE(x) (x << 1)
 
+struct dmac_map {
+	u64                     vf_map;
+	u64                     dmac;
+};
+
 struct lmac {
 	struct bgx		*bgx;
-	int			dmac;
+	/* actual number of DMACs configured */
+	u8			dmacs_cfg;
+	/* overal number of possible DMACs could be configured per LMAC */
+	u8                      dmacs_count;
+	struct dmac_map         *dmacs; /* DMAC:VFs tracking filter array */
 	u8			mac[ETH_ALEN];
 	u8                      lmac_type;
 	u8                      lane_to_sds;
@@ -236,6 +245,19 @@ void bgx_set_lmac_mac(int node, int bgx_idx, int lmacid, const u8 *mac)
 }
 EXPORT_SYMBOL(bgx_set_lmac_mac);
 
+static void bgx_flush_dmac_cam_filter(struct bgx *bgx, int lmacid)
+{
+	struct lmac *lmac = NULL;
+	u8  idx = 0;
+
+	lmac = &bgx->lmac[lmacid];
+	/* reset CAM filters */
+	for (idx = 0; idx < lmac->dmacs_count; idx++)
+		bgx_reg_write(bgx, 0, BGX_CMR_RX_DMACX_CAM +
+			      ((lmacid * lmac->dmacs_count) + idx) *
+			      sizeof(u64), 0);
+}
+
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable)
 {
 	struct bgx *bgx = get_bgx(node, bgx_idx);
@@ -481,18 +503,6 @@ u64 bgx_get_tx_stats(int node, int bgx_idx, int lmac, int idx)
 }
 EXPORT_SYMBOL(bgx_get_tx_stats);
 
-static void bgx_flush_dmac_addrs(struct bgx *bgx, int lmac)
-{
-	u64 offset;
-
-	while (bgx->lmac[lmac].dmac > 0) {
-		offset = ((bgx->lmac[lmac].dmac - 1) * sizeof(u64)) +
-			(lmac * MAX_DMAC_PER_LMAC * sizeof(u64));
-		bgx_reg_write(bgx, 0, BGX_CMR_RX_DMACX_CAM + offset, 0);
-		bgx->lmac[lmac].dmac--;
-	}
-}
-
 /* Configure BGX LMAC in internal loopback mode */
 void bgx_lmac_internal_loopback(int node, int bgx_idx,
 				int lmac_idx, bool enable)
@@ -925,6 +935,11 @@ static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 		bgx_reg_write(bgx, lmacid, BGX_SMUX_TX_MIN_PKT, 60 + 4);
 	}
 
+	/* actual number of filters available to exact LMAC */
+	lmac->dmacs_count = (RX_DMAC_COUNT / bgx->lmac_count);
+	lmac->dmacs = kcalloc(lmac->dmacs_count, sizeof(*lmac->dmacs),
+			      GFP_KERNEL);
+
 	/* Enable lmac */
 	bgx_reg_modify(bgx, lmacid, BGX_CMRX_CFG, CMR_EN);
 
@@ -1011,7 +1026,8 @@ static void bgx_lmac_disable(struct bgx *bgx, u8 lmacid)
 	cfg &= ~CMR_EN;
 	bgx_reg_write(bgx, lmacid, BGX_CMRX_CFG, cfg);
 
-	bgx_flush_dmac_addrs(bgx, lmacid);
+	bgx_flush_dmac_cam_filter(bgx, lmacid);
+	kfree(lmac->dmacs);
 
 	if ((lmac->lmac_type != BGX_MODE_XFI) &&
 	    (lmac->lmac_type != BGX_MODE_XLAUI) &&
-- 
2.14.3
