From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 22 Aug 2016 16:14:44 +0800
Subject: [PATCH] usb: chipidea: support generic phy in PM code path
In-Reply-To: <20160822072907.GD4362@shlinux2>
References: <20160819121013.760-1-jszhang@marvell.com>
 <20160822053308.GA4362@shlinux2>	<20160822143921.36b6f95a@xhacker>
 <20160822072907.GD4362@shlinux2>
Message-ID: <20160822161444.4ffb36d8@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Kishon

Hi Peter, Kishon,

On Mon, 22 Aug 2016 15:29:07 +0800 Peter Chen wrote:

> On Mon, Aug 22, 2016 at 02:39:21PM +0800, Jisheng Zhang wrote:
> > Hi Peter,
> > 
> > On Mon, 22 Aug 2016 13:33:08 +0800 Peter Chen wrote:
> >   
> > > On Fri, Aug 19, 2016 at 08:10:13PM +0800, Jisheng Zhang wrote:  
> > > > Support generic phy in PM code path: call phy_power_off/phy_power_on
> > > > in ci_controller_suspend/ci_controller_resume.
> > > > 
> > > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > > ---
> > > >  drivers/usb/chipidea/core.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > > > index ae12595..ef9fb0b 100644
> > > > --- a/drivers/usb/chipidea/core.c
> > > > +++ b/drivers/usb/chipidea/core.c
> > > > @@ -1116,6 +1116,7 @@ static void ci_controller_suspend(struct ci_hdrc *ci)
> > > >  		usleep_range(ci->platdata->phy_clkgate_delay_us,
> > > >  			     ci->platdata->phy_clkgate_delay_us + 50);
> > > >  	usb_phy_set_suspend(ci->usb_phy, 1);
> > > > +	phy_power_off(ci->phy);    
> > > 
> > > How could you support USB wakeup after PHY is powered off?  
> > 
> > Per my understanding, the PHY's power off just power off data communication part
> > but leaves the circuits involved in wakeup detection active.
> >   
> 
> Ok, I hope so.

If most parts of the phy can be powered off during runtime suspend to save
power, or phy HW support suspend mode, with usb phy, usb_phy_set_suspend() could
be used, but with the generic phy, it seems there's no corresponding API for
this purpose. I'm not sure whether using phy_power_off() is correct here. Is it
acceptable to extend the generic phy? such as, phy_suspend()/phy_resume()?

Thanks,
Jisheng
