From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 26 Jul 2013 17:18:17 +0800
Subject: [PATCH v13 01/14] usb: chipidea: add vbus regulator control
In-Reply-To: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
References: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1374830310-21765-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For boards which have board level vbus control (eg, through gpio), we
need to vbus operation according to below rules:
- For host, we need open vbus before start hcd, and close it
after remove hcd.
- For otg, the vbus needs to be on/off when usb role switches.
When the host roles begins, it opens vbus; when the host role
finishes, it closes vbus.

We put vbus operation to host as host is the only vbus user,
When we are at host mode, the vbus is on, when we are not at
host mode, vbus should be off.

Tested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/host.c  |   23 ++++++++++++++++++++++-
 include/linux/usb/chipidea.h |    1 +
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 40d0fda..e94e52b 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -24,6 +24,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/usb/chipidea.h>
+#include <linux/regulator/consumer.h>
 
 #include "../host/ehci.h"
 
@@ -64,9 +65,19 @@ static int host_start(struct ci_hdrc *ci)
 	ehci->caps = ci->hw_bank.cap;
 	ehci->has_hostpc = ci->hw_bank.lpm;
 
+	if (ci->platdata->reg_vbus) {
+		ret = regulator_enable(ci->platdata->reg_vbus);
+		if (ret) {
+			dev_err(ci->dev,
+				"Failed to enable vbus regulator, ret=%d\n",
+				ret);
+			goto put_hcd;
+		}
+	}
+
 	ret = usb_add_hcd(hcd, 0, 0);
 	if (ret)
-		usb_put_hcd(hcd);
+		goto disable_reg;
 	else
 		ci->hcd = hcd;
 
@@ -74,6 +85,14 @@ static int host_start(struct ci_hdrc *ci)
 		hw_write(ci, OP_USBMODE, USBMODE_CI_SDIS, USBMODE_CI_SDIS);
 
 	return ret;
+
+disable_reg:
+	regulator_disable(ci->platdata->reg_vbus);
+
+put_hcd:
+	usb_put_hcd(hcd);
+
+	return ret;
 }
 
 static void host_stop(struct ci_hdrc *ci)
@@ -82,6 +101,8 @@ static void host_stop(struct ci_hdrc *ci)
 
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
+	if (ci->platdata->reg_vbus)
+		regulator_disable(ci->platdata->reg_vbus);
 }
 
 int ci_hdrc_host_init(struct ci_hdrc *ci)
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 2562994..118bf66 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -24,6 +24,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
 	void	(*notify_event) (struct ci_hdrc *ci, unsigned event);
+	struct regulator *reg_vbus;
 };
 
 /* Default offset of capability registers */
-- 
1.7.0.4
