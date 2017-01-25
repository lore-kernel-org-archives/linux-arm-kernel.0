From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 25 Jan 2017 14:32:43 -0800
Subject: [PATCH v8 1/3] usb: chipidea: Configure phy for appropriate mode
In-Reply-To: <20170125223245.2688-1-stephen.boyd@linaro.org>
References: <20170125223245.2688-1-stephen.boyd@linaro.org>
Message-ID: <20170125223245.2688-2-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the qcom chipidea controller is used with an extcon, we need
to signal device mode or host mode to the phy so it can configure
itself for the correct mode. This should be done after the phy is
powered up, so that the register writes work correctly. Add in
the appropriate phy_set_mode() call here.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 802ca253cf6d..fc3b9e07aa81 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -428,13 +428,21 @@ void ci_platform_configure(struct ci_hdrc *ci)
 	is_device_mode = hw_read(ci, OP_USBMODE, USBMODE_CM) == USBMODE_CM_DC;
 	is_host_mode = hw_read(ci, OP_USBMODE, USBMODE_CM) == USBMODE_CM_HC;
 
-	if (is_device_mode &&
-		(ci->platdata->flags & CI_HDRC_DISABLE_DEVICE_STREAMING))
-		hw_write(ci, OP_USBMODE, USBMODE_CI_SDIS, USBMODE_CI_SDIS);
+	if (is_device_mode) {
+		phy_set_mode(ci->phy, PHY_MODE_USB_DEVICE);
 
-	if (is_host_mode &&
-		(ci->platdata->flags & CI_HDRC_DISABLE_HOST_STREAMING))
-		hw_write(ci, OP_USBMODE, USBMODE_CI_SDIS, USBMODE_CI_SDIS);
+		if (ci->platdata->flags & CI_HDRC_DISABLE_DEVICE_STREAMING)
+			hw_write(ci, OP_USBMODE, USBMODE_CI_SDIS,
+				 USBMODE_CI_SDIS);
+	}
+
+	if (is_host_mode) {
+		phy_set_mode(ci->phy, PHY_MODE_USB_HOST);
+
+		if (ci->platdata->flags & CI_HDRC_DISABLE_HOST_STREAMING)
+			hw_write(ci, OP_USBMODE, USBMODE_CI_SDIS,
+				 USBMODE_CI_SDIS);
+	}
 
 	if (ci->platdata->flags & CI_HDRC_FORCE_FULLSPEED) {
 		if (ci->hw_bank.lpm)
-- 
2.10.0.297.gf6727b0
