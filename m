From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 23 May 2018 16:53:18 +0800
Subject: [next,
 PATCH 4/6] usb: mtu3: avoid sleep in atomic context when enter test
 mode
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
Message-ID: <5c3f53fa72d8a4293051a3fc4f8ea9bc080d1c49.1527065109.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use readl_poll_timeout_atomic() instead of readl_poll_timeout()
in atomic context

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 0d2b1cf..25216e7 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -299,7 +299,7 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 	mtu3_writel(mbase, U3D_EP0CSR, value | EP0_SETUPPKTRDY | EP0_DATAEND);
 
 	/* wait for ACK status sent by host */
-	readl_poll_timeout(mbase + U3D_EP0CSR, value,
+	readl_poll_timeout_atomic(mbase + U3D_EP0CSR, value,
 			!(value & EP0_DATAEND), 100, 5000);
 
 	mtu3_writel(mbase, U3D_USB2_TEST_MODE, mtu->test_mode_nr);
-- 
1.9.1
