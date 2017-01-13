From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 13 Jan 2017 11:35:36 +0800
Subject: [PATCH v6 23/25] usb: chipidea: Pullup D+ in device mode via phy
 APIs
In-Reply-To: <148426139182.20672.2422337338087784924@sboyd-linaro>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
 <20161228225711.698-24-stephen.boyd@linaro.org>
 <20170103065318.GB14542@b29397-desktop>
 <148418039309.32258.7247753739063801774@sboyd-linaro>
 <20170112095040.GA15726@b29397-desktop>
 <148426139182.20672.2422337338087784924@sboyd-linaro>
Message-ID: <20170113033536.GA20723@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 02:49:51PM -0800, Stephen Boyd wrote:
> Quoting Peter Chen (2017-01-12 01:50:40)
> > On Wed, Jan 11, 2017 at 04:19:53PM -0800, Stephen Boyd wrote:
> > > Quoting Peter Chen (2017-01-02 22:53:19)
> > > > On Wed, Dec 28, 2016 at 02:57:09PM -0800, Stephen Boyd wrote:
> > > > > If the phy supports it, call phy_set_mode() to pull up D+ when
> > > > > required by setting the mode to PHY_MODE_USB_DEVICE. If we want
> > > > > to remove the pullup, set the mode to PHY_MODE_USB_HOST.
> > > > > 
> > > [..]
> > > > > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> > > > > index 0d532a724d48..6d61fa0689b0 100644
> > > > > --- a/drivers/usb/chipidea/udc.c
> > > > > +++ b/drivers/usb/chipidea/udc.c
> > > > > @@ -1609,10 +1610,15 @@ static int ci_udc_pullup(struct usb_gadget *_gadget, int is_on)
> > > > >               return 0;
> > > > >  
> > > > >       pm_runtime_get_sync(&ci->gadget.dev);
> > > > > -     if (is_on)
> > > > > +     if (is_on) {
> > > > > +             if (ci->phy)
> > > > > +                     phy_set_mode(ci->phy, PHY_MODE_USB_DEVICE);
> > > > >               hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
> > > > > -     else
> > > > > +     } else {
> > > > >               hw_write(ci, OP_USBCMD, USBCMD_RS, 0);
> > > > > +             if (ci->phy)
> > > > > +                     phy_set_mode(ci->phy, PHY_MODE_USB_HOST);
> > > > > +     }
> > > > >       pm_runtime_put_sync(&ci->gadget.dev);
> > > > >  
> > > > >       return 0;
> > > > 
> > > > Would you describe the use case for it? Why not adding it at
> > > > role switch routine?
> > > > 
> > > 
> > > This is about pulling up D+. The phy I have requires that we manually
> > > pull up D+ by writing a ULPI register before we set the run/stop bit.
> > 
> > Afaik, only controller can pull up dp when it is at device mode by
> > setting USBCMD_RS. At host mode, clear USBCMD_RS will only stopping
> > sending SoF from controller side.
> > 
> > I am puzzled why you can pull up D+ by writing an ULPI register, perhaps,
> > your phy needs DP to change before switching the mode? Would you
> > double confirm that?
> 
> With the boards I have, vbus is not routed to the phy. Instead, there's
> a vbus comparator on the PMIC where the vbus line from the usb
> receptacle is sent. The vbus extcon driver probes the comparator on the
> PMIC to see if vbus is present or not and then notifies extcon users
> when vbus changes.
> 
> The ULPI register we write in the phy is a vendor specific register
> (called MISC_A) that has two bits. If you look at
> qcom_usb_hs_phy_set_mode() in this series you'll see that we set
> VBUSVLDEXTSEL and VBUSVLDEXT. VBUSVLDEXTSEL controls a mux in the phy
> that chooses between an internal comparator, in the case where vbus goes
> to the phy, or an external signal input to the phy, VBUSVLDEXT, to
> consider as the "session valid" signal. It looks like the session valid
> signal drives the D+ pullup resistor in the phy. These bits in MISC_A
> don't matter when the phy is in host mode.
> 
> So when the board doesn't route vbus to the phy, we have to toggle the
> VBUSVLDEXT bit to signal to the phy that the vbus is there or not. I
> also see that we're not supposed to toggle the VBUSVLDEXTSEL bit when in
> "normal" operating mode. So perhaps we should do everything in the
> qcom_usb_hs_phy_set_mode() routine during the role switch as you
> suggest, except toggle the VBUSVLDEXT bit. Toggling the VBUSVLDEXT bit
> can be done via some new phy op when the extcon triggers?

Why not call phy_set_mode(phy, DEVICE) directly at ci_handle_vbus_change when
you get extcon vbus event?

-- 

Best Regards,
Peter Chen
