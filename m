From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 17 Nov 2015 23:33:25 +0100 (CET)
Subject: [PATCH 1/7] phy: brcmstb-sata: add missing of_node_put
In-Reply-To: <20151117183036.GF8456@google.com>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447673600-8881-2-git-send-email-Julia.Lawall@lip6.fr>
 <20151117013830.GV8456@google.com>
 <alpine.DEB.2.02.1511170711340.2045@localhost6.localdomain6>
 <20151117174430.GA8456@google.com>
 <alpine.DEB.2.10.1511171846120.2455@hadrien>
 <20151117183036.GF8456@google.com>
Message-ID: <alpine.DEB.2.02.1511172327030.2121@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 17 Nov 2015, Brian Norris wrote:

> On Tue, Nov 17, 2015 at 06:48:39PM +0100, Julia Lawall wrote:
> > On Tue, 17 Nov 2015, Brian Norris wrote:
> > > On Tue, Nov 17, 2015 at 07:12:22AM +0100, Julia Lawall wrote:
> > > > On Mon, 16 Nov 2015, Brian Norris wrote:
> > > > > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > > > > index fc48fac003a6..8df29caeeef9 100644
> > > > > --- a/drivers/phy/phy-core.c
> > > > > +++ b/drivers/phy/phy-core.c
> > > > > @@ -697,6 +697,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
> > > > >  	phy->dev.class = phy_class;
> > > > >  	phy->dev.parent = dev;
> > > > >  	phy->dev.of_node = node ?: dev->of_node;
> > > > > +	of_node_get(phy->dev.of_node);
> > > >
> > > > Why not put of_node_get around dev->of_node?
> > >
> > > Like this?
> > >
> > > 	phy->dev.of_node = node ?: of_node_get(dev->of_node);
> > >
> > > Or this?
> > >
> > > 	phy->dev.of_node = of_node_get(node ?: dev->of_node);
> > >
> > > The former wouldn't do what I proposed; if this PHY device is created
> > > with a sub-node of 'dev' rather than dev->of_node, then the caller will
> > > pass it in as the 2nd argument to phy_create (i.e., 'node'), and then I
> > > expect it's the PHY core's responsibility to refcount it.
> > >
> > > I'd be fine with the latter. Looks a little better, I suppose.
> > 
> > I proposed it because I was worried that the of_node field could end up
> > containing something that had been freed.  But probably this is not
> > possible?
> 
> AIUI, the caller of phy_create() should already have a refcount on both
> 'dev->of_node' and 'node' (if applicable), so nobody should be freeing
> it from underneath us right here. But *after* phy_create() returns,
> there's no guarantee the caller will hold a reference for us.
> 
> So even if it's ever possible, I'd consider it a bug in the caller, not
> in phy_create().
> 
> > If it is not possible, then the ?: in the function argument is
> > probably a bit ugly...
> 
> OK, then I'll go with my first proposal.
> 
> > Is this something that should be checked for elsewhere?
> 
> I expect the same sort of problem shows up plenty of other places. I
> don't think many people use CONFIG_OF_DYNAMIC, so the effects of these
> failures probably aren't felt by many.

I tried the following semantic patch:

@@
struct device_node *e;
expression e1;
identifier fld;
@@

 ... when != of_node_get(...)
*(<+...e1->fld...+>) = e
 ... when != of_node_get(...)
 return e1;

basically, this says that a structure field is initilized to a device node 
value, the structure is returned by the containing function, and the 
containing function contains no of_node_get at all.  Certainly this is 
quite constrained, but it does produce a number of examples.

I looked at a few of them:

drivers/clk/ingenic/cgu.c, ingenic_cgu_new
clk/pistachio/clk.c, pistachio_clk_alloc_provider
drivers/mfd/syscon.c, of_syscon_register
drivers/of/pdt.c, function of_pdt_create_node

Any idea whether these need of_node_get?  In all cases the device node 
value comes in as a parameter.

thanks,
julia
