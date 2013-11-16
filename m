From: Peter.Chen@freescale.com (Peter Chen)
Date: Sat, 16 Nov 2013 13:35:04 +0000
Subject: [PATCH 2/2] usb: chipidea: usbmisc: Add support for i.MX51 CPU
In-Reply-To: <CAHCPf3tOxKESwbooR0sz0w=A8n6uEDOmaawDxick0+AMBRAQfA@mail.gmail.com>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <1384067901-9377-2-git-send-email-shc_work@mail.ru>
 <CAHCPf3tOxKESwbooR0sz0w=A8n6uEDOmaawDxick0+AMBRAQfA@mail.gmail.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A64980411A0C0@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> >
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  drivers/usb/chipidea/usbmisc_imx.c | 40 +++++++++++++++++++++---------
> --------
> >  1 file changed, 22 insertions(+), 18 deletions(-)
> >
> >
> > -static int usbmisc_imx53_init(struct imx_usbmisc_data *data)
> > +static int usbmisc_imx5_init(struct imx_usbmisc_data *data)
> 
> Can we keep usbmisc_imx53_init named this?
> 
> There is more to do here on i.MX5 for cases where the bootloader did
> not already try to set up USB (or did it badly) such as the
> transceiver reference clock rate and also setting the USB sysclk clock
> source (internal DPLL or from external transceiver in the external
> ULPI case) and so on, which is related and needs doing on both, but is
> different on i.MX51 than i.MX53. This is information sort of best
> passed in the PHY node that goes along with this, but it's set within
> the usbmisc block of the chips so the usbmisc driver will have a
> responsibility to go see if it's an external PHY that is feeding it's
> clock back into the USB block in this way.
> 
> I am not sure we (Peter etc.) discussed how best to do this, the code
> to pull the correct information out always seems kind of misplaced no
> matter where it goes, but the responsibility for tweaking those
> registers is most certainly this driver.
> 
> Essentially the layout of usbmisc->base + 0x10 register (USB_CTRL_1)
> is different when doing the above, and dependent on a board-specific
> option for the input clock to the transceiver. We could reduce a
> little churn, later, when usbmisc_imx could be given related usbphy
> information and actually do the right thing. I have a patch kinda
> sitting in the wings to do this.. and two *real* pieces of consumer
> hardware that need it, and some other kicking, to make USB work in the
> never-touched-before-Linux case.
> 
> > -static const struct usbmisc_ops imx53_usbmisc_ops = {
> > -       .init = usbmisc_imx53_init,
> > +static const struct usbmisc_ops imx5_usbmisc_ops = {
> > +       .init = usbmisc_imx5_init,
> >  };
> 
> And keep imx53_usbmisc_ops named this?
> 
> >  static const struct usbmisc_ops imx6q_usbmisc_ops = {
> > @@ -204,8 +204,12 @@ static const struct of_device_id
> usbmisc_imx_dt_ids[] = {
> >                 .data = &imx27_usbmisc_ops,
> >         },
> >         {
> > +               .compatible = "fsl,imx51-usbmisc",
> > +               .data = &imx5_usbmisc_ops,
> 
> And then just use &imx53_usbmisc_ops?
> 
> This gives us some breathing room later to actually do the right thing
> without additionally performing renames all over the place to make
> imx5 -> imx53 (again)/imx51 (new).
 
Hi Alexander,

You may take matt's suggestion, it can reduce the code change now and in future.
We can only add device_id for imx51 in this patch, split imx53 and imx51's ops
when their differences are added in future.

Peter
