From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 29 Nov 2018 10:34:32 +0800
Subject: [PATCH 1/5] usb: mtu3: remove QMU checksum
Message-ID: <e178546b79c3d602736a0db2cbfd76f7588e4022.1543458319.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The QMU checksum calculation is redundant, mostly used by debug,
so remove it here.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c |  2 --
 drivers/usb/mtu3/mtu3_qmu.c  | 26 --------------------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index ae70b9bfd797..3dce5fd9887d 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -592,8 +592,6 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 	mtu3_clrbits(mbase, U3D_LINK_RESET_INFO, WTCHRP_MSK);
 	/* U2/U3 detected by HW */
 	mtu3_writel(mbase, U3D_DEVICE_CONF, 0);
-	/* enable QMU 16B checksum */
-	mtu3_setbits(mbase, U3D_QCR0, QMU_CS16B_EN);
 	/* vbus detected by HW */
 	mtu3_clrbits(mbase, U3D_MISC_CTRL, VBUS_FRC_EN | VBUS_ON);
 }
diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index ff62ba232177..73ac042c45a8 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -154,27 +154,6 @@ void mtu3_gpd_ring_free(struct mtu3_ep *mep)
 	memset(ring, 0, sizeof(*ring));
 }
 
-/*
- * calculate check sum of a gpd or bd
- * add "noinline" and "mb" to prevent wrong calculation
- */
-static noinline u8 qmu_calc_checksum(u8 *data)
-{
-	u8 chksum = 0;
-	int i;
-
-	data[1] = 0x0;  /* set checksum to 0 */
-
-	mb();	/* ensure the gpd/bd is really up-to-date */
-	for (i = 0; i < QMU_CHECKSUM_LEN; i++)
-		chksum += data[i];
-
-	/* Default: HWO=1, @flag[bit0] */
-	chksum += 1;
-
-	return 0xFF - chksum;
-}
-
 void mtu3_qmu_resume(struct mtu3_ep *mep)
 {
 	struct mtu3 *mtu = mep->mtu;
@@ -260,7 +239,6 @@ static int mtu3_prepare_tx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	if (req->zero)
 		gpd->ext_flag |= GPD_EXT_FLAG_ZLP;
 
-	gpd->chksum = qmu_calc_checksum((u8 *)gpd);
 	gpd->flag |= GPD_FLAGS_HWO;
 
 	mreq->gpd = gpd;
@@ -295,7 +273,6 @@ static int mtu3_prepare_rx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	gpd->next_gpd = cpu_to_le32(lower_32_bits(enq_dma));
 	ext_addr |= GPD_EXT_NGP(upper_32_bits(enq_dma));
 	gpd->rx_ext_addr = cpu_to_le16(ext_addr);
-	gpd->chksum = qmu_calc_checksum((u8 *)gpd);
 	gpd->flag |= GPD_FLAGS_HWO;
 
 	mreq->gpd = gpd;
@@ -323,7 +300,6 @@ int mtu3_qmu_start(struct mtu3_ep *mep)
 		/* set QMU start address */
 		write_txq_start_addr(mbase, epnum, ring->dma);
 		mtu3_setbits(mbase, MU3D_EP_TXCR0(epnum), TX_DMAREQEN);
-		mtu3_setbits(mbase, U3D_QCR0, QMU_TX_CS_EN(epnum));
 		/* send zero length packet according to ZLP flag in GPD */
 		mtu3_setbits(mbase, U3D_QCR1, QMU_TX_ZLP(epnum));
 		mtu3_writel(mbase, U3D_TQERRIESR0,
@@ -338,7 +314,6 @@ int mtu3_qmu_start(struct mtu3_ep *mep)
 	} else {
 		write_rxq_start_addr(mbase, epnum, ring->dma);
 		mtu3_setbits(mbase, MU3D_EP_RXCR0(epnum), RX_DMAREQEN);
-		mtu3_setbits(mbase, U3D_QCR0, QMU_RX_CS_EN(epnum));
 		/* don't expect ZLP */
 		mtu3_clrbits(mbase, U3D_QCR3, QMU_RX_ZLP(epnum));
 		/* move to next GPD when receive ZLP */
@@ -441,7 +416,6 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
 
 	/* by pass the current GDP */
 	gpd_current->flag |= GPD_FLAGS_BPS;
-	gpd_current->chksum = qmu_calc_checksum((u8 *)gpd_current);
 	gpd_current->flag |= GPD_FLAGS_HWO;
 
 	/*enable DMAREQEN, switch back to QMU mode */
-- 
2.19.1
