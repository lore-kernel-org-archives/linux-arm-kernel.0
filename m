From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 25 Jul 2017 16:10:24 +0800
Subject: [PATCH 3/3] usb: mtu3: fix ip sleep auto-exit issue when enable DRD
 mode
In-Reply-To: <1500970224-23791-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1500970224-23791-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1500970224-23791-3-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ip sleep will auto exit if vbus comparison circuit of u2 phy is
disabled when system tries to enter suspend mode, so get vbus-valid
status from mac but not from u2 phy when enable DRD mode to fix
the issue.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_hw_regs.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index 2123672..06b2966 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -462,10 +462,12 @@
 #define SSUSB_U3_PORT_DIS		BIT(0)
 
 /* U3D_SSUSB_U2_CTRL_0P */
+#define SSUSB_U2_PORT_VBUSVALID	BIT(9)
 #define SSUSB_U2_PORT_OTG_SEL		BIT(7)
-#define SSUSB_U2_PORT_HOST_SEL		BIT(2)
+#define SSUSB_U2_PORT_HOST		BIT(2)
 #define SSUSB_U2_PORT_PDN		BIT(1)
 #define SSUSB_U2_PORT_DIS		BIT(0)
+#define SSUSB_U2_PORT_HOST_SEL	(SSUSB_U2_PORT_VBUSVALID | SSUSB_U2_PORT_HOST)
 
 /* U3D_SSUSB_DEV_RST_CTRL */
 #define SSUSB_DEV_SW_RST		BIT(0)
-- 
1.7.9.5
