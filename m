From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu,  7 Jul 2016 15:20:58 -0700
Subject: [PATCH v2 07/22] usb: chipidea: Notify events when switching host mode
In-Reply-To: <20160707222114.1673-1-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
Message-ID: <20160707222114.1673-8-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chipidea/udc.c file sends a CI_HDRC_CONTROLLER_RESET_EVENT to
the wrapper drivers when it calls hw_device_reset(), but that
function is not called from chipidea/host.c. And the udc.c file
sends the CI_HDRC_CONTROLLER_STOPPED_EVENT but the host.c file
doesn't do anything.

The intent of the reset event is to allow the wrapper driver to
do any wrapper specific things after the reset bit has been set
in the usb command register. Therefore, add this event hook in
the host role after we toggle that bit.

Similarly, the intent of the stopped event is to allow the
wrapper driver to do any wrapper specific things after the device
is stopped. So when we stop the host role, send the stopped
event.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/host.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 053bac9d983c..a1d8551ca79d 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -87,6 +87,9 @@ static int ehci_ci_reset(struct usb_hcd *hcd)
 	if (ret)
 		return ret;
 
+	if (ci->platdata->notify_event)
+		ci->platdata->notify_event(ci, CI_HDRC_CONTROLLER_RESET_EVENT);
+
 	ci_platform_configure(ci);
 
 	return ret;
@@ -184,6 +187,9 @@ static void host_stop(struct ci_hdrc *ci)
 	struct usb_hcd *hcd = ci->hcd;
 
 	if (hcd) {
+		if (ci->platdata->notify_event)
+			ci->platdata->notify_event(ci,
+				CI_HDRC_CONTROLLER_STOPPED_EVENT);
 		usb_remove_hcd(hcd);
 		usb_put_hcd(hcd);
 		if (ci->platdata->reg_vbus && !ci_otg_is_fsm_mode(ci) &&
-- 
2.9.0.rc2.8.ga28705d
