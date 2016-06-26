From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sun, 26 Jun 2016 00:28:24 -0700
Subject: [PATCH 07/21] usb: chipidea: Notify of reset when switching into host
 mode
In-Reply-To: <20160626072838.28082-1-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
Message-ID: <20160626072838.28082-8-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chipidea/udc.c file sends a CI_HDRC_CONTROLLER_RESET_EVENT to
the wrapper drivers when it calls hw_device_reset(), but that
function is not called from chipidea/host.c. The intent of this
event is to allow the wrapper driver to do any wrapper specific
things after the reset bit has been set in the usb command
register. Therefore, add this event hook in the host role after
we toggle that bit.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 523c155daea8..3344d3256a60 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -87,6 +87,9 @@ static int ehci_ci_reset(struct usb_hcd *hcd)
 	if (ret)
 		return ret;
 
+	if (ci->platdata->notify_event)
+		ci->platdata->notify_event(ci, CI_HDRC_CONTROLLER_RESET_EVENT);
+
 	return ci_platform_configure(ci);
 }
 
-- 
2.9.0.rc2.8.ga28705d
