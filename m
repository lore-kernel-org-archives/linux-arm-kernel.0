From: b-liu@ti.com (Bin Liu)
Date: Sat, 14 May 2016 23:22:23 -0500
Subject: [linux-sunxi] Re: [PATCH 2/2] musb: sunxi: Set state to
 A_WAIT_VRISE when enabling VBus
In-Reply-To: <8765c9b5-1e40-2967-ac2c-da751b7d9019@redhat.com>
References: <1463077869-13224-1-git-send-email-hdegoede@redhat.com>
 <1463077869-13224-2-git-send-email-hdegoede@redhat.com>
 <20160513183428.GA1665@uda0271908>
 <8765c9b5-1e40-2967-ac2c-da751b7d9019@redhat.com>
Message-ID: <20160515042223.GA20689@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, May 14, 2016 at 11:07:51AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 13-05-16 20:35, Bin Liu wrote:
> >Hi,
> >
> >On Thu, May 12, 2016 at 08:31:09PM +0200, Hans de Goede wrote:
> >>When the board is powering attached usb devices via the otg port
> >>sometimes / on some devices it takes slightly too long for the VBus
> >>detection code in phy-sun4i-usb.c to signal that VBus is high after
> >>enabling VBus and the musb hardware signals a MUSB_INTR_VBUSERROR
> >>interrupt.
> >>
> >>This commit sets the otg state to A_WAIT_VRISE upon enabling Vbus
> >>making musb_stage0_irq() ignore the first VBUSERR_RETRY_COUNT
> >>VBUSERROR interrupts, fixing connection issues in these cases.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >> drivers/usb/musb/sunxi.c | 8 +++++---
> >> 1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >>diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> >>index 2c33d9b..2ee48fb 100644
> >>--- a/drivers/usb/musb/sunxi.c
> >>+++ b/drivers/usb/musb/sunxi.c
> >>@@ -112,7 +112,7 @@ static void sunxi_musb_work(struct work_struct *work)
> >> 		if (test_bit(SUNXI_MUSB_FL_HOSTMODE, &glue->flags)) {
> >> 			set_bit(SUNXI_MUSB_FL_VBUS_ON, &glue->flags);
> >> 			musb->xceiv->otg->default_a = 1;
> >>-			musb->xceiv->otg->state = OTG_STATE_A_IDLE;
> >>+			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> >> 			MUSB_HST_MODE(musb);
> >> 			devctl |= MUSB_DEVCTL_SESSION;
> >> 		} else {
> >>@@ -145,9 +145,10 @@ static void sunxi_musb_set_vbus(struct musb *musb, int is_on)
> >> {
> >> 	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
> >>
> >>-	if (is_on)
> >>+	if (is_on) {
> >> 		set_bit(SUNXI_MUSB_FL_VBUS_ON, &glue->flags);
> >>-	else
> >>+		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> >
> >Why this has to be set in both sunxi_musb_work() and here? Only setting
> >it in the work is not efficient?
> 
> Different code paths, sunxi_musb_work sets it when the id pin changes
> (gets pulled low), this function gets called by musb_core in response
> to a session-request interrupt.

Ok, I see what I missed. An interrupt could happen right after
_set_vbus() but before _musb_work().

Regards,
-Bin.

> 
> Regards,
> 
> Hans
> 
> 
> >
> >Regards,
> >-Bin.
> >
> >>+	} else
> >> 		clear_bit(SUNXI_MUSB_FL_VBUS_ON, &glue->flags);
> >>
> >> 	schedule_work(&glue->work);
> >>@@ -325,6 +326,7 @@ static int sunxi_set_mode(struct musb *musb, u8 mode)
> >> 		set_bit(SUNXI_MUSB_FL_PHY_ON, &glue->flags);
> >> 		/* Stop musb work from turning vbus off again */
> >> 		set_bit(SUNXI_MUSB_FL_VBUS_ON, &glue->flags);
> >>+		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> >> 	}
> >>
> >> 	return 0;
> >>--
> >>2.7.4
> >>
