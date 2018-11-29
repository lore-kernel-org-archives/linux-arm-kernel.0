From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 29 Nov 2018 10:34:33 +0800
Subject: [PATCH 2/5] usb: mtu3: enable hardware remote wakeup from L1
 automatically
In-Reply-To: <e178546b79c3d602736a0db2cbfd76f7588e4022.1543458319.git.chunfeng.yun@mediatek.com>
References: <e178546b79c3d602736a0db2cbfd76f7588e4022.1543458319.git.chunfeng.yun@mediatek.com>
Message-ID: <2105ae1c2fede0fd1923e2fdb58ade7b3aa678f6.1543458320.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable hardware remote wakeup from L1 automatically based on the FIFO
status, instead of manual way.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 3dce5fd9887d..981e4e8c5c13 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -180,7 +180,7 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_LV1IESR, value);
 
 	/* Enable U2 common USB interrupts */
-	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR | LPM_RESUME_INTR;
+	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR;
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR_ENABLE, value);
 
 	if (mtu->is_u3_ip) {
@@ -594,6 +594,8 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_DEVICE_CONF, 0);
 	/* vbus detected by HW */
 	mtu3_clrbits(mbase, U3D_MISC_CTRL, VBUS_FRC_EN | VBUS_ON);
+	/* enable automatical HWRW from L1 */
+	mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, LPM_HRWE);
 }
 
 static irqreturn_t mtu3_link_isr(struct mtu3 *mtu)
@@ -706,12 +708,6 @@ static irqreturn_t mtu3_u2_common_isr(struct mtu3 *mtu)
 	if (u2comm & RESET_INTR)
 		mtu3_gadget_reset(mtu);
 
-	if (u2comm & LPM_RESUME_INTR) {
-		if (!(mtu3_readl(mbase, U3D_POWER_MANAGEMENT) & LPM_HRWE))
-			mtu3_setbits(mbase, U3D_USB20_MISC_CONTROL,
-				     LPM_U3_ACK_EN);
-	}
-
 	return IRQ_HANDLED;
 }
 
-- 
2.19.1
