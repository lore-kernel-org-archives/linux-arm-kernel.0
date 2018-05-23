From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 23 May 2018 16:53:15 +0800
Subject: [next,
 PATCH 1/6] usb: mtu3: re-enable controller to accept LPM request
 after LPM resume
Message-ID: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the controller receives a LPM request, it will reject the LPM
request, and need software to re-enable it after LPM resume if the
controller doesn't remote wakeup from L1 automatically

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index b1b99a8..65ff53a 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -176,7 +176,7 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	mtu3_writel(mbase, U3D_LV1IESR, value);
 
 	/* Enable U2 common USB interrupts */
-	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR;
+	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR | LPM_RESUME_INTR;
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR_ENABLE, value);
 
 	if (mtu->is_u3_ip) {
@@ -692,6 +692,12 @@ static irqreturn_t mtu3_u2_common_isr(struct mtu3 *mtu)
 	if (u2comm & RESET_INTR)
 		mtu3_gadget_reset(mtu);
 
+	if (u2comm & LPM_RESUME_INTR) {
+		if (!(mtu3_readl(mbase, U3D_POWER_MANAGEMENT) & LPM_HRWE))
+			mtu3_setbits(mbase, U3D_USB20_MISC_CONTROL,
+				     LPM_U3_ACK_EN);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
1.9.1
