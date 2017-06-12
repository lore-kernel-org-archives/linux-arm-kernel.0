From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 12 Jun 2017 13:54:35 +0200
Subject: [PATCH v3 7/9] net: mvmdio: add xmdio xsmi support
In-Reply-To: <20170612101739.GA4902@n2100.armlinux.org.uk>
References: <20170612095745.11300-1-antoine.tenart@free-electrons.com>
 <20170612095745.11300-8-antoine.tenart@free-electrons.com>
 <20170612101739.GA4902@n2100.armlinux.org.uk>
Message-ID: <20170612115435.GC22312@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Jun 12, 2017 at 11:17:39AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 12, 2017 at 11:57:43AM +0200, Antoine Tenart wrote:
> > +static const struct orion_mdio_ops *orion_mdio_get_ops(struct orion_mdio_dev *dev,
> > +						       int regnum)
> > +{
> > +	if (dev->bus_type == BUS_TYPE_XSMI && (regnum & MII_ADDR_C45))
> > +		return &orion_mdio_xsmi_ops;
> > +	else if (dev->bus_type == BUS_TYPE_SMI)
> > +		return &orion_mdio_smi_ops;
> > +
> > +	return ERR_PTR(-EOPNOTSUPP);
> > +}
> 
> Oh, this is where you're doing it - I'm not sure having this complexity
> is really necessary - there is no dynamic choice between the two.  This
> seems to be way over-engineered.

You're right, there is no dynamic choice between the two. The advantage
is the logic of the read/write operations are not duplicated.

> You might as well make the SMI operations fail if MII_ADDR_C45 is set,
> and the XSMI operations fail if MII_ADDR_C45 is not set.

This check is already done for xSMI operations. But this should also be
the case for SMI ones, you're right.

> 1. the mdio read/write functions implement their own locking.
> 
>    At the MDIO level, there is already locking in the form of a per-bus
>    lock "bus->mdio_lock" which will be taken whenever either of these
>    functions is called.  So the driver's "dev->lock" is redundant.

OK, that's a good rework to add in the series.

> 2. with the redundant locking removed, orion_mdio_write() becomes a
>    call to orion_mdio_wait_ready() followed by a call to dev->ops->write.
>    It seems that orion_mdio_wait_ready() could be a library function
>    shared between a SMI version of orion_mdio_write() and a XSMI version.
> 
> 3. the same is really true of orion_mdio_read(), although that function
>    is a little more complex in itself, the result would actually end up
>    being simpler.

I'm not completely convinced as the read and write functions end up
being duplicated. One for SMI operations and one for xSMI. But I don't
really care, if you think this is better let's go for it.

Should I add your first patch in my series and squash the second one in
patch 7/9? (I'll also remove the bus_type member from the private
struct, as well as the one line it's used in the probe).

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170612/9488ca0c/attachment.sig>
