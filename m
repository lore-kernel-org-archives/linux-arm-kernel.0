From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 29 Nov 2018 10:34:35 +0800
Subject: [PATCH 4/5] usb: mtu3: enable SETUPENDISR interrupt
In-Reply-To: <e178546b79c3d602736a0db2cbfd76f7588e4022.1543458319.git.chunfeng.yun@mediatek.com>
References: <e178546b79c3d602736a0db2cbfd76f7588e4022.1543458319.git.chunfeng.yun@mediatek.com>
Message-ID: <93297cec234cfa1c9bc733f9ba5ea933f9ce51f1.1543458321.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the controller receives a new SETUP during SETUP data stage,
and will generate SETUPENDISR interrupt, the driver should abort
the current SETUP command and process the new one.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c       | 2 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 6 +++++-
 drivers/usb/mtu3/mtu3_hw_regs.h    | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 1ffc0bc31c1d..b6b20949d63a 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -484,7 +484,7 @@ void mtu3_ep0_setup(struct mtu3 *mtu)
 	mtu3_writel(mtu->mac_base, U3D_EP0CSR, csr);
 
 	/* Enable EP0 interrupt */
-	mtu3_writel(mtu->mac_base, U3D_EPIESR, EP0ISR);
+	mtu3_writel(mtu->mac_base, U3D_EPIESR, EP0ISR | SETUPENDISR);
 }
 
 static int mtu3_mem_alloc(struct mtu3 *mtu)
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 3c464d8ae023..7cb7ac980446 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -692,9 +692,13 @@ irqreturn_t mtu3_ep0_isr(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_EPISR, int_status); /* W1C */
 
 	/* only handle ep0's */
-	if (!(int_status & EP0ISR))
+	if (!(int_status & (EP0ISR | SETUPENDISR)))
 		return IRQ_NONE;
 
+	/* abort current SETUP, and process new one */
+	if (int_status & SETUPENDISR)
+		mtu->ep0_state = MU3D_EP0_STATE_SETUP;
+
 	csr = mtu3_readl(mbase, U3D_EP0CSR);
 
 	dev_dbg(mtu->dev, "%s csr=0x%x\n", __func__, csr);
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index a45bb253939f..d11fcd64c19d 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -104,6 +104,7 @@
 
 /* U3D_EPISR */
 #define EPRISR(x)		(BIT(16) << (x))
+#define SETUPENDISR		BIT(16)
 #define EPTISR(x)		(BIT(0) << (x))
 #define EP0ISR			BIT(0)
 
-- 
2.19.1
