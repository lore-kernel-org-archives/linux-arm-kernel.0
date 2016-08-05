From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 05 Aug 2016 14:46:00 -0700
Subject: [PATCH v2 06/22] usb: chipidea: Add platform flag for wrapper phy
 management
In-Reply-To: <20160708092535.GD20485@shlinux2>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-7-stephen.boyd@linaro.org>
 <20160708092535.GD20485@shlinux2>
Message-ID: <147043356053.26915.10086819023294264100@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-07-08 02:25:35)
> On Thu, Jul 07, 2016 at 03:20:57PM -0700, Stephen Boyd wrote:
> > The ULPI phy on qcom platforms needs to be initialized and
> > powered on after a USB reset and before we toggle the run/stop
> > bit. Otherwise, the phy locks up and doesn't work properly.
> > Therefore, add a flag to skip any phy power management in the
> > core layer, leaving it up to the glue driver to manage.
> > 
> > Cc: Peter Chen <peter.chen@nxp.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> > ---
> >  drivers/usb/chipidea/core.c  | 6 ++++++
> >  include/linux/usb/chipidea.h | 1 +
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index 01390e02ee53..532085a096d9 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -361,6 +361,9 @@ static int _ci_usb_phy_init(struct ci_hdrc *ci)
> >   */
> >  static void ci_usb_phy_exit(struct ci_hdrc *ci)
> >  {
> > +     if (ci->platdata->flags & CI_HDRC_OVERRIDE_PHY_CONTROL)
> > +             return;
> > +
> >       if (ci->phy) {
> >               phy_power_off(ci->phy);
> >               phy_exit(ci->phy);
> > @@ -379,6 +382,9 @@ static int ci_usb_phy_init(struct ci_hdrc *ci)
> >  {
> >       int ret;
> >  
> > +     if (ci->platdata->flags & CI_HDRC_OVERRIDE_PHY_CONTROL)
> > +             return 0;
> > +
> 
> How you handle the code for PHY getting at probe?
> 

Which probe? Glue layer probe? In my case I'm not using the phy until
the RESET/STOPPED event so I just rely on the chipidea core to get the
phy and then control the phy manually in the glue layer.
