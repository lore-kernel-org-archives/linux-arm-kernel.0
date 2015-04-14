From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 14 Apr 2015 14:37:37 +0200
Subject: [PATCHv2 2/3] usb: ehci-platform: Use devm_of_phy_get_by_index
In-Reply-To: <6483716.157BQAaRqF@wuerfel>
References: <1428963047-23666-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1428963047-23666-3-git-send-email-arun.ramamurthy@broadcom.com>
 <20150414111934.GA27836@kroah.com> <6483716.157BQAaRqF@wuerfel>
Message-ID: <20150414123737.GB18756@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 01:33:08PM +0200, Arnd Bergmann wrote:
> On Tuesday 14 April 2015 13:19:34 Greg Kroah-Hartman wrote:
> > On Mon, Apr 13, 2015 at 03:10:46PM -0700, Arun Ramamurthy wrote:
> > > Getting phys by index instead of phy names so that we do
> > > not have to create a naming scheme when multiple phys
> > > are present
> > > 
> > > Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> > > Reviewed-by: Ray Jui <rjui@broadcom.com>
> > > Reviewed-by: Scott Branden <sbranden@broadcom.com>
> > > ---
> > >  drivers/usb/host/Kconfig         |  1 +
> > >  drivers/usb/host/ehci-platform.c | 70 ++++++++++++++--------------------------
> > >  2 files changed, 26 insertions(+), 45 deletions(-)
> > > 
> > > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> > > index 5ad60e4..563f22d 100644
> > > --- a/drivers/usb/host/Kconfig
> > > +++ b/drivers/usb/host/Kconfig
> > > @@ -284,6 +284,7 @@ config USB_EHCI_ATH79
> > >  
> > >  config USB_EHCI_HCD_PLATFORM
> > >       tristate "Generic EHCI driver for a platform device"
> > > +     select GENERIC_PHY
> > 
> > Configs should never select if at all possible.
> > 
> 
> This is true, but all other drivers do the same for GENERIC_PHY at the
> moment. If this one gets changed, we should probably apply the same
> solution to all current users and fix them consistently.
> 
> We can do one of these two:
> 
> a) make sure that the framework has 'static inline' stubs that let you
>    build all drivers using it when the framework itself is disabled.

Yes, please do that.

> b) change the drivers using it to 'depends on', and make GENERIC_PHY
>    itself a hidden option without a Kconfig prompt.

Then how could GENERIC_PHY ever get set?

> Either solution is probably simple enough that it can be done as
> part of this series.

That's fine with me, but please no more selects.

thanks,

greg k-h
