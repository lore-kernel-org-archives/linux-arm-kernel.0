From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 9 Jun 2017 16:56:30 +0200
Subject: [PATCH v2 7/8] net: mvmdio: add xmdio support
In-Reply-To: <20170609144936.GF20756@lunn.ch>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-8-antoine.tenart@free-electrons.com>
 <a60a0b26-62b1-7c9e-e846-215747dddb1f@gmail.com>
 <20170609082541.GC31464@kwain> <20170609132624.GC20756@lunn.ch>
 <20170609140922.GD31464@kwain> <20170609144936.GF20756@lunn.ch>
Message-ID: <20170609145630.GE31464@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, Jun 09, 2017 at 04:49:36PM +0200, Andrew Lunn wrote:
> On Fri, Jun 09, 2017 at 04:09:22PM +0200, Antoine Tenart wrote:
> > 
> > The MDIO/xMDIO registers are embedded into the network controller. The
> > mvmdio driver was created at first to abstract this functionality
> > outside the network controller driver because it is shared between all
> > ports and used in different IPs. So it's not really devices per say.
> > 
> > Looking at the datasheet/schematics there are two hardware buses, one
> > for c22 and one for c45. So we should keep two separate nodes to
> > describe the two interfaces. From what I read c45 is backward
> > compatible with c22 so the xSMI interface should be capable to speak to
> > c22 PHYs as well.
> 
> The on the wire protocol of c45 is backwards compatible with c22, in
> that a c22 device will not get confused by a c45 transaction on the
> bus. A c22 device will just ignore it. You cannot talk to a c22 device
> using c45.

I see.

> From what you are saying, you have a hardware block generating c45
> transactions and a hardware block which generates c22 transactions.
> What is not clear to me is if these two hardware blocks are using the
> same physical MDC/MDIO pins, i.e. there is just one MDIO bus to the
> outside world, or are there two busses?

There are two busses, one generating c22 transactions and one generating
c45 transactions. Each bus has its own MDC/MDIO pins.

> > And by looking at the datasheet this seems possible, although it's
> > not completely clear. But anyway this wouldn't impact the dt
> > bindings.
> 
> What i'm worried about is there being one set of MDC/MDIO lines. You
> should not expose that to linux as two mdio busses. It is one bus.
> 
> The phylib will poll each phy on the bus once per second to check its
> state. The phylib serialises the read/writes at a bus level. So if you
> have one physical bus registered as two logical bus, at some point you
> are going to get simultaneous read/writes, and you are going to need a
> mutex low down to serialise this for physical bus access.
> 
> And in the end, this would affect the dt binding. If it is one
> physical bus, you want one binding representing both c22 and c45
> transactions.

Of course. See above.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/a03cf96d/attachment.sig>
