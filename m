From: m-sonasath@ti.com (Sonasath, Moiz)
Date: Wed, 19 Sep 2012 10:02:48 -0500
Subject: [PATCH 2/4] usb: dwc3: Fix gadget pullup in SS mode
In-Reply-To: <20120919115306.GG3772@arwen.pp.htv.fi>
References: <1348054229-27362-1-git-send-email-kishon@ti.com>
 <1348054229-27362-3-git-send-email-kishon@ti.com>
 <20120919115306.GG3772@arwen.pp.htv.fi>
Message-ID: <CAEgRx2zOVn0zV39-cuPuj4n4HRgQmywy_NY4KTe0qEgeC+NEkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Wed, Sep 19, 2012 at 6:53 AM, Felipe Balbi <balbi@ti.com> wrote:

> Hi,
>
> On Wed, Sep 19, 2012 at 05:00:27PM +0530, Kishon Vijay Abraham I wrote:
> > From: Moiz Sonasath <m-sonasath@ti.com>
> >
> > For the gadget pullup functionality to work in
> > SS mode it requires a particular sequence of
> > toggling the run-stop bit. Here is the required
> > sequence:
> >
> > - Set DCTL[31]
> > - Clear DCTL[31]
> > - Clear OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]
> > - Clear DCTL[8:5] = 0x00
> > - Set DCTL[8:5] = 0x05
> > - Wait 25 Ms
> > - Set DCTL[31]
> > - Set OMAP5430_CONTROL_CORE__PHY_POWER_USB[14]
> >
> > Tested rigourously the gadget pull-up functionality
> > in bot HS and SS modes.
> >
> > Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> this needs to split into three patches:
>
> add new poweron field, implement it on omap-usb3, use it on
> dwc3/gadget.c
>
> btw, I don't think the changes to run_stop bit are necessary and if they
> are, that'd either be a silicon errata or it would've been mentioned on
> the databook. I don't remember seeing that on the databook so I'm
> assuming that this is caused by a bad use of the PHY.
>
> Why that mdelay(25) ? why 25 ms ? That's quite a long time, actually.
>

Felipe, This is infact a HW bug that the Si-Val team did accept and gave us
this workaround sequence with the precise delay :-)

Supposedly this will be fixed in ES 2.0.


>
> > ---
> >  drivers/usb/dwc3/gadget.c   |   21 +++++++++++++++------
> >  drivers/usb/phy/omap-usb3.c |   16 ++++++++++++++++
> >  include/linux/usb/phy.h     |   10 +++++++++-
> >  3 files changed, 40 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 58fdfad..bcc0102 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -49,6 +49,7 @@
> >
> >  #include <linux/usb/ch9.h>
> >  #include <linux/usb/gadget.h>
> > +#include <linux/usb/otg.h>
> >
> >  #include "core.h"
> >  #include "gadget.h"
> > @@ -1417,19 +1418,27 @@ static int dwc3_gadget_run_stop(struct dwc3
> *dwc, int is_on)
> >       reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> >       if (is_on) {
> >               if (dwc->revision <= DWC3_REVISION_187A) {
> > -                     reg &= ~DWC3_DCTL_TRGTULST_MASK;
> > -                     reg |= DWC3_DCTL_TRGTULST_RX_DET;
> > +                     reg &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
> > +                     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +                     reg |= DWC3_DCTL_ULSTCHNG_RX_DETECT;
> > +                     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +                     mdelay(25);
> > +                     reg |= DWC3_DCTL_RUN_STOP;
> > +                     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +                     usb_phy_poweron(dwc->usb3_phy);
> >               }
> >
> > -             if (dwc->revision >= DWC3_REVISION_194A)
> > +             if (dwc->revision >= DWC3_REVISION_194A) {
> >                       reg &= ~DWC3_DCTL_KEEP_CONNECT;
> > -             reg |= DWC3_DCTL_RUN_STOP;
> > +                     reg |= DWC3_DCTL_RUN_STOP;
> > +                     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +             }
> >       } else {
> >               reg &= ~DWC3_DCTL_RUN_STOP;
> > +             dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +             usb_phy_shutdown(dwc->usb3_phy);
> >       }
> >
> > -     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
>
> I'd prefer to hold all values on the variable and write only one.
>
> --
> balbi
>



-- 
Regards
Moiz Sonasath
Android Kernel Team
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120919/e25a2f3a/attachment-0001.html>
