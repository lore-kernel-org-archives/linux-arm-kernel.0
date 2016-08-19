From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 19 Aug 2016 20:10:13 +0800
Subject: [PATCH] usb: chipidea: support generic phy in PM code path
Message-ID: <20160819121013.760-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support generic phy in PM code path: call phy_power_off/phy_power_on
in ci_controller_suspend/ci_controller_resume.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/usb/chipidea/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index ae12595..ef9fb0b 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1116,6 +1116,7 @@ static void ci_controller_suspend(struct ci_hdrc *ci)
 		usleep_range(ci->platdata->phy_clkgate_delay_us,
 			     ci->platdata->phy_clkgate_delay_us + 50);
 	usb_phy_set_suspend(ci->usb_phy, 1);
+	phy_power_off(ci->phy);
 	ci->in_lpm = true;
 	enable_irq(ci->irq);
 }
@@ -1132,9 +1133,10 @@ static int ci_controller_resume(struct device *dev)
 	}
 
 	ci_hdrc_enter_lpm(ci, false);
-	if (ci->usb_phy) {
+	if (ci->usb_phy || ci->phy) {
 		usb_phy_set_suspend(ci->usb_phy, 0);
 		usb_phy_set_wakeup(ci->usb_phy, false);
+		phy_power_on(ci->phy);
 		hw_wait_phy_stable();
 	}
 
-- 
2.9.3
