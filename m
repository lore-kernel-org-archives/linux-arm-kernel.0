From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:27 -0700
Subject: [PATCH v5 14/23] usb: chipidea: msm: Use hw_write_id_reg() instead of
 writel
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-15-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSM_USB_BASE macro trick is not very clear, and we're using
it for only one register write so let's just move to using
hw_write_id_reg() and passing the ci pointer instead. That
clearly shows what offset we're using and avoids needing to
include the msm_hsusb_hw.h file when we're going to delete that
file soon.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 719b20caf88e..b282a717bf8c 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -8,14 +8,12 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/usb/msm_hsusb_hw.h>
-#include <linux/usb/ulpi.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/chipidea.h>
 
 #include "ci.h"
 
-#define MSM_USB_BASE	(ci->hw_bank.abs)
+#define HS_PHY_AHB_MODE			0x0098
 
 static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 {
@@ -25,7 +23,7 @@ static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
 	case CI_HDRC_CONTROLLER_RESET_EVENT:
 		dev_dbg(dev, "CI_HDRC_CONTROLLER_RESET_EVENT received\n");
 		/* use AHB transactor, allow posted data writes */
-		writel(0x8, USB_AHBMODE);
+		hw_write_id_reg(ci, HS_PHY_AHB_MODE, 0xffffffff, 0x8);
 		usb_phy_init(ci->usb_phy);
 		break;
 	case CI_HDRC_CONTROLLER_STOPPED_EVENT:
-- 
2.10.0.297.gf6727b0
