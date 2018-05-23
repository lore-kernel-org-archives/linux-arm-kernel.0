From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 23 May 2018 16:53:20 +0800
Subject: [next, PATCH 6/6] usb: mtu3: fix warning of sleep in atomic context in
 notifier callback
In-Reply-To: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
References: <1291b13a362eaa0cccd30cb8dd4f56d33e1d172d.1527065109.git.chunfeng.yun@mediatek.com>
Message-ID: <3a030435197e69eca02f3565517a1cbccc33ac57.1527065109.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The notifier callbacks of extcon are called in atomic context, but the
callbacks will call regulator_enable()/regulator_disable() which may
sleep caused by mutex, so use work queue to call the sleep functions.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h    | 11 ++++++++++-
 drivers/usb/mtu3/mtu3_dr.c | 44 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index a56fee0..87823ac 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -196,7 +196,12 @@ struct mtu3_gpd_ring {
 * @vbus: vbus 5V used by host mode
 * @edev: external connector used to detect vbus and iddig changes
 * @vbus_nb: notifier for vbus detection
-* @vbus_nb: notifier for iddig(idpin) detection
+* @vbus_work : work of vbus detection notifier, used to avoid sleep in
+*		notifier callback which is atomic context
+* @vbus_event : event of vbus detecion notifier
+* @id_nb : notifier for iddig(idpin) detection
+* @id_work : work of iddig detection notifier
+* @id_event : event of iddig detecion notifier
 * @is_u3_drd: whether port0 supports usb3.0 dual-role device or not
 * @manual_drd_enabled: it's true when supports dual-role device by debugfs
 *		to switch host/device modes depending on user input.
@@ -205,7 +210,11 @@ struct otg_switch_mtk {
 	struct regulator *vbus;
 	struct extcon_dev *edev;
 	struct notifier_block vbus_nb;
+	struct work_struct vbus_work;
+	unsigned long vbus_event;
 	struct notifier_block id_nb;
+	struct work_struct id_work;
+	unsigned long id_event;
 	bool is_u3_drd;
 	bool manual_drd_enabled;
 };
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 80083e0..8c3bbf7 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -174,16 +174,40 @@ static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
 	}
 }
 
-static int ssusb_id_notifier(struct notifier_block *nb,
-	unsigned long event, void *ptr)
+static void ssusb_id_work(struct work_struct *work)
 {
 	struct otg_switch_mtk *otg_sx =
-		container_of(nb, struct otg_switch_mtk, id_nb);
+		container_of(work, struct otg_switch_mtk, id_work);
 
-	if (event)
+	if (otg_sx->id_event)
 		ssusb_set_mailbox(otg_sx, MTU3_ID_GROUND);
 	else
 		ssusb_set_mailbox(otg_sx, MTU3_ID_FLOAT);
+}
+
+static void ssusb_vbus_work(struct work_struct *work)
+{
+	struct otg_switch_mtk *otg_sx =
+		container_of(work, struct otg_switch_mtk, vbus_work);
+
+	if (otg_sx->vbus_event)
+		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
+	else
+		ssusb_set_mailbox(otg_sx, MTU3_VBUS_OFF);
+}
+
+/*
+ * @ssusb_id_notifier is called in atomic context, but @ssusb_set_mailbox
+ * may sleep, so use work queue here
+ */
+static int ssusb_id_notifier(struct notifier_block *nb,
+	unsigned long event, void *ptr)
+{
+	struct otg_switch_mtk *otg_sx =
+		container_of(nb, struct otg_switch_mtk, id_nb);
+
+	otg_sx->id_event = event;
+	schedule_work(&otg_sx->id_work);
 
 	return NOTIFY_DONE;
 }
@@ -194,10 +218,8 @@ static int ssusb_vbus_notifier(struct notifier_block *nb,
 	struct otg_switch_mtk *otg_sx =
 		container_of(nb, struct otg_switch_mtk, vbus_nb);
 
-	if (event)
-		ssusb_set_mailbox(otg_sx, MTU3_VBUS_VALID);
-	else
-		ssusb_set_mailbox(otg_sx, MTU3_VBUS_OFF);
+	otg_sx->vbus_event = event;
+	schedule_work(&otg_sx->vbus_work);
 
 	return NOTIFY_DONE;
 }
@@ -398,6 +420,9 @@ int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
+	INIT_WORK(&otg_sx->id_work, ssusb_id_work);
+	INIT_WORK(&otg_sx->vbus_work, ssusb_vbus_work);
+
 	if (otg_sx->manual_drd_enabled)
 		ssusb_debugfs_init(ssusb);
 	else
@@ -412,4 +437,7 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 
 	if (otg_sx->manual_drd_enabled)
 		ssusb_debugfs_exit(ssusb);
+
+	cancel_work_sync(&otg_sx->id_work);
+	cancel_work_sync(&otg_sx->vbus_work);
 }
-- 
1.9.1
