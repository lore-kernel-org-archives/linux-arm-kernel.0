From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 22 Aug 2017 16:41:01 +0200
Subject: [PATCH net-next 03/18] net: mvpp2: set the SMI PHY address when
 connecting to the PHY
In-Reply-To: <20170728042153.GH18666@lunn.ch>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-4-antoine.tenart@free-electrons.com>
 <20170726160806.GF12049@lunn.ch> <20170728014905.GC24728@kwain>
 <20170728042153.GH18666@lunn.ch>
Message-ID: <20170822144101.GC14942@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, Jul 28, 2017 at 06:21:53AM +0200, Andrew Lunn wrote:
> On Thu, Jul 27, 2017 at 06:49:05PM -0700, Antoine Tenart wrote:
> > On Wed, Jul 26, 2017 at 06:08:06PM +0200, Andrew Lunn wrote:
> > > On Mon, Jul 24, 2017 at 03:48:33PM +0200, Antoine Tenart wrote:
> > > >  
> > > > +	if (priv->hw_version != MVPP22)
> > > > +		return 0;
> > > > +
> > > > +	/* Set the SMI PHY address */
> > > > +	if (of_property_read_u32(port->phy_node, "reg", &phy_addr)) {
> > > > +		netdev_err(port->dev, "cannot find the PHY address\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	writel(phy_addr, priv->iface_base + MVPP22_SMI_PHY_ADDR(port->gop_id));
> > > >  	return 0;
> > > >  }
> > > 
> > > Why does the MAC need to know this address? The phylib and PHY driver
> > > should be the only thing accessing the PHY, otherwise you are asking
> > > for trouble.
> > 
> > This is part of the SMI/xSMI interface. I added into the mvpp2 driver
> > and not in the mvmdio one because the GoP port number must be known to
> > set this register (so that would be even less clean to do it).
> 
> It is still not clear to my why you need to program the address into
> the hardware. Is the hardware talking to the PHY?

Sorry for the answer delay, I was out of the office...

This PHY address configuration should be done in the mvmdio driver as
this is not directly related to the PPv2 (well, the mvmdio driver is
only an abstraction to reuse the mdio code, using registers exposed by
PPv2 in this case anyway). But two values must be known in order to do
this: the PHY address and the GoP port number. Getting the last one from
the mvmdio driver would be really ugly as we would need to read the PPv2
dt node. This is why this patch adds it in the PPv2 driver, but I know
it's not perfect.

I'll resend a series very soon, with this patch still included. We can
continue the discussion there I guess, if needed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170822/62297792/attachment.sig>
