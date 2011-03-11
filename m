From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 11 Mar 2011 14:08:16 +0000
Subject: [PATCH 4/8] macb: initial support for Cadence GEM
In-Reply-To: <20110311133445.GP9351@game.jcrosoft.org>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-5-git-send-email-jamie@jamieiles.com>
	<20110311131415.GO9351@game.jcrosoft.org>
	<20110311133016.GF7357@pulham.picochip.com>
	<20110311133445.GP9351@game.jcrosoft.org>
Message-ID: <20110311140816.GH7357@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 02:34:45PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:30 Fri 11 Mar     , Jamie Iles wrote:
> > On Fri, Mar 11, 2011 at 02:14:15PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 10:10 Thu 10 Mar     , Jamie Iles wrote:
> > > > The Cadence GEM is based on the MACB Ethernet controller but has a few
> > > > small changes with regards to register and bitfield placement.  This
> > > > patch adds a new platform driver for gem which sets allows the driver to
> > > > tell at runtime whether it is targetting a GEM device.
> > > > 
> > > > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> > > could we avoid all this if else everywhere?
> > 
> > I can't really see any other way to do this, but you're right it isn't 
> > particularly nice.  Having said that, it is only in the initialization 
> > code so there shouldn't be any real performance impact.
> > 
> > I'm open to ideas though!
> use macro or inline at least

Ok, so this works:

#define macb_or_gem_writel(__bp, __reg, __value) \
	({ \
		if ((__bp)->is_gem) \
			gem_writel((__bp), __reg, __value); \
		else \
			macb_writel((__bp), __reg, __value); \
	})

#define macb_or_gem_readl(__bp, __reg) \
	({ \
		u32 __v; \
		if ((__bp)->is_gem) \
			__v = gem_readl((__bp), __reg); \
		else \
			__v = macb_readl((__bp), __reg); \
		__v; \
	})

and then we can use these for things like the hardware addresses where 
the registers are different but I wanted to avoid the conditional in 
every register access if possible.

How is this for you?  We then only have visible conditionals for the 
data bus width (as I don't know if that is something that MACB can do or 
what the numbers are) and for the stats collection, but that seems 
acceptable to me.

Jamie
