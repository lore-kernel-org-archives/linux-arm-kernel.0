From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 12 Jan 2017 17:50:40 +0800
Subject: [PATCH v6 23/25] usb: chipidea: Pullup D+ in device mode via phy
 APIs
In-Reply-To: <148418039309.32258.7247753739063801774@sboyd-linaro>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
 <20161228225711.698-24-stephen.boyd@linaro.org>
 <20170103065318.GB14542@b29397-desktop>
 <148418039309.32258.7247753739063801774@sboyd-linaro>
Message-ID: <20170112095040.GA15726@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 04:19:53PM -0800, Stephen Boyd wrote:
> Quoting Peter Chen (2017-01-02 22:53:19)
> > On Wed, Dec 28, 2016 at 02:57:09PM -0800, Stephen Boyd wrote:
> > > If the phy supports it, call phy_set_mode() to pull up D+ when
> > > required by setting the mode to PHY_MODE_USB_DEVICE. If we want
> > > to remove the pullup, set the mode to PHY_MODE_USB_HOST.
> > > 
> [..]
> > > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> > > index 0d532a724d48..6d61fa0689b0 100644
> > > --- a/drivers/usb/chipidea/udc.c
> > > +++ b/drivers/usb/chipidea/udc.c
> > > @@ -1609,10 +1610,15 @@ static int ci_udc_pullup(struct usb_gadget *_gadget, int is_on)
> > >               return 0;
> > >  
> > >       pm_runtime_get_sync(&ci->gadget.dev);
> > > -     if (is_on)
> > > +     if (is_on) {
> > > +             if (ci->phy)
> > > +                     phy_set_mode(ci->phy, PHY_MODE_USB_DEVICE);
> > >               hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
> > > -     else
> > > +     } else {
> > >               hw_write(ci, OP_USBCMD, USBCMD_RS, 0);
> > > +             if (ci->phy)
> > > +                     phy_set_mode(ci->phy, PHY_MODE_USB_HOST);
> > > +     }
> > >       pm_runtime_put_sync(&ci->gadget.dev);
> > >  
> > >       return 0;
> > 
> > Would you describe the use case for it? Why not adding it at
> > role switch routine?
> > 
> 
> This is about pulling up D+. The phy I have requires that we manually
> pull up D+ by writing a ULPI register before we set the run/stop bit.

Afaik, only controller can pull up dp when it is at device mode by
setting USBCMD_RS. At host mode, clear USBCMD_RS will only stopping
sending SoF from controller side.

I am puzzled why you can pull up D+ by writing an ULPI register, perhaps,
your phy needs DP to change before switching the mode? Would you
double confirm that?

> I
> thought it would be appropriate to do so in ci_udc_pullup(), where we're
> supposed to put that pullup code, unless I'm mistaken?
> 
> It's not exactly about putting the phy into device or host mode, so
> phy_set_mode() may not actually be the best API to use. Perhaps we need
> some sort of phy_pullup_usb() API here?

-- 

Best Regards,
Peter Chen
