From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 28 Dec 2016 14:56:57 -0800
Subject: [PATCH v6 11/25] usb: chipidea: vbus event may exist before starting
 gadget
In-Reply-To: <20161228225711.698-1-stephen.boyd@linaro.org>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
Message-ID: <20161228225711.698-12-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Chen <peter.chen@nxp.com>

At some situations, the vbus may already be there before starting
gadget. So we need to check vbus event after switch to gadget in
order to handle missing vbus event. The typical use cases are plugging
vbus cable before driver load or the vbus has already been there
after stopping host but before starting gadget.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Tested-by: Stephen Boyd <stephen.boyd@linaro.org>
Reviewed-by: Stephen Boyd <stephen.boyd@linaro.org>
[sboyd at codeaurora.org: Modify comment text per list discussion]
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/chipidea/core.c |  4 ----
 drivers/usb/chipidea/otg.c  | 14 +++++++++-----
 drivers/usb/chipidea/udc.c  |  2 ++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 8a020ebbbe2f..37f888e31f10 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -979,10 +979,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	if (!ci_otg_is_fsm_mode(ci)) {
-		/* only update vbus status for peripheral */
-		if (ci->role == CI_ROLE_GADGET)
-			ci_handle_vbus_change(ci);
-
 		ret = ci_role_start(ci, ci->role);
 		if (ret) {
 			dev_err(dev, "can't start %s role\n",
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 695f3fe3ae21..c972ed23b8ec 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -134,9 +134,9 @@ void ci_handle_vbus_change(struct ci_hdrc *ci)
 	if (!ci->is_otg)
 		return;
 
-	if (hw_read_otgsc(ci, OTGSC_BSV))
+	if (hw_read_otgsc(ci, OTGSC_BSV) && !ci->vbus_active)
 		usb_gadget_vbus_connect(&ci->gadget);
-	else
+	else if (!hw_read_otgsc(ci, OTGSC_BSV) && ci->vbus_active)
 		usb_gadget_vbus_disconnect(&ci->gadget);
 }
 
@@ -175,10 +175,14 @@ static void ci_handle_id_switch(struct ci_hdrc *ci)
 
 		ci_role_stop(ci);
 
-		if (role == CI_ROLE_GADGET)
+		if (role == CI_ROLE_GADGET &&
+				IS_ERR(ci->platdata->vbus_extcon.edev))
 			/*
-			 * wait vbus lower than OTGSC_BSV before connecting
-			 * to host
+			 * wait vbus lower than OTGSC_BSV before connecting to
+			 * host. If connecting status is from an external
+			 * connector instead of register, we don't need to care
+			 * vbus on the board, since it will not affect external
+			 * connector status.
 			 */
 			hw_wait_vbus_lower_bsv(ci);
 
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 732b281485de..0db56fb7e9e9 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1961,6 +1961,8 @@ static int udc_id_switch_for_device(struct ci_hdrc *ci)
 		/* Clear and enable BSV irq */
 		hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
 					OTGSC_BSVIS | OTGSC_BSVIE);
+	/* vbus change may has already been occurred */
+	ci_handle_vbus_change(ci);
 
 	return 0;
 }
-- 
2.10.0.297.gf6727b0
