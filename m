From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 9 Oct 2015 17:54:32 +0200 (CEST)
Subject: [PATCH 2/9] pci: mvebu: fix memory leaks and refcount leaks
In-Reply-To: <20151009171442.52988f0b@free-electrons.com>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
 <E1ZiRIs-0004Id-AN@rmk-PC.arm.linux.org.uk>
 <20151009165240.3ba17ece@free-electrons.com> <20151009150710.GJ14688@lunn.ch>
 <20151009171442.52988f0b@free-electrons.com>
Message-ID: <alpine.DEB.2.10.1510091753460.2665@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 9 Oct 2015, Thomas Petazzoni wrote:

> Hello
>
> (Julia added in the list of recipients).
>
> On Fri, 9 Oct 2015 17:07:10 +0200, Andrew Lunn wrote:
>
> > > > @@ -1052,10 +1086,12 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > > >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> > > >
> > > >  		ret = mvebu_pcie_parse_port(pcie, port, child);
> > > > -		if (ret < 0)
> > > > +		if (ret < 0) {
> > > > +			of_node_put(child);
> > > >  			return ret;
> > > > -		else if (ret == 0)
> > > > +		} else if (ret == 0) {
> > > >  			continue;
> > > > +		}
> > >
> > > This is not trivial. If I understand correctly,
> > > for_each_available_child_of_node() will automatically release the
> > > reference on the previous node and take the reference on the new one
> > > before entering the loop code. So in the skipping case, we don't need
> > > to release the reference as it will be done by the next iteration of
> > > the loop, but in the error case, since we are unexpectedly breaking the
> > > loop, we need to do it manually.
> > >
> > > The sort of tricky thing that should be documented near
> > > for_each_child_of_node(), since I believe a lot of code gets this
> > > wrong.
> >
> > Sounds like a good candidate for a coccinelle script. Maybe you could
> > ask Julia Lawall?
>
> Julia: some of the Device Tree iterator functions have a somewhat
> "interesting" behavior in that they take the reference on the current
> child when entering the loop, and release it before entering the next
> iteration (which will also take a reference to the next child).
>
> This means that if you have an exit point inside the loop (break or
> return), you are loosing a reference. For example,
> http://lxr.free-electrons.com/source/arch/arm/mach-shmobile/pm-rmobile.c#L367
> is wrong because there is a missing of_node_put(np) before the "return
> -ENOMEM".
>
> So essentially, every exit point in such Device Tree iteration loops
> should make to call of_node_put() on the current element before exiting
> the loop unexpectedly.
>
> As Andrew suggested, this is probably something a Coccinelle semantic
> patch could easily detect and probably fix automatically.

Yeah, I looked at this along time ago, including the interesting
loop behavior. I'll check on it again.  Thanks for the pointer.

julia
