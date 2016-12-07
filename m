From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 7 Dec 2016 15:23:13 +0800
Subject: [PATCH] usb: mtu3: fix U3 port link issue
Message-ID: <1481095393-23198-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the issue is introduced when @is_u3_ip is used in mtu3_device_enabe()
before initialized in mtu3_mem_alloc(), so get global IP information
at first before used by following functins.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 520e55a..af3e531 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -481,21 +481,14 @@ static int mtu3_mem_alloc(struct mtu3 *mtu)
 	void __iomem *mbase = mtu->mac_base;
 	struct mtu3_ep *ep_array;
 	int in_ep_num, out_ep_num;
-	u32 cap_epinfo, cap_dev;
+	u32 cap_epinfo;
 	int ret;
 	int i;
 
-	mtu->hw_version = mtu3_readl(mtu->ippc_base, U3D_SSUSB_HW_ID);
-
-	cap_dev = mtu3_readl(mtu->ippc_base, U3D_SSUSB_IP_DEV_CAP);
-	mtu->is_u3_ip = !!SSUSB_IP_DEV_U3_PORT_NUM(cap_dev);
-
 	cap_epinfo = mtu3_readl(mbase, U3D_CAP_EPINFO);
 	in_ep_num = CAP_TX_EP_NUM(cap_epinfo);
 	out_ep_num = CAP_RX_EP_NUM(cap_epinfo);
 
-	dev_info(mtu->dev, "IP version 0x%x(%s IP)\n", mtu->hw_version,
-		mtu->is_u3_ip ? "U3" : "U2");
 	dev_info(mtu->dev, "fifosz/epnum: Tx=%#x/%d, Rx=%#x/%d\n",
 		 mtu3_readl(mbase, U3D_CAP_EPNTXFFSZ), in_ep_num,
 		 mtu3_readl(mbase, U3D_CAP_EPNRXFFSZ), out_ep_num);
@@ -730,8 +723,17 @@ irqreturn_t mtu3_irq(int irq, void *data)
 
 static int mtu3_hw_init(struct mtu3 *mtu)
 {
+	u32 cap_dev;
 	int ret;
 
+	mtu->hw_version = mtu3_readl(mtu->ippc_base, U3D_SSUSB_HW_ID);
+
+	cap_dev = mtu3_readl(mtu->ippc_base, U3D_SSUSB_IP_DEV_CAP);
+	mtu->is_u3_ip = !!SSUSB_IP_DEV_U3_PORT_NUM(cap_dev);
+
+	dev_info(mtu->dev, "IP version 0x%x(%s IP)\n", mtu->hw_version,
+		mtu->is_u3_ip ? "U3" : "U2");
+
 	mtu3_device_reset(mtu);
 
 	ret = mtu3_device_enable(mtu);
-- 
1.7.9.5
