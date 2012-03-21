From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 21 Mar 2012 19:45:17 +0800
Subject: [PATCH 1/1] net: phylib: add error checking if no phy found
In-Reply-To: <4F5F5ABF.5030103@openwrt.org>
References: <1331636302-18256-1-git-send-email-b29396@freescale.com>
 <4F5F5ABF.5030103@openwrt.org>
Message-ID: <20120321114516.GC4905@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 10:33:35PM +0800, Florian Fainelli wrote:
> Hi,
> 
> Le 03/13/12 11:58, Dong Aisheng a ?crit :
> > From: Dong Aisheng<dong.aisheng@linaro.org>
> >
> > Signed-off-by: Dong Aisheng<dong.aisheng@linaro.org>
> > ---
> >   drivers/net/phy/mdio_bus.c |   11 ++++++++++-
> >   1 files changed, 10 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> > index 88cc5db..d8e044d 100644
> > --- a/drivers/net/phy/mdio_bus.c
> > +++ b/drivers/net/phy/mdio_bus.c
> > @@ -101,6 +101,7 @@ static struct class mdio_bus_class = {
> >   int mdiobus_register(struct mii_bus *bus)
> >   {
> >   	int i, err;
> > +	u32 phynum = 0;
> >
> >   	if (NULL == bus || NULL == bus->name ||
> >   			NULL == bus->read ||
> > @@ -134,12 +135,20 @@ int mdiobus_register(struct mii_bus *bus)
> >   			if (IS_ERR(phydev)) {
> >   				err = PTR_ERR(phydev);
> >   				goto error;
> > +			} else if (phydev != NULL) {
> > +				phynum++;
> >   			}
> >   		}
> >   	}
> >
> > +	if (!phynum) {
> > +		err = -ENODEV;
> > +		printk(KERN_ERR "%s: no phys found\n", bus->name);
> > +		goto error;
> > +	}
> 
> I am not sure if this is a good idea to change it, especially if:
> - the MII bus probing is also done later (quite some drivers do this)
> - if we want to attach a fixed PHY because we could not probe one at 
> registration time
> 
You're correct.
It seems keep it as before is the right solution right now.
Thanks for the info.

Regards
Dong Aisheng
