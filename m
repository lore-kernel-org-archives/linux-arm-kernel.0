From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 18:56:19 -0700
Subject: [PATCH v5 06/23] usb: chipidea: Add platform flag for wrapper phy
 management
In-Reply-To: <20161018015636.11701-1-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
Message-ID: <20161018015636.11701-7-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ULPI phy on qcom platforms needs to be initialized and
powered on after a USB reset and before we toggle the run/stop
bit. Otherwise, the phy locks up and doesn't work properly.
Therefore, add a flag to skip any phy power management in the
core layer, leaving it up to the glue driver to manage.

Acked-by: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/core.c  | 6 ++++++
 include/linux/usb/chipidea.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 01390e02ee53..532085a096d9 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -361,6 +361,9 @@ static int _ci_usb_phy_init(struct ci_hdrc *ci)
  */
 static void ci_usb_phy_exit(struct ci_hdrc *ci)
 {
+	if (ci->platdata->flags & CI_HDRC_OVERRIDE_PHY_CONTROL)
+		return;
+
 	if (ci->phy) {
 		phy_power_off(ci->phy);
 		phy_exit(ci->phy);
@@ -379,6 +382,9 @@ static int ci_usb_phy_init(struct ci_hdrc *ci)
 {
 	int ret;
 
+	if (ci->platdata->flags & CI_HDRC_OVERRIDE_PHY_CONTROL)
+		return 0;
+
 	switch (ci->platdata->phy_mode) {
 	case USBPHY_INTERFACE_MODE_UTMI:
 	case USBPHY_INTERFACE_MODE_UTMIW:
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index f9be467d6695..d07b162073f7 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -57,6 +57,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_OVERRIDE_AHB_BURST	BIT(9)
 #define CI_HDRC_OVERRIDE_TX_BURST	BIT(10)
 #define CI_HDRC_OVERRIDE_RX_BURST	BIT(11)
+#define CI_HDRC_OVERRIDE_PHY_CONTROL	BIT(12) /* Glue layer manages phy */
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
-- 
2.10.0.297.gf6727b0
