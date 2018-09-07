From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 7 Sep 2018 14:00:39 +0800
Subject: [RESEND PATCH] usb: mtu3: disable vbus rise/fall interrupts of ltssm
Message-ID: <6e7bed46598dfb65f43c2490802a51a8b50cd257.1536299914.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vbus rise & fall interrupts are used to enable and disable
U3 function of device automatically, this cause some issues when
class driver is initialized as deactivated, and will skip over
software-controlled connect by pullup(), but UDC wants to keep
disconnect until usb_gadget_activate() is called which calls
pullup() if needed. So we disable vbus rise & fall interrupts
and just use pullup() to enable & disable U3 function, and reset
mtu3 state when disconnect instead when vbus fall.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_core.c   |  4 ++--
 drivers/usb/mtu3/mtu3_gadget.c | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index d045d84..ae70b9b 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -185,8 +185,8 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 
 	if (mtu->is_u3_ip) {
 		/* Enable U3 LTSSM interrupts */
-		value = HOT_RST_INTR | WARM_RST_INTR | VBUS_RISE_INTR |
-		    VBUS_FALL_INTR | ENTER_U3_INTR | EXIT_U3_INTR;
+		value = HOT_RST_INTR | WARM_RST_INTR |
+			ENTER_U3_INTR | EXIT_U3_INTR;
 		mtu3_writel(mbase, U3D_LTSSM_INTR_ENABLE, value);
 	}
 
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 5c60a8c..bbcd333 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -585,6 +585,17 @@ static int mtu3_gadget_stop(struct usb_gadget *g)
 	.udc_stop = mtu3_gadget_stop,
 };
 
+static void mtu3_state_reset(struct mtu3 *mtu)
+{
+	mtu->address = 0;
+	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
+	mtu->may_wakeup = 0;
+	mtu->u1_enable = 0;
+	mtu->u2_enable = 0;
+	mtu->delayed_status = false;
+	mtu->test_mode = false;
+}
+
 static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 		u32 epnum, u32 is_in)
 {
@@ -702,6 +713,7 @@ void mtu3_gadget_disconnect(struct mtu3 *mtu)
 		spin_lock(&mtu->lock);
 	}
 
+	mtu3_state_reset(mtu);
 	usb_gadget_set_state(&mtu->g, USB_STATE_NOTATTACHED);
 }
 
@@ -712,12 +724,6 @@ void mtu3_gadget_reset(struct mtu3 *mtu)
 	/* report disconnect, if we didn't flush EP state */
 	if (mtu->g.speed != USB_SPEED_UNKNOWN)
 		mtu3_gadget_disconnect(mtu);
-
-	mtu->address = 0;
-	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
-	mtu->may_wakeup = 0;
-	mtu->u1_enable = 0;
-	mtu->u2_enable = 0;
-	mtu->delayed_status = false;
-	mtu->test_mode = false;
+	else
+		mtu3_state_reset(mtu);
 }
-- 
1.9.1
