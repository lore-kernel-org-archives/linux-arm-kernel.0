From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:30 +0800
Subject: [PATCH 02/14] usb: chipidea: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci.h  |    2 --
 drivers/usb/chipidea/udc.c |    6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index e25d126..e4c1f63 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -126,7 +126,6 @@ struct hw_bank {
  * @suspended: suspended by host
  * @test_mode: the selected test mode
  * @platdata: platform specific information supplied by parent device
- * @vbus_active: is VBUS active
  * @transceiver: pointer to USB PHY, if any
  * @hcd: pointer to usb_hcd for ehci host driver
  */
@@ -160,7 +159,6 @@ struct ci13xxx {
 	u8				test_mode;
 
 	struct ci13xxx_platform_data	*platdata;
-	int				vbus_active;
 	/* FIXME: some day, we'll not use global phy */
 	bool				global_phy;
 	struct usb_phy			*transceiver;
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 2f45bba..78e8bac 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1383,7 +1383,7 @@ static int ci13xxx_vbus_session(struct usb_gadget *_gadget, int is_active)
 		return -EOPNOTSUPP;
 
 	spin_lock_irqsave(&ci->lock, flags);
-	ci->vbus_active = is_active;
+	_gadget->vbus_active = is_active;
 	if (ci->driver)
 		gadget_ready = 1;
 	spin_unlock_irqrestore(&ci->lock, flags);
@@ -1566,7 +1566,7 @@ static int ci13xxx_start(struct usb_gadget *gadget,
 	ci->driver = driver;
 	pm_runtime_get_sync(&ci->gadget.dev);
 	if (ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) {
-		if (ci->vbus_active) {
+		if (gadget->vbus_active) {
 			if (ci->platdata->flags & CI13XXX_REGS_SHARED) {
 				hw_device_reset(ci, USBMODE_CM_DC);
 				hw_enable_vbus_intr(ci);
@@ -1598,7 +1598,7 @@ static int ci13xxx_stop(struct usb_gadget *gadget,
 	spin_lock_irqsave(&ci->lock, flags);
 
 	if (!(ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) ||
-			ci->vbus_active) {
+			gadget->vbus_active) {
 		hw_device_state(ci, 0);
 		if (ci->platdata->notify_event)
 			ci->platdata->notify_event(ci,
-- 
1.7.0.4
