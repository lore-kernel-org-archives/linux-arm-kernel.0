From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 27 Jul 2017 18:49:05 -0700
Subject: [PATCH net-next 03/18] net: mvpp2: set the SMI PHY address when
 connecting to the PHY
In-Reply-To: <20170726160806.GF12049@lunn.ch>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-4-antoine.tenart@free-electrons.com>
 <20170726160806.GF12049@lunn.ch>
Message-ID: <20170728014905.GC24728@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, Jul 26, 2017 at 06:08:06PM +0200, Andrew Lunn wrote:
> On Mon, Jul 24, 2017 at 03:48:33PM +0200, Antoine Tenart wrote:
> >  
> > +	if (priv->hw_version != MVPP22)
> > +		return 0;
> > +
> > +	/* Set the SMI PHY address */
> > +	if (of_property_read_u32(port->phy_node, "reg", &phy_addr)) {
> > +		netdev_err(port->dev, "cannot find the PHY address\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	writel(phy_addr, priv->iface_base + MVPP22_SMI_PHY_ADDR(port->gop_id));
> >  	return 0;
> >  }
> 
> You could use phy_dev->mdiodev->addr, rather than parse the DT.

OK.

> Why does the MAC need to know this address? The phylib and PHY driver
> should be the only thing accessing the PHY, otherwise you are asking
> for trouble.

This is part of the SMI/xSMI interface. I added into the mvpp2 driver
and not in the mvmdio one because the GoP port number must be known to
set this register (so that would be even less clean to do it).

> What if the PHY is hanging off some other mdio bus? I've got a
> freescale board with dual ethernets and a Marvell switch on the
> hardware MDIO bus and a PHY on a bit-banging MDIO bus.

Then it wouldn't be controlled by the PPv2 SMI/xSMI interface, so we
wouldn't need to set the this register.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170727/b50413ff/attachment.sig>
