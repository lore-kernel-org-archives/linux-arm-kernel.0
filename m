From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 10 May 2018 13:47:09 +0800
Subject: [PATCH v2 4/7] usb: mtu3: fix operation failure when test TEST_J/K
In-Reply-To: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
References: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
Message-ID: <572648c3e38d9d7947ecc397eb964178e140e40d.1525930818.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an error dialog popped up in PC when test TEST_J/K
by EHSETT tool, due to not waiting for the completion of
control transfer. Here fix it by entering test mode after
Status Stage finish.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2:
    1. reset test_mode as default value when controller is reset
    2. use readl_poll_timeout_atomic()
---
 drivers/usb/mtu3/mtu3_gadget.c     |  1 +
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index de0de01..5c60a8c 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -719,4 +719,5 @@ void mtu3_gadget_reset(struct mtu3 *mtu)
 	mtu->u1_enable = 0;
 	mtu->u2_enable = 0;
 	mtu->delayed_status = false;
+	mtu->test_mode = false;
 }
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index d67b540..d3fc51b 100644
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
+	/* wait for ACK status sent by host, ignore timeout error */
+	readl_poll_timeout_atomic(mbase + U3D_EP0CSR, value,
+			!(value & EP0_DATAEND), 100, 5000);
+
 	mtu3_writel(mbase, U3D_USB2_TEST_MODE, mtu->test_mode_nr);
 
 	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
-- 
1.9.1
