From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Feb 2013 22:42:49 +0200
Subject: [PATCH v10 6/8] usb: chipidea: imx: add internal vbus regulator
 control
In-Reply-To: <CAB7JpEHq6rDS4=twUf7gito5zxinYiHZban77psKEQ962z0LYw@mail.gmail.com>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
 <1361946799-29471-7-git-send-email-peter.chen@freescale.com>
 <CAB7JpEHq6rDS4=twUf7gito5zxinYiHZban77psKEQ962z0LYw@mail.gmail.com>
Message-ID: <20130227204249.GA2748@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 09:08:11PM +0200, Alexander Shishkin wrote:
> On Feb 27, 2013 8:34 AM, "Peter Chen" <peter.chen@freescale.com> wrote:
> >
> > - For host, the vbus should always be on.
> > - For otg, the vbus is off defaultly, the vbus needs to be
> > turned on/off when usb role switches.
> >
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/chipidea/ci.h          |    2 +
> >  drivers/usb/chipidea/ci13xxx_imx.c |   76
> ++++++++++++++++++++++++++++--------
> >  2 files changed, 61 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
> > index 0bd17a5..5663092 100644
> > --- a/drivers/usb/chipidea/ci.h
> > +++ b/drivers/usb/chipidea/ci.h
> > @@ -133,6 +133,7 @@ struct hw_bank {
> >   * @id_event: indicates there is a id event, and handled at ci_otg_work
> >   * @b_sess_valid_event: indicates there is a vbus event, and handled
> >   * at ci_otg_work
> > + * @reg_vbus: used to control internal vbus regulator
> >   */
> >  struct ci13xxx {
> >         struct device                   *dev;
> > @@ -172,6 +173,7 @@ struct ci13xxx {
> >         struct usb_otg                  otg;
> >         bool                            id_event;
> >         bool                            b_sess_valid_event;
> > +       struct regulator                *reg_vbus;
> >  };
> 
> I suggest that this regulator be taken care of by either the platform code
> or phy layer, it doesn't look like it really belongs in chipidea core. The
> easiest way I guess would be to do something similar to the notify callback
> in msm platform code.

I guess it would look better at the phy layer, but looks like we need
another ->set_vbus() method to switch VBUS on/off.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/971b7741/attachment.sig>
