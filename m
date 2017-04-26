From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 26 Apr 2017 16:38:53 -0700
Subject: [PATCH net-next 7/9] drivers: net: xgene: Workaround for HW errata
 10GE_4
In-Reply-To: <1493249935-30759-1-git-send-email-isubramanian@apm.com>
References: <1493249935-30759-1-git-send-email-isubramanian@apm.com>
Message-ID: <1493249935-30759-8-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quan Nguyen <qnguyen@apm.com>

This patch adds workaround for HW errata 10GE_4:
"XGENET_ICM_ECM_DROP_COUNT_REG_0 reg not clear on read".

Signed-off-by: Quan Nguyen <qnguyen@apm.com>
Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c    | 2 ++
 drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c | 5 +++++
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
index f79eb78..60b1a07 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
@@ -623,6 +623,8 @@ static void xgene_gmac_get_drop_cnt(struct xgene_enet_pdata *pdata,
 	xgene_enet_rd_mcx_csr(pdata, ICM_ECM_DROP_COUNT_REG0_ADDR, &count);
 	*rx = ICM_DROP_COUNT(count);
 	*tx = ECM_DROP_COUNT(count);
+	/* Errata: 10GE_4 - Fix ICM_ECM_DROP_COUNT not clear-on-read */
+	xgene_enet_rd_mcx_csr(pdata, ECM_CONFIG0_REG_0_ADDR, &count);
 }
 
 static void xgene_enet_config_ring_if_assoc(struct xgene_enet_pdata *pdata)
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c b/drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c
index b253069..ca1f723 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c
@@ -197,6 +197,11 @@ static void xgene_sgmac_get_drop_cnt(struct xgene_enet_pdata *pdata,
 	count = xgene_enet_rd_mcx_csr(pdata, addr);
 	*rx = ICM_DROP_COUNT(count);
 	*tx = ECM_DROP_COUNT(count);
+	/* Errata: 10GE_4 - ICM_ECM_DROP_COUNT not clear-on-read */
+	addr = (pdata->enet_id != XGENE_ENET1) ?
+		XG_MCX_ECM_CONFIG0_REG_0_ADDR :
+		ECM_CONFIG0_REG_0_ADDR + pdata->port_id * OFFSET_4;
+	xgene_enet_rd_mcx_csr(pdata, addr);
 }
 
 static void xgene_enet_config_ring_if_assoc(struct xgene_enet_pdata *p)
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c b/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c
index a317596..3e4cd79 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c
@@ -239,6 +239,8 @@ static void xgene_xgmac_get_drop_cnt(struct xgene_enet_pdata *pdata,
 	xgene_enet_rd_axg_csr(pdata, XGENET_ICM_ECM_DROP_COUNT_REG0, &count);
 	*rx = ICM_DROP_COUNT(count);
 	*tx = ECM_DROP_COUNT(count);
+	/* Errata: 10GE_4 - ICM_ECM_DROP_COUNT not clear-on-read */
+	xgene_enet_rd_axg_csr(pdata, XGENET_ECM_CONFIG0_REG_0, &count);
 }
 
 static void xgene_enet_config_ring_if_assoc(struct xgene_enet_pdata *pdata)
-- 
1.9.1
