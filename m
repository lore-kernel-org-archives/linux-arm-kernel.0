From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 17 Nov 2015 18:48:39 +0100 (CET)
Subject: [PATCH 1/7] phy: brcmstb-sata: add missing of_node_put
In-Reply-To: <20151117174430.GA8456@google.com>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447673600-8881-2-git-send-email-Julia.Lawall@lip6.fr>
 <20151117013830.GV8456@google.com>
 <alpine.DEB.2.02.1511170711340.2045@localhost6.localdomain6>
 <20151117174430.GA8456@google.com>
Message-ID: <alpine.DEB.2.10.1511171846120.2455@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 17 Nov 2015, Brian Norris wrote:

> On Tue, Nov 17, 2015 at 07:12:22AM +0100, Julia Lawall wrote:
> > On Mon, 16 Nov 2015, Brian Norris wrote:
> > >
> > > This reminds me of a potential problem I'm looking at in other
> > > subsystems: from code reading (I haven't seen any issues in practice,
> > > probably because I don't use OF_DYNAMIC) it looks like device-creating
> > > infrastructure like the PHY subsystem should be acquiring a reference to
> > > the device_node when they stash it away. But drivers/phy/phy-core.c does
> > > not do this, AFAICT.
> > >
> > > See phy_create(), which does
> > >
> > > 	phy->dev.of_node = node ?: dev->of_node;
> > >
> > > and later might reuse this of_node pointer, even though it never called
> > > of_node_get() on this node.
> > >
> > > Potential patch to fix this (not tested).
> > >
> > > Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> > >
> > > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> > > index fc48fac003a6..8df29caeeef9 100644
> > > --- a/drivers/phy/phy-core.c
> > > +++ b/drivers/phy/phy-core.c
> > > @@ -697,6 +697,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
> > >  	phy->dev.class = phy_class;
> > >  	phy->dev.parent = dev;
> > >  	phy->dev.of_node = node ?: dev->of_node;
> > > +	of_node_get(phy->dev.of_node);
> >
> > Why not put of_node_get around dev->of_node?
>
> Like this?
>
> 	phy->dev.of_node = node ?: of_node_get(dev->of_node);
>
> Or this?
>
> 	phy->dev.of_node = of_node_get(node ?: dev->of_node);
>
> The former wouldn't do what I proposed; if this PHY device is created
> with a sub-node of 'dev' rather than dev->of_node, then the caller will
> pass it in as the 2nd argument to phy_create (i.e., 'node'), and then I
> expect it's the PHY core's responsibility to refcount it.
>
> I'd be fine with the latter. Looks a little better, I suppose.

I proposed it because I was worried that the of_node field could end up
containing something that had been freed.  But probably this is not
possible?  If it is not possible, then the ?: in the function argument is
probably a bit ugly...

Is this something that should be checked for elsewhere?

julia

> If my understanding is correct, I'll send a proper patch to do the
> latter.
>
> Regards,
> Brian
>
> > julia
> >
> > >  	phy->id = id;
> > >  	phy->ops = ops;
> > >
> > > @@ -726,6 +727,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
> > >  	return phy;
> > >
> > >  put_dev:
> > > +	of_node_put(phy->dev.of_node);
> > >  	put_device(&phy->dev);  /* calls phy_release() which frees resources */
> > >  	return ERR_PTR(ret);
> > >
> > > @@ -775,6 +777,7 @@ EXPORT_SYMBOL_GPL(devm_phy_create);
> > >   */
> > >  void phy_destroy(struct phy *phy)
> > >  {
> > > +	of_node_put(phy->dev.of_node);
> > >  	pm_runtime_disable(&phy->dev);
> > >  	device_unregister(&phy->dev);
> > >  }
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> > > the body of a message to majordomo at vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
>
