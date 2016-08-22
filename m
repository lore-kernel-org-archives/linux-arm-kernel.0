From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 22 Aug 2016 15:29:07 +0800
Subject: [PATCH] usb: chipidea: support generic phy in PM code path
In-Reply-To: <20160822143921.36b6f95a@xhacker>
References: <20160819121013.760-1-jszhang@marvell.com>
 <20160822053308.GA4362@shlinux2> <20160822143921.36b6f95a@xhacker>
Message-ID: <20160822072907.GD4362@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 02:39:21PM +0800, Jisheng Zhang wrote:
> Hi Peter,
> 
> On Mon, 22 Aug 2016 13:33:08 +0800 Peter Chen wrote:
> 
> > On Fri, Aug 19, 2016 at 08:10:13PM +0800, Jisheng Zhang wrote:
> > > Support generic phy in PM code path: call phy_power_off/phy_power_on
> > > in ci_controller_suspend/ci_controller_resume.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > ---
> > >  drivers/usb/chipidea/core.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > > index ae12595..ef9fb0b 100644
> > > --- a/drivers/usb/chipidea/core.c
> > > +++ b/drivers/usb/chipidea/core.c
> > > @@ -1116,6 +1116,7 @@ static void ci_controller_suspend(struct ci_hdrc *ci)
> > >  		usleep_range(ci->platdata->phy_clkgate_delay_us,
> > >  			     ci->platdata->phy_clkgate_delay_us + 50);
> > >  	usb_phy_set_suspend(ci->usb_phy, 1);
> > > +	phy_power_off(ci->phy);  
> > 
> > How could you support USB wakeup after PHY is powered off?
> 
> Per my understanding, the PHY's power off just power off data communication part
> but leaves the circuits involved in wakeup detection active.
> 

Ok, I hope so.

Peter
> 
> > 
> > Peter
> > 
> > >  	ci->in_lpm = true;
> > >  	enable_irq(ci->irq);
> > >  }
> > > @@ -1132,9 +1133,10 @@ static int ci_controller_resume(struct device *dev)
> > >  	}
> > >  
> > >  	ci_hdrc_enter_lpm(ci, false);
> > > -	if (ci->usb_phy) {
> > > +	if (ci->usb_phy || ci->phy) {
> > >  		usb_phy_set_suspend(ci->usb_phy, 0);
> > >  		usb_phy_set_wakeup(ci->usb_phy, false);
> > > +		phy_power_on(ci->phy);
> > >  		hw_wait_phy_stable();
> > >  	}
> > >  
> > > -- 
> > > 2.9.3
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > > the body of a message to majordomo at vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> > 
> 

-- 

Best Regards,
Peter Chen
