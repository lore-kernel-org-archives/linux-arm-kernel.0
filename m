From: balbi@ti.com (Felipe Balbi)
Date: Thu, 28 Feb 2013 09:29:46 +0200
Subject: [PATCH v10 6/8] usb: chipidea: imx: add internal vbus regulator
 control
In-Reply-To: <20130228060608.GD19387@nchen-desktop>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
 <1361946799-29471-7-git-send-email-peter.chen@freescale.com>
 <CAB7JpEHq6rDS4=twUf7gito5zxinYiHZban77psKEQ962z0LYw@mail.gmail.com>
 <20130228060608.GD19387@nchen-desktop>
Message-ID: <20130228072946.GC6154@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 02:06:09PM +0800, Peter Chen wrote:
> On Wed, Feb 27, 2013 at 09:08:11PM +0200, Alexander Shishkin wrote:
> >    On Feb 27, 2013 8:34 AM, "Peter Chen" <peter.chen@freescale.com> wrote:
> >    >
> >    > - For host, the vbus should always be on.
> >    > - For otg, the vbus is off defaultly, the vbus needs to be
> >    > turned on/off when usb role switches.
> >    >
> >    > + * @reg_vbus: used to control internal vbus regulator
> >    >   */
> >    >  struct ci13xxx {
> >    >         struct device                   *dev;
> >    > @@ -172,6 +173,7 @@ struct ci13xxx {
> >    >         struct usb_otg                  otg;
> >    >         bool                            id_event;
> >    >         bool                            b_sess_valid_event;
> >    > +       struct regulator                *reg_vbus;
> >    >  };
> > 
> >    I suggest that this regulator be taken care of by either the platform code
> >    or phy layer, it doesn't look like it really belongs in chipidea core. The
> >    easiest way I guess would be to do something similar to the notify
> >    callback in msm platform code.
> 
> VBUS operation is typical operation during the USB code, eg, we need
> to open vbus at Host mode, we need close/open vbus during host<->gadget
> switch.
> 
> I suggest vbus regulator is specified at platform code, and assign it
> to ci core's pdata, like sasche's patch pdata->dr_mode and pdata->phy_mode.

you don't need platform_data for it. From ci core probe try to get the
regulator, if it doesn't exist, ignore the error and continue anyways.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130228/f528b649/attachment-0001.sig>
