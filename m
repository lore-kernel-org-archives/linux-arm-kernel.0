From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 24 Apr 2018 10:52:49 +0800
Subject: [PATCH 4/5] usb: mtu3: fix operation failure when test TEST_J/K
In-Reply-To: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
References: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
Message-ID: <4c41c6c4230ac6f19643007540e786bc55a38a89.1524537854.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an error dialog popped up in PC when test TEST_J/K
by EHSETT tool, due to not waiting for the completion of
control transfer. Here fix it by entering test mode after
Status Stage finish.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index d67b540..0d2b1cf 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -7,6 +7,7 @@
  * Author:  Chunfeng.Yun <chunfeng.yun@mediatek.com>
  */
 
+#include <linux/iopoll.h>
 #include <linux/usb/composite.h>
 
 #include "mtu3.h"
@@ -263,6 +264,7 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 {
 	void __iomem *mbase = mtu->mac_base;
 	int handled = 1;
+	u32 value;
 
 	switch (le16_to_cpu(setup->wIndex) >> 8) {
 	case TEST_J:
@@ -292,6 +294,14 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 	if (mtu->test_mode_nr == TEST_PACKET_MODE)
 		ep0_load_test_packet(mtu);
 
+	/* send status before entering test mode. */
+	value = mtu3_readl(mbase, U3D_EP0CSR) & EP0_W1C_BITS;
+	mtu3_writel(mbase, U3D_EP0CSR, value | EP0_SETUPPKTRDY | EP0_DATAEND);
+
+	/* wait for ACK status sent by host */
+	readl_poll_timeout(mbase + U3D_EP0CSR, value,
+			!(value & EP0_DATAEND), 100, 5000);
+
 	mtu3_writel(mbase, U3D_USB2_TEST_MODE, mtu->test_mode_nr);
 
 	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
-- 
1.9.1
