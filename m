From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 6 Jan 2011 08:10:47 +0100
Subject: [PATCH v3 05/10] net/fec: add dual fec support for mx28
In-Reply-To: <20110106041457.GC17891@freescale.com>
References: <1294236457-17476-1-git-send-email-shawn.guo@freescale.com>
	<1294236457-17476-6-git-send-email-shawn.guo@freescale.com>
	<20110105163449.GU25121@pengutronix.de>
	<20110106041457.GC17891@freescale.com>
Message-ID: <20110106071047.GW25121@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Thu, Jan 06, 2011 at 12:14:59PM +0800, Shawn Guo wrote:
> On Wed, Jan 05, 2011 at 05:34:49PM +0100, Uwe Kleine-K?nig wrote:
> > On Wed, Jan 05, 2011 at 10:07:32PM +0800, Shawn Guo wrote:
> > > +#define DRIVER_NAME  "fec"
> > > +#define ENET_MAC_NAME        "enet-mac"
> > > +
> > > +static struct platform_device_id fec_devtype[] = {
> > > +     {
> > > +             .name = DRIVER_NAME,
> > > +     }, {
> > > +             .name = ENET_MAC_NAME,
> > > +     }
> > I'd done it differently:
> > 
> >         {
> >                 .name = "fec",
> >                 .driver_data = 0,
> >         }, {
> >                 .name = "imx28-fec",
> >                 .driver_data = HAS_ENET_MAC | ...,
> >         }
> > 
> > and then test the bits in driver_data (which you get using
> > platform_get_device_id() when you need to distinguish.
> > Comparing names doesn't scale, assume there are three further features
> > to distinguish, then you need to use strtok or index and get device
> > names like enet-mac-with-feature1-but-without-feature2-and-feature3.
> > 
> Makes sense.  The frame endian issue will be fixed in future revision,
> so I would define bit SWAP_FRAME for testing.
sounds sane
 
> > > +     /*
> > > +      * enet-mac design made an improper assumption that it's running
> > > +      * on a big endian system. As the result, driver has to swap
> > if he was really aware that he limits the performant use of the fec to
> > big endian systems, can you please make him stop designing hardware!?
> > 
> You over looked my power :)  BTW, he had left Freescale.
so everything seems OK with your power :-)

> > > +      * every frame going to and coming from the controller.
> > > +      */
> > > +     if (fec_is_enetmac)
> > > +             swap_buffer(bufaddr, skb->len);
> > > +
> > >       /* Save skb pointer */
> > >       fep->tx_skbuff[fep->skb_cur] = skb;
> > >
> > > @@ -487,6 +522,9 @@ fec_enet_rx(struct net_device *dev)
> > >               dma_unmap_single(NULL, bdp->cbd_bufaddr, bdp->cbd_datlen,
> > >                               DMA_FROM_DEVICE);
> > >
> > > +             if (fec_is_enetmac)
> > > +                     swap_buffer(data, pkt_len);
> > > +
> > >               /* This does 16 byte alignment, exactly what we need.
> > >                * The packet length includes FCS, but we don't want to
> > >                * include that when passing upstream as it messes up
> > > @@ -689,6 +727,7 @@ static int fec_enet_mii_probe(struct net_device *dev)
> > >       char mdio_bus_id[MII_BUS_ID_SIZE];
> > >       char phy_name[MII_BUS_ID_SIZE + 3];
> > >       int phy_id;
> > > +     int dev_id = fep->pdev->id;
> > >
> > >       fep->phy_dev = NULL;
> > >
> > > @@ -700,6 +739,8 @@ static int fec_enet_mii_probe(struct net_device *dev)
> > >                       continue;
> > >               if (fep->mii_bus->phy_map[phy_id]->phy_id == 0)
> > >                       continue;
> > > +             if (fec_is_enetmac && dev_id--)
> > > +                     continue;
> > >               strncpy(mdio_bus_id, fep->mii_bus->id, MII_BUS_ID_SIZE);
> > >               break;
> > >       }
> > > @@ -741,6 +782,28 @@ static int fec_enet_mii_init(struct platform_device *pdev)
> > >       struct fec_enet_private *fep = netdev_priv(dev);
> > >       int err = -ENXIO, i;
> > >
> > > +     /*
> > > +      * The dual fec interfaces are not equivalent with enet-mac.
> > > +      * Here are the differences:
> > > +      *
> > > +      *  - fec0 supports MII & RMII modes while fec1 only supports RMII
> > > +      *  - fec0 acts as the 1588 time master while fec1 is slave
> > > +      *  - external phys can only be configured by fec0
> > > +      *
> > > +      * That is to say fec1 can not work independently. It only works
> > > +      * when fec0 is working. The reason behind this design is that the
> > > +      * second interface is added primarily for Switch mode.
> > > +      *
> > > +      * Because of the last point above, both phys are attached on fec0
> > > +      * mdio interface in board design, and need to be configured by
> > > +      * fec0 mii_bus.
> > > +      */
> > > +     if (fec_is_enetmac && pdev->id) {
> > > +             /* fec1 uses fec0 mii_bus */
> > > +             fep->mii_bus = fec_mii_bus;
> > > +             return 0;
> > > +     }
> > > +
> > >       fep->mii_timeout = 0;
> > >
> > >       /*
> > > @@ -777,6 +840,10 @@ static int fec_enet_mii_init(struct platform_device *pdev)
> > >       if (mdiobus_register(fep->mii_bus))
> > >               goto err_out_free_mdio_irq;
> > >
> > > +     /* save fec0 mii_bus */
> > > +     if (fec_is_enetmac)
> > > +             fec_mii_bus = fep->mii_bus;
> > > +
> > >       return 0;
> > >
> > >  err_out_free_mdio_irq:
> > > @@ -1149,11 +1216,22 @@ fec_restart(struct net_device *dev, int duplex)
> > >  {
> > >       struct fec_enet_private *fep = netdev_priv(dev);
> > >       int i;
> > > +     u32 val, temp_mac[2];
> > >
> > >       /* Whack a reset.  We should wait for this. */
> > >       writel(1, fep->hwp + FEC_ECNTRL);
> > >       udelay(10);
> > >
> > > +     /*
> > > +      * enet-mac reset will reset mac address registers too,
> > > +      * so need to reconfigure it.
> > > +      */
> > > +     if (fec_is_enetmac) {
> > > +             memcpy(&temp_mac, dev->dev_addr, ETH_ALEN);
> 		  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +             writel(cpu_to_be32(temp_mac[0]), fep->hwp + FEC_ADDR_LOW);
> > > +             writel(cpu_to_be32(temp_mac[1]), fep->hwp + FEC_ADDR_HIGH);
> > where is the value saved to temp_mac[]?  For me it looks you write
> > uninitialized data into the mac registers.
> 
> memcpy above.
oops.  right.  I looked for something like

	temp_mac[0] = dev->dev_addr[0] << $shiftfor0 | ...

which AFAIK is what you want here.  memcpy is sensible to (at least)
endian issues.  If you ask me factor out the setting of the mac address
in probe to a function and use that here, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
