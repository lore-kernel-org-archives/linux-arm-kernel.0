From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 12 Aug 2013 09:22:48 +0800
Subject: [PATCH v15 02/13] usb: chipidea: host: add vbus regulator control
In-Reply-To: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1376270579-13493-3-git-send-email-peter.chen@freescale.com>
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
 drivers/usb/chipidea/host.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

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
-- 
1.7.1
