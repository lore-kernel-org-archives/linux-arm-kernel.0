From: johnyoun@synopsys.com (John Youn)
Date: Wed, 07 Sep 2016 19:39:43 -0700
Subject: [PATCH v5 3/3] usb: dwc2: Properly account for the force mode delays
In-Reply-To: <cover.1473302184.git.johnyoun@synopsys.com>
References: <cover.1473302184.git.johnyoun@synopsys.com>
Message-ID: <b4aac4b197241b8199c5300656d245692eb45856.1473302184.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a force mode bit is set and the IDDIG debounce filter is enabled,
there is a delay for the forced mode to take effect. This delay is due
to the IDDIG debounce filter and is variable depending on the platform's
PHY clock speed. To account for this delay we can poll for the expected
mode.

On a clear force mode, since we don't know what mode to poll for, delay
for a fixed 100 ms. This is the maximum delay based on the slowest PHY
clock speed.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: John Youn <johnyoun@synopsys.com>
---
 drivers/usb/dwc2/core.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index a3068e0..fa9b26b 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -395,9 +395,9 @@ int dwc2_core_reset(struct dwc2_hsotg *hsotg)
  * Checks are done in this function to determine whether doing a force
  * would be valid or not.
  *
- * If a force is done, it requires a 25ms delay to take effect.
- *
- * Returns true if the mode was forced.
+ * If a force is done, it requires a IDDIG debounce filter delay if
+ * the filter is configured and enabled. We poll the current mode of
+ * the controller to account for this delay.
  */
 static bool dwc2_force_mode(struct dwc2_hsotg *hsotg, bool host)
 {
@@ -432,12 +432,18 @@ static bool dwc2_force_mode(struct dwc2_hsotg *hsotg, bool host)
 	gusbcfg |= set;
 	dwc2_writel(gusbcfg, hsotg->regs + GUSBCFG);
 
-	msleep(25);
+	dwc2_wait_for_mode(hsotg, host);
 	return true;
 }
 
-/*
- * Clears the force mode bits.
+/**
+ * dwc2_clear_force_mode() - Clears the force mode bits.
+ *
+ * After clearing the bits, wait up to 100 ms to account for any
+ * potential IDDIG filter delay. We can't know if we expect this delay
+ * or not because the value of the connector ID status is affected by
+ * the force mode. We only need to call this once during probe if
+ * dr_mode == OTG.
  */
 static void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg)
 {
@@ -448,11 +454,8 @@ static void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg)
 	gusbcfg &= ~GUSBCFG_FORCEDEVMODE;
 	dwc2_writel(gusbcfg, hsotg->regs + GUSBCFG);
 
-	/*
-	 * NOTE: This long sleep is _very_ important, otherwise the core will
-	 * not stay in host mode after a connector ID change!
-	 */
-	msleep(25);
+	if (dwc2_iddig_filter_enabled(hsotg))
+		usleep_range(100000, 110000);
 }
 
 /*
@@ -475,12 +478,6 @@ void dwc2_force_dr_mode(struct dwc2_hsotg *hsotg)
 			 __func__, hsotg->dr_mode);
 		break;
 	}
-
-	/*
-	 * NOTE: This is required for some rockchip soc based
-	 * platforms.
-	 */
-	msleep(50);
 }
 
 /*
-- 
2.9.0
