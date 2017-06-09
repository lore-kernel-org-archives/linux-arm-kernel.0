From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 9 Jun 2017 16:09:22 +0200
Subject: [PATCH v2 7/8] net: mvmdio: add xmdio support
In-Reply-To: <20170609132624.GC20756@lunn.ch>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-8-antoine.tenart@free-electrons.com>
 <a60a0b26-62b1-7c9e-e846-215747dddb1f@gmail.com>
 <20170609082541.GC31464@kwain> <20170609132624.GC20756@lunn.ch>
Message-ID: <20170609140922.GD31464@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, Jun 09, 2017 at 03:26:24PM +0200, Andrew Lunn wrote:
> On Fri, Jun 09, 2017 at 10:25:41AM +0200, Antoine Tenart wrote:
> > On Thu, Jun 08, 2017 at 09:42:21AM -0700, Florian Fainelli wrote:
> > > 
> > > If I get this right, the xMDIO controller is actually a superset of the
> > > MDIO controller and has an extra MVMDIO_XSMI_ADDR_REG register to
> > > preform C45 accesses?
> > 
> > This is also a mistake. It's not a superset as the register offsets are
> > different. So we can't use the same smi operations in both cases. We
> > would need dedicated xmdio smi operations, but I don't think there is a
> > board where a c22 PHY is connected to the xMDIO interface.
> 
> Is it described as one device, which can do c22 via one set of
> registers, and c45 by another set of registers?
> 
> Or are there two separate devices. In particular, does each device
> have there own MDC and MDIO pins? Do we have an C22 only device/bus,
> and a C45 only device/bus?

The MDIO/xMDIO registers are embedded into the network controller. The
mvmdio driver was created at first to abstract this functionality
outside the network controller driver because it is shared between all
ports and used in different IPs. So it's not really devices per say.

Looking at the datasheet/schematics there are two hardware buses, one
for c22 and one for c45. So we should keep two separate nodes to
describe the two interfaces. From what I read c45 is backward
compatible with c22 so the xSMI interface should be capable to speak to
c22 PHYs as well. And by looking at the datasheet this seems possible,
although it's not completely clear. But anyway this wouldn't impact the
dt bindings.

What I'll propose in v3 is two separate nodes, with their own
compatibles. The driver will have smi ops for the marvell,orion-mdio and
xsmi ops for the marvell,xmdio. I won't implement for now the smi ops
for marvell,xmdio as I can't test them and can't be 100% sure it would
work. (But again this won't impact the dt and can be updated in the
driver later).

Does that sound right?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/cbd68fcc/attachment-0001.sig>
