From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 20 Oct 2016 18:10:18 +0800
Subject: [PATCH v5 11/23] usb: chipidea: Emulate OTGSC interrupt enable
 path
In-Reply-To: <147694652997.28344.1048935134595924905@sboyd-linaro>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-12-stephen.boyd@linaro.org>
 <20161019011535.GC6294@b29397-desktop>
 <147684198705.24897.12451889548508263144@sboyd-linaro>
 <20161019080211.GA1968@b29397-desktop>
 <147694652997.28344.1048935134595924905@sboyd-linaro>
Message-ID: <20161020101017.GA32001@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 11:55:29PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-10-19 01:02:11)
> > On Tue, Oct 18, 2016 at 06:53:07PM -0700, Stephen Boyd wrote:
> > > If you're asking if I've made modifications to extcon-usb-gpio, then the
> > > answer is no. The branch on linaro.org git server from the cover-letter
> > > is the branch I've used to test this with. This patch is specifically to
> > > fix issues with that design on the db410c board that has only one pin
> > > for ID and vbus detection. It's the schematic that we've discussed in
> > > another thread.
> > > 
> > > extcon-usb-gpio sends two extcon events, EXTCON_USB_HOST (for the id
> > > pin) and EXTCON_USB (for the vbus). So afaik it does support vbus
> > > events.
> > > 
> > 
> > Hmm, in fact, your ID event is the same with vbus event, you take
> > external vbus event as ID event for extcon-usb-gpio handling. Yes,
> > it can work due to it sends EXTCON_USB_HOST event first.
> > 
> > Where you change the USB_SW_SEL_PM pin?
> 
> Currently that is done with the mux driver I sent based on the extcon
> event. We don't know if that's before or after the controller handles
> the extcon event though, so the pin should probably be changed from the
> chipidea driver instead to be more explicit. Why do you ask though?

I was just curious how you handle it, now I am clear. From my point,
the suitable way may be: mux driver + user app (echo role through
debugfs). The extcon-usb-gpio is not necessary, since you have already
known role at mux driver.

The current kernel has no framework to handle dual-role switch at kernel
space.

> > At some situations, the vbus may already be there before starting
> > gadget. So we need to check vbus event after switch to gadget in
> > order to handle missing vbus event. The typical use cases are plugging
> > vbus cable before driver load or the vbus has already been there
> > after stopping host but before starting gadget.
> > 
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> 
> Yes this should work. Light testing doesn't show any problems so far.
>  
> > ---
> >  drivers/usb/chipidea/core.c |  4 ----
> >  drivers/usb/chipidea/otg.c  | 10 ++++++----
> >  drivers/usb/chipidea/udc.c  |  2 ++
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index b814d91..a7d2c68 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -992,10 +992,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> >         }
> >  
> >         if (!ci_otg_is_fsm_mode(ci)) {
> > -               /* only update vbus status for peripheral */
> > -               if (ci->role == CI_ROLE_GADGET)
> > -                       ci_handle_vbus_change(ci);
> > -
> >                 ret = ci_role_start(ci, ci->role);
> >                 if (ret) {
> >                         dev_err(dev, "can't start %s role\n",
> > diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
> > index 695f3fe..99c0709 100644
> > --- a/drivers/usb/chipidea/otg.c
> > +++ b/drivers/usb/chipidea/otg.c
> > @@ -134,9 +134,9 @@ void ci_handle_vbus_change(struct ci_hdrc *ci)
> >         if (!ci->is_otg)
> >                 return;
> >  
> > -       if (hw_read_otgsc(ci, OTGSC_BSV))
> > +       if (hw_read_otgsc(ci, OTGSC_BSV) && !ci->vbus_active)
> >                 usb_gadget_vbus_connect(&ci->gadget);
> > -       else
> > +       else if (!hw_read_otgsc(ci, OTGSC_BSV) && ci->vbus_active)
> >                 usb_gadget_vbus_disconnect(&ci->gadget);
> >  }
> >  
> > @@ -175,10 +175,12 @@ static void ci_handle_id_switch(struct ci_hdrc *ci)
> >  
> >                 ci_role_stop(ci);
> >  
> > -               if (role == CI_ROLE_GADGET)
> > +               if (role == CI_ROLE_GADGET &&
> > +                               IS_ERR(ci->platdata->vbus_extcon.edev))
> >                         /*
> >                          * wait vbus lower than OTGSC_BSV before connecting
> > -                        * to host
> > +                        * to host. And if vbus's status is an external
> > +                        * connector, it doesn't need to wait here.
> 
> because OTGSC_BSV will toggle based on the extcon state and not when the
> phy connects to the host? It would be good to explain why it's not
> needed instead of just repeating what the code is doing.
> 

Thanks, will change like below

"
If connecting status is from an external connector instead of register,
we don't need to care vbus on the board, since it will not affect external
connector status.
"

> >                          */
> >                         hw_wait_vbus_lower_bsv(ci);
> >  
> > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> > index 001c2fa..184ffba 100644
> > --- a/drivers/usb/chipidea/udc.c
> > +++ b/drivers/usb/chipidea/udc.c
> > @@ -1963,6 +1963,8 @@ static int udc_id_switch_for_device(struct ci_hdrc *ci)
> >                 /* Clear and enable BSV irq */
> >                 hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
> >                                         OTGSC_BSVIS | OTGSC_BSVIE);
> > +       /* vbus change may has already been occurred */
> 
> "vbus change may have already occurred"?

Yes, will change.

-- 

Best Regards,
Peter Chen
