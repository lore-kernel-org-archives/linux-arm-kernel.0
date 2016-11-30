From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 30 Nov 2016 14:57:30 +0900
Subject: [PATCH 02/12] phy: sun4i-usb: Replace the deprecated extcon API
In-Reply-To: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1480485460-2663-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces the deprecated extcon API as following:
- extcon_set_cable_state_() -> extcon_set_state_sync()

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/phy/phy-sun4i-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index eeda5134c777..95cdb08c339f 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -528,7 +528,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	mutex_unlock(&phy0->mutex);
 
 	if (id_notify) {
-		extcon_set_cable_state_(data->extcon, EXTCON_USB_HOST,
+		extcon_set_state_sync(data->extcon, EXTCON_USB_HOST,
 					!id_det);
 		/* When leaving host mode force end the session here */
 		if (force_session_end && id_det == 1) {
@@ -541,7 +541,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 	}
 
 	if (vbus_notify)
-		extcon_set_cable_state_(data->extcon, EXTCON_USB, vbus_det);
+		extcon_set_state_sync(data->extcon, EXTCON_USB, vbus_det);
 
 	if (sun4i_usb_phy0_poll(data))
 		queue_delayed_work(system_wq, &data->detect, POLL_TIME);
-- 
1.9.1
