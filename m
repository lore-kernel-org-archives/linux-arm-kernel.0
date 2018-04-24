From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 24 Apr 2018 10:52:48 +0800
Subject: [PATCH 3/5] usb: mtu3: fix an unrecognized issue when connected with
 PC
In-Reply-To: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
References: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
Message-ID: <87c13b177c67bb614b761c594231a39e3fa25924.1524537854.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When boot on the platform with the USB cable connected to Win7,
the Win7 will pop up an error dialog: "USB Device not recognized",
but finally the Win7 can enumerate it successfully.
The root cause is as the following:
When the xHCI driver set PORT_POWER of the OTG port, and if both
IDPIN and VBUS_VALID are high at the same time, the MTU3 controller
will set SESSION and pull up DP, so the Win7 can detect existence
of USB device, but if the mtu3 driver can't switch to device mode
during the debounce time, the Win7 can not enumerate it.
Here to fix it by removing the 1s delayed EXTCON register to speed up
mode switch.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h    |  4 ----
 drivers/usb/mtu3/mtu3_dr.c | 25 +++----------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 2cd00a2..a56fee0 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -197,9 +197,6 @@ struct mtu3_gpd_ring {
 * @edev: external connector used to detect vbus and iddig changes
 * @vbus_nb: notifier for vbus detection
 * @vbus_nb: notifier for iddig(idpin) detection
-* @extcon_reg_dwork: delay work for extcon notifier register, waiting for
-*		xHCI driver initialization, it's necessary for system bootup
-*		as device.
 * @is_u3_drd: whether port0 supports usb3.0 dual-role device or not
 * @manual_drd_enabled: it's true when supports dual-role device by debugfs
 *		to switch host/device modes depending on user input.
@@ -209,7 +206,6 @@ struct otg_switch_mtk {
 	struct extcon_dev *edev;
 	struct notifier_block vbus_nb;
 	struct notifier_block id_nb;
-	struct delayed_work extcon_reg_dwork;
 	bool is_u3_drd;
 	bool manual_drd_enabled;
 };
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index db7562d..80083e0 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -238,15 +238,6 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
 	return 0;
 }
 
-static void extcon_register_dwork(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct otg_switch_mtk *otg_sx =
-	    container_of(dwork, struct otg_switch_mtk, extcon_reg_dwork);
-
-	ssusb_extcon_register(otg_sx);
-}
-
 /*
  * We provide an interface via debugfs to switch between host and device modes
  * depending on user input.
@@ -407,18 +398,10 @@ int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
-	if (otg_sx->manual_drd_enabled) {
+	if (otg_sx->manual_drd_enabled)
 		ssusb_debugfs_init(ssusb);
-	} else {
-		INIT_DELAYED_WORK(&otg_sx->extcon_reg_dwork,
-				  extcon_register_dwork);
-
-		/*
-		 * It is enough to delay 1s for waiting for
-		 * host initialization
-		 */
-		schedule_delayed_work(&otg_sx->extcon_reg_dwork, HZ);
-	}
+	else
+		ssusb_extcon_register(otg_sx);
 
 	return 0;
 }
@@ -429,6 +412,4 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 
 	if (otg_sx->manual_drd_enabled)
 		ssusb_debugfs_exit(ssusb);
-	else
-		cancel_delayed_work(&otg_sx->extcon_reg_dwork);
 }
-- 
1.9.1
