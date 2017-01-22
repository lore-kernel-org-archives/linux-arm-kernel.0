From: peter.chen@nxp.com (Peter Chen)
Date: Sun, 22 Jan 2017 01:37:39 +0000
Subject: [PATCH v7 4/5] usb: chipidea: Signal vbus state to phy
In-Reply-To: <20170120185057.16206-5-stephen.boyd@linaro.org>
References: <20170120185057.16206-1-stephen.boyd@linaro.org>
 <20170120185057.16206-5-stephen.boyd@linaro.org>
Message-ID: <VI1PR04MB1455DFE93EF3ACFB911BA4748B730@VI1PR04MB1455.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>
> drivers/usb/chipidea/otg.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c index
>10236fe71522..6ea702beed48 100644
>--- a/drivers/usb/chipidea/otg.c
>+++ b/drivers/usb/chipidea/otg.c
>@@ -134,10 +134,13 @@ void ci_handle_vbus_change(struct ci_hdrc *ci)
> 	if (!ci->is_otg)
> 		return;
>
>-	if (hw_read_otgsc(ci, OTGSC_BSV) && !ci->vbus_active)
>+	if (hw_read_otgsc(ci, OTGSC_BSV) && !ci->vbus_active) {
> 		usb_gadget_vbus_connect(&ci->gadget);
>-	else if (!hw_read_otgsc(ci, OTGSC_BSV) && ci->vbus_active)
>+		phy_set_vbus(ci->phy, 1);
>+	} else if (!hw_read_otgsc(ci, OTGSC_BSV) && ci->vbus_active) {
>+		phy_set_vbus(ci->phy, 0);
> 		usb_gadget_vbus_disconnect(&ci->gadget);
>+	}
> }
>
You can add my ack if you accept the name of phy_notify_vbus.

Peter
