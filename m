From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 10:50:56 -0800
Subject: [PATCH v7 4/5] usb: chipidea: Signal vbus state to phy
In-Reply-To: <20170120185057.16206-1-stephen.boyd@linaro.org>
References: <20170120185057.16206-1-stephen.boyd@linaro.org>
Message-ID: <20170120185057.16206-5-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some USB PHYs need to be told about vbus changing state
explicitly. For example the qcom USB HS PHY needs to toggle a bit
when vbus goes from low to high (VBUSVLDEXT) to cause the
"session valid" signal to toggle. This signal will pull up D+
when the phy starts running. Add the appropriate phy_set_vbus()
call here to signal vbus state changes to the phy.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

New patch

 drivers/usb/chipidea/otg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 10236fe71522..6ea702beed48 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -134,10 +134,13 @@ void ci_handle_vbus_change(struct ci_hdrc *ci)
 	if (!ci->is_otg)
 		return;
 
-	if (hw_read_otgsc(ci, OTGSC_BSV) && !ci->vbus_active)
+	if (hw_read_otgsc(ci, OTGSC_BSV) && !ci->vbus_active) {
 		usb_gadget_vbus_connect(&ci->gadget);
-	else if (!hw_read_otgsc(ci, OTGSC_BSV) && ci->vbus_active)
+		phy_set_vbus(ci->phy, 1);
+	} else if (!hw_read_otgsc(ci, OTGSC_BSV) && ci->vbus_active) {
+		phy_set_vbus(ci->phy, 0);
 		usb_gadget_vbus_disconnect(&ci->gadget);
+	}
 }
 
 /**
-- 
2.10.0.297.gf6727b0
