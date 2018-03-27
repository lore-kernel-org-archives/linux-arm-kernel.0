From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Tue, 27 Mar 2018 08:07:30 -0700
Subject: [PATCH 1/7] net: thunderx: move filter register related macro into
 proper place
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180327150736.10718-2-Vadim.Lomovtsev@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

The ThunderX NIC has set of registers which allows to configure
filter policy for ingress packets. There are three possible regimes
of filtering multicasts, broadcasts and unicasts: accept all, reject all
and accept filter allowed only.

Current implementation has enum with all of them and two generic macro
for enabling filtering et all (CAM_ACCEPT) and enabling/disabling
broadcast packets, which also should be corrected in order to represent
register bits properly. All these values are private for driver and
there is no need to ?publish? them via header file.

This commit is to move filtering register manipulation values from
header file into source with explicit assignment of exact register
values to them to be used while register configuring.

Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 13 +++++++++++++
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h | 11 -----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 91d34ea40e2c..0dd211605eb1 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -24,6 +24,19 @@
 #define DRV_NAME	"thunder_bgx"
 #define DRV_VERSION	"1.0"
 
+/* RX_DMAC_CTL configuration */
+enum MCAST_MODE {
+		MCAST_MODE_REJECT = 0x0,
+		MCAST_MODE_ACCEPT = 0x1,
+		MCAST_MODE_CAM_FILTER = 0x2,
+		RSVD = 0x3
+};
+
+#define BCAST_ACCEPT      BIT(0)
+#define CAM_ACCEPT        BIT(3)
+#define MCAST_MODE_MASK   0x3
+#define BGX_MCAST_MODE(x) (x << 1)
+
 struct lmac {
 	struct bgx		*bgx;
 	int			dmac;
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
index 5a7567d31138..52439da62c97 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.h
@@ -205,17 +205,6 @@
 #define LMAC_INTR_LINK_UP	BIT(0)
 #define LMAC_INTR_LINK_DOWN	BIT(1)
 
-/*  RX_DMAC_CTL configuration*/
-enum MCAST_MODE {
-		MCAST_MODE_REJECT,
-		MCAST_MODE_ACCEPT,
-		MCAST_MODE_CAM_FILTER,
-		RSVD
-};
-
-#define BCAST_ACCEPT	1
-#define CAM_ACCEPT	1
-
 void octeon_mdiobus_force_mod_depencency(void);
 void bgx_lmac_rx_tx_enable(int node, int bgx_idx, int lmacid, bool enable);
 void bgx_add_dmac_addr(u64 dmac, int node, int bgx_idx, int lmac);
-- 
2.14.3
