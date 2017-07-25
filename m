From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 25 Jul 2017 16:10:22 +0800
Subject: [PATCH 1/3] usb: mtu3: handle delayed status of the control transfer
Message-ID: <1500970224-23791-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the delayed status handling. This is used by mass storage etc to
gain some extra time to setup its internal status before it can proceed
further requests, and once the gadget is ready, it will enqueue an
empty packet which is used for synchronization.
The issue may happen on some FGPA platform with very low cpu frequency.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h            |    2 ++
 drivers/usb/mtu3/mtu3_gadget.c     |    2 ++
 drivers/usb/mtu3/mtu3_gadget_ep0.c |   23 ++++++++++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 7b6dc23..b26fffc 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -288,6 +288,7 @@ static inline struct ssusb_mtk *dev_to_ssusb(struct device *dev)
  *		MTU3_U3_IP_SLOT_DEFAULT for U3 IP
  * @may_wakeup: means device's remote wakeup is enabled
  * @is_self_powered: is reported in device status and the config descriptor
+ * @delayed_status: true when function drivers ask for delayed status
  * @ep0_req: dummy request used while handling standard USB requests
  *		for GET_STATUS and SET_SEL
  * @setup_buf: ep0 response buffer for GET_STATUS and SET_SEL requests
@@ -327,6 +328,7 @@ struct mtu3 {
 	unsigned u1_enable:1;
 	unsigned u2_enable:1;
 	unsigned is_u3_ip:1;
+	unsigned delayed_status:1;
 
 	u8 address;
 	u8 test_mode_nr;
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 9dd2441..a4ad67c 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -663,6 +663,7 @@ int mtu3_gadget_setup(struct mtu3 *mtu)
 	mtu->g.sg_supported = 0;
 	mtu->g.name = MTU3_DRIVER_NAME;
 	mtu->is_active = 0;
+	mtu->delayed_status = false;
 
 	mtu3_gadget_init_eps(mtu);
 
@@ -727,4 +728,5 @@ void mtu3_gadget_reset(struct mtu3 *mtu)
 	mtu->address = 0;
 	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
 	mtu->may_wakeup = 0;
+	mtu->delayed_status = false;
 }
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 2d7427b..958d74d 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -16,6 +16,8 @@
  *
  */
 
+#include <linux/usb/composite.h>
+
 #include "mtu3.h"
 
 /* ep0 is always mtu3->in_eps[0] */
@@ -150,6 +152,7 @@ static void ep0_stall_set(struct mtu3_ep *mep0, bool set, u32 pktrdy)
 		csr = (csr & ~EP0_SENDSTALL) | EP0_SENTSTALL;
 	mtu3_writel(mtu->mac_base, U3D_EP0CSR, csr);
 
+	mtu->delayed_status = false;
 	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
 
 	dev_dbg(mtu->dev, "ep0: %s STALL, ep0_state: %s\n",
@@ -656,6 +659,9 @@ static int ep0_handle_setup(struct mtu3 *mtu)
 finish:
 	if (mtu->test_mode) {
 		;	/* nothing to do */
+	} else if (handled == USB_GADGET_DELAYED_STATUS) {
+		/* handle the delay STATUS phase till receive ep_queue on ep0 */
+		mtu->delayed_status = true;
 	} else if (le16_to_cpu(setup.wLength) == 0) { /* no data stage */
 
 		mtu3_writel(mbase, U3D_EP0CSR,
@@ -775,9 +781,6 @@ static int ep0_queue(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	dev_dbg(mtu->dev, "%s %s (ep0_state: %s), len#%d\n", __func__,
 		mep->name, decode_ep0_state(mtu), mreq->request.length);
 
-	if (!list_empty(&mep->req_list))
-		return -EBUSY;
-
 	switch (mtu->ep0_state) {
 	case MU3D_EP0_STATE_SETUP:
 	case MU3D_EP0_STATE_RX:	/* control-OUT data */
@@ -789,6 +792,20 @@ static int ep0_queue(struct mtu3_ep *mep, struct mtu3_request *mreq)
 		return -EINVAL;
 	}
 
+	if (mtu->delayed_status) {
+		u32 csr;
+
+		mtu->delayed_status = false;
+		csr = mtu3_readl(mtu->mac_base, U3D_EP0CSR) & EP0_W1C_BITS;
+		csr |= EP0_SETUPPKTRDY | EP0_DATAEND;
+		mtu3_writel(mtu->mac_base, U3D_EP0CSR, csr);
+		/* needn't giveback the request for handling delay STATUS */
+		return 0;
+	}
+
+	if (!list_empty(&mep->req_list))
+		return -EBUSY;
+
 	list_add_tail(&mreq->list, &mep->req_list);
 
 	/* sequence #1, IN ... start writing the data */
-- 
1.7.9.5
