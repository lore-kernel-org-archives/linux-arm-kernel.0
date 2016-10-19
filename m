From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 19 Oct 2016 16:02:11 +0800
Subject: [PATCH v5 11/23] usb: chipidea: Emulate OTGSC interrupt enable
 path
In-Reply-To: <147684198705.24897.12451889548508263144@sboyd-linaro>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-12-stephen.boyd@linaro.org>
 <20161019011535.GC6294@b29397-desktop>
 <147684198705.24897.12451889548508263144@sboyd-linaro>
Message-ID: <20161019080211.GA1968@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 06:53:07PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-10-18 18:15:35)
> > On Mon, Oct 17, 2016 at 06:56:24PM -0700, Stephen Boyd wrote:
> > > In the case of an extcon-usb-gpio device being used with the
> > > chipidea driver we'll sometimes miss the BSVIS event in the OTGSC
> > > register. Consider the case where we don't have a cable attached
> > > and the id pin is indicating "host" mode. When we plug in the usb
> > > cable for "device" mode a gpio goes high and indicates that we
> > > should do the role switch and that vbus is high. When we're in
> > > "host" mode the OTGSC register doesn't have BSVIE set.
> > 
> > I have some questions for your description:
> > 
> > - Do you have any pending or related patches what this patch set
> >   is based on? Afaik, the extcon-usb-gpio has no vbus event supported.
> 
> If you're asking if I've made modifications to extcon-usb-gpio, then the
> answer is no. The branch on linaro.org git server from the cover-letter
> is the branch I've used to test this with. This patch is specifically to
> fix issues with that design on the db410c board that has only one pin
> for ID and vbus detection. It's the schematic that we've discussed in
> another thread.
> 
> extcon-usb-gpio sends two extcon events, EXTCON_USB_HOST (for the id
> pin) and EXTCON_USB (for the vbus). So afaik it does support vbus
> events.
> 

Hmm, in fact, your ID event is the same with vbus event, you take
external vbus event as ID event for extcon-usb-gpio handling. Yes,
it can work due to it sends EXTCON_USB_HOST event first.

Where you change the USB_SW_SEL_PM pin?

> > - When the ID from 0->1, the chipidea driver will do role switch, and
> >   set BSVIE, why it does not occur for your case?
> 
> Right, that happens with this line in the sequence I describe below:
> 
>   hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE, OTGSC_BSVIS | OTGSC_BSVIE);
> 
> but that happens much later than when the extcon event happens so we
> miss the interrupt. Technically, the driver isn't expecting the BSVIS
> interrupt to happen until BSVIE is set, but the extcon can come whenever
> it wants regardless of how the registers are configured in the
> controller.  So we have to do some sort of 'caching' here to remember
> that the vbus event happened and replay it when BSVIE is set. At least I
> imagine this is how the hardware would work? Or if vbus goes high before
> we enable the interrupt would it just be missed? It seems like polling
> the BSV bit and then enabling BSVIE is sort of racy there.
> 
> Plus, we poll the BSV bit when we role switch, but in my case id bit
> toggles and vbus goes high at exactly the same time because that is all
> happening from a single cable being connected, so it's not possible for
> BSV to go low and see it after the id pin from 0 to 1.

Now, I understand your case, but your changes are a little complicated.
Would you try if below patch can fix your issue?

>From 8b8baf31dcaca53612d0fd91068c84fe09d66f6c Mon Sep 17 00:00:00 2001
From: Peter Chen <peter.chen@nxp.com>
Date: Wed, 19 Oct 2016 15:32:58 +0800
Subject: [PATCH 1/1] usb: chipidea: vbus event may exist before starting
 gadget

At some situations, the vbus may already be there before starting
gadget. So we need to check vbus event after switch to gadget in
order to handle missing vbus event. The typical use cases are plugging
vbus cable before driver load or the vbus has already been there
after stopping host but before starting gadget.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/chipidea/core.c |  4 ----
 drivers/usb/chipidea/otg.c  | 10 ++++++----
 drivers/usb/chipidea/udc.c  |  2 ++
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index b814d91..a7d2c68 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -992,10 +992,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
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
index 695f3fe..99c0709 100644
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
 
@@ -175,10 +175,12 @@ static void ci_handle_id_switch(struct ci_hdrc *ci)
 
 		ci_role_stop(ci);
 
-		if (role == CI_ROLE_GADGET)
+		if (role == CI_ROLE_GADGET &&
+				IS_ERR(ci->platdata->vbus_extcon.edev))
 			/*
 			 * wait vbus lower than OTGSC_BSV before connecting
-			 * to host
+			 * to host. And if vbus's status is an external
+			 * connector, it doesn't need to wait here.
 			 */
 			hw_wait_vbus_lower_bsv(ci);
 
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 001c2fa..184ffba 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1963,6 +1963,8 @@ static int udc_id_switch_for_device(struct ci_hdrc *ci)
 		/* Clear and enable BSV irq */
 		hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
 					OTGSC_BSVIS | OTGSC_BSVIE);
+	/* vbus change may has already been occurred */
+	ci_handle_vbus_change(ci);
 
 	return 0;
 }
-- 
2.7.4


-- 

Best Regards,
Peter Chen
