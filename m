From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 23 May 2018 16:53:16 +0800
Subject: [next,
 PATCH 2/6] usb: mtu3: fix uncontinuous SeqN issue after disable EP
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
Message-ID: <bd37d1585905360069baf2f3009b715258be56ac.1527065109.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reset EP when disable it to reset data toggle for U2 EP, and
SeqN, flow control status etc for U3 EP, this can avoid
issue of uncontinuous SeqN

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 65ff53a..279f9cd 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -195,6 +195,16 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_DEV_LINK_INTR_ENABLE, SSUSB_DEV_SPEED_CHG_INTR);
 }
 
+/* reset: u2 - data toggle, u3 - SeqN, flow control status etc */
+static void mtu3_ep_reset(struct mtu3_ep *mep)
+{
+	struct mtu3 *mtu = mep->mtu;
+	u32 rst_bit = EP_RST(mep->is_in, mep->epnum);
+
+	mtu3_setbits(mtu->mac_base, U3D_EP_RST, rst_bit);
+	mtu3_clrbits(mtu->mac_base, U3D_EP_RST, rst_bit);
+}
+
 /* set/clear the stall and toggle bits for non-ep0 */
 void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 {
@@ -220,8 +230,7 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 	}
 
 	if (!set) {
-		mtu3_setbits(mbase, U3D_EP_RST, EP_RST(mep->is_in, epnum));
-		mtu3_clrbits(mbase, U3D_EP_RST, EP_RST(mep->is_in, epnum));
+		mtu3_ep_reset(mep);
 		mep->flags &= ~MTU3_EP_STALL;
 	} else {
 		mep->flags |= MTU3_EP_STALL;
@@ -400,6 +409,7 @@ void mtu3_deconfig_ep(struct mtu3 *mtu, struct mtu3_ep *mep)
 		mtu3_setbits(mbase, U3D_QIECR0, QMU_RX_DONE_INT(epnum));
 	}
 
+	mtu3_ep_reset(mep);
 	ep_fifo_free(mep);
 
 	dev_dbg(mtu->dev, "%s: %s\n", __func__, mep->name);
-- 
1.9.1
