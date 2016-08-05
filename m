From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Fri, 5 Aug 2016 06:18:11 +0000
Subject: [PATCH v1] net: phy: micrel: Add specific suspend
In-Reply-To: <11f70064-11d6-47b9-6ec1-83b7b0dc5419@gmail.com>
References: <1470270095-13131-1-git-send-email-wenyou.yang@atmel.com>
 <11f70064-11d6-47b9-6ec1-83b7b0dc5419@gmail.com>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB393CF0@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli at gmail.com]
> Sent: 2016?8?4? 11:33
> To: Wenyou Yang <wenyou.yang@atmel.com>
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Alexandre Belloni <alexandre.belloni@free-
> electrons.com>; Nicolas Ferre <nicolas.ferre@atmel.com>; Andrew Lunn
> <andrew@lunn.ch>
> Subject: Re: [PATCH v1] net: phy: micrel: Add specific suspend
> 
> On 03/08/2016 17:21, Wenyou Yang wrote:
> > Disable all interrupts when suspend, they will be enabled when resume.
> > Otherwise, the suspend/resume process will be blocked occasionally.
> 
> This seems like something fairly generic actually, we could imagine having the
> core library do something like this:
> 
> - if interrupts are valid and enabled for the PHY, call
> phydrv->config_intr() with PHY_INTERRUPT_DISABLED
> - call genphy_suspend

Accepted. I will send a new version.

> 
> Of course if none of this fits the generic model, the PHY driver can still provide a
> suspend callback. Might be worth auditing other drivers for that pattern and look at
> those that need specific handling like keeping specific interrupt sources active for
> e.g: wake-on-LAN.
> 
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> >
> >  drivers/net/phy/micrel.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c index
> > 5a8fefc..8cb778a 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -647,6 +647,23 @@ static void kszphy_get_stats(struct phy_device
> *phydev,
> >  		data[i] = kszphy_get_stat(phydev, i);  }
> >
> > +int kszphy_suspend(struct phy_device *phydev) {
> > +	int value;
> > +
> > +	mutex_lock(&phydev->lock);
> > +
> > +	/* disable interrupts */
> > +	phy_write(phydev, MII_KSZPHY_INTCS, 0x0);
> > +
> > +	value = phy_read(phydev, MII_BMCR);
> > +	phy_write(phydev, MII_BMCR, value | BMCR_PDOWN);
> > +
> > +	mutex_unlock(&phydev->lock);
> > +
> > +	return 0;
> > +}
> > +
> >  static int kszphy_resume(struct phy_device *phydev)  {
> >  	int value;
> > @@ -870,7 +887,7 @@ static struct phy_driver ksphy_driver[] = {
> >  	.get_sset_count = kszphy_get_sset_count,
> >  	.get_strings	= kszphy_get_strings,
> >  	.get_stats	= kszphy_get_stats,
> > -	.suspend	= genphy_suspend,
> > +	.suspend	= kszphy_suspend,
> >  	.resume		= kszphy_resume,
> >  }, {
> >  	.phy_id		= PHY_ID_KSZ8061,
> >


Best Regards,
Wenyou Yang
