From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 18 Nov 2015 21:39:54 +0100 (CET)
Subject: device_node lifetime (was: Re: [PATCH 1/7] phy: brcmstb-sata:
 add missing of_node_put)
In-Reply-To: <20151118190500.GE140057@google.com>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447673600-8881-2-git-send-email-Julia.Lawall@lip6.fr>
 <20151117013830.GV8456@google.com>
 <alpine.DEB.2.02.1511170711340.2045@localhost6.localdomain6>
 <20151117174430.GA8456@google.com>
 <alpine.DEB.2.10.1511171846120.2455@hadrien>
 <20151117183036.GF8456@google.com>
 <alpine.DEB.2.02.1511172327030.2121@localhost6.localdomain6>
 <20151118190500.GE140057@google.com>
Message-ID: <alpine.DEB.2.02.1511182138090.2059@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 18 Nov 2015, Brian Norris wrote:

> (changing subject, add devicetree at vger.kernel.org)
> 
> On Tue, Nov 17, 2015 at 11:33:25PM +0100, Julia Lawall wrote:
> > On Tue, 17 Nov 2015, Brian Norris wrote:
> > > On Tue, Nov 17, 2015 at 06:48:39PM +0100, Julia Lawall wrote:
> > > > Is this something that should be checked for elsewhere?
> > > 
> > > I expect the same sort of problem shows up plenty of other places. I
> > > don't think many people use CONFIG_OF_DYNAMIC, so the effects of these
> > > failures probably aren't felt by many.
> > 
> > I tried the following semantic patch:
> > 
> > @@
> > struct device_node *e;
> > expression e1;
> > identifier fld;
> > @@
> > 
> >  ... when != of_node_get(...)
> > *(<+...e1->fld...+>) = e
> >  ... when != of_node_get(...)
> >  return e1;
> > 
> > basically, this says that a structure field is initilized to a device node 
> > value, the structure is returned by the containing function, and the 
> > containing function contains no of_node_get at all.  Certainly this is 
> > quite constrained, but it does produce a number of examples.
> > 
> > I looked at a few of them:
> > 
> > drivers/clk/ingenic/cgu.c, ingenic_cgu_new
> > clk/pistachio/clk.c, pistachio_clk_alloc_provider
> 
> It looks like the clock core (drivers/clk/clk.c) initially grabs the clk
> provider node in of_clk_init(), then drops it after it's initialized,
> but most of these providers use of_clk_add_provider(), which seems to
> manage the device_node lifetime for the user. So I think these are OK.
> 
> > drivers/mfd/syscon.c, of_syscon_register
> 
> This one looks potentially suspect. Syscon nodes aren't usually directly
> managed by a single driver, and the device_node pointer is used for
> lookups later...so I think it should keep a kref, and it doesn't.
> 
> > drivers/of/pdt.c, function of_pdt_create_node
> 
> Not real sure about this one.
> 
> > Any idea whether these need of_node_get?  In all cases the device node 
> > value comes in as a parameter.
> 
> I'm really not an expert on this stuff. I just saw a potential problem
> that I happen to be looking at in other subsystems, and I wanted to know
> what others thought.

Thanks for the analysis.  I will look into them a bit more.  Hopefully at 
least the maintainer of each file will know what should be done.

julia

> I think this discussion should include the DT folks
> and the subsystems in question. For one, I'm as interested as anyone in
> getting this todo clarified:
> 
> Documentation/devicetree/todo.txt
> - Document node lifecycle for CONFIG_OF_DYNAMIC
> 
> Regards,
> Brian
> 
