From: satha.rao@caviumnetworks.com (Satha Koteswara Rao)
Date: Wed, 21 Dec 2016 14:16:47 +0530
Subject: [RFC PATCH 3/7] Enable pause frame support
In-Reply-To: <1482310011-1862-1-git-send-email-satha.rao@caviumnetworks.com>
References: <1482310011-1862-1-git-send-email-satha.rao@caviumnetworks.com>
Message-ID: <1482310011-1862-4-git-send-email-satha.rao@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 25 +++++++++++++++++++++++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 050e21f..92d7e04 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -121,6 +121,31 @@ static int bgx_poll_reg(struct bgx *bgx, u8 lmac, u64 reg, u64 mask, bool zero)
 	return 1;
 }
 
+void enable_pause_frames(int node, int bgx_idx, int lmac)
+{
+	u64 reg_value = 0;
+	struct bgx *bgx = bgx_vnic[(node * MAX_BGX_PER_NODE) + bgx_idx];
+
+	reg_value =  bgx_reg_read(bgx, lmac, BGX_SMUX_TX_CTL);
+	/* Enable BGX()_SMU()_TX_CTL */
+	if (!(reg_value & L2P_BP_CONV))
+		bgx_reg_write(bgx, lmac, BGX_SMUX_TX_CTL,
+			      (reg_value | (L2P_BP_CONV)));
+
+	reg_value =  bgx_reg_read(bgx, lmac, BGX_SMUX_HG2_CTL);
+	/* Clear if BGX()_SMU()_HG2_CONTROL[HG2TX_EN] is set */
+	if (reg_value & SMUX_HG2_CTL_HG2TX_EN)
+		bgx_reg_write(bgx, lmac, BGX_SMUX_HG2_CTL,
+			      (reg_value & (~SMUX_HG2_CTL_HG2TX_EN)));
+
+	reg_value =  bgx_reg_read(bgx, lmac, BGX_SMUX_CBFC_CTL);
+	/* Clear if BGX()_SMU()_CBFC_CTL[TX_EN] is set */
+	if (reg_value & CBFC_CTL_TX_EN)
+		bgx_reg_write(bgx, lmac, BGX_SMUX_CBFC_CTL,
+			      (reg_value & (~CBFC_CTL_TX_EN)));
+}
+EXPORT_SYMBOL(enable_pause_frames);
+
 /* Return number of BGX present in HW */
 unsigned bgx_get_map(int node)
 {
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
index 01cc7c8..5b57bd1 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -131,6 +131,11 @@
 #define BGX_SMUX_TX_CTL			0x20178
 #define  SMU_TX_CTL_DIC_EN			BIT_ULL(0)
 #define  SMU_TX_CTL_UNI_EN			BIT_ULL(1)
+#define  L2P_BP_CONV				BIT_ULL(7)
+#define  BGX_SMUX_CBFC_CTL		0x20218
+#define  CBFC_CTL_TX_EN				BIT_ULL(1)
+#define  BGX_SMUX_HG2_CTL		0x20210
+#define SMUX_HG2_CTL_HG2TX_EN			BIT_ULL(18)
 #define  SMU_TX_CTL_LNK_STATUS			(3ull << 4)
 #define BGX_SMUX_TX_THRESH		0x20180
 #define BGX_SMUX_CTL			0x20200
@@ -212,6 +217,8 @@ void bgx_lmac_internal_loopback(int node, int bgx_idx,
 
 u64 bgx_get_rx_stats(int node, int bgx_idx, int lmac, int idx);
 u64 bgx_get_tx_stats(int node, int bgx_idx, int lmac, int idx);
+void enable_pause_frames(int node, int bgx_idx, int lmac);
+
 #define BGX_RX_STATS_COUNT 11
 #define BGX_TX_STATS_COUNT 18
 
-- 
1.8.3.1
