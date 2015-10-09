From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Oct 2015 16:07:57 +0100
Subject: [PATCH 2/9] pci: mvebu: fix memory leaks and refcount leaks
In-Reply-To: <20151009165240.3ba17ece@free-electrons.com>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
 <E1ZiRIs-0004Id-AN@rmk-PC.arm.linux.org.uk>
 <20151009165240.3ba17ece@free-electrons.com>
Message-ID: <20151009150757.GV32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 04:52:40PM +0200, Thomas Petazzoni wrote:
> Russell,
> 
> On Sat, 03 Oct 2015 19:13:02 +0100, Russell King wrote:
> 
> > +	ret = devm_add_action(dev, mvebu_pcie_port_clk_put, port);
> 
> I didn't know about devm_add_action(). Definitely very useful for such
> situations.
> 
> > @@ -1052,10 +1086,12 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> >  
> >  		ret = mvebu_pcie_parse_port(pcie, port, child);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			of_node_put(child);
> >  			return ret;
> > -		else if (ret == 0)
> > +		} else if (ret == 0) {
> >  			continue;
> > +		}
> 
> This is not trivial. If I understand correctly,
> for_each_available_child_of_node() will automatically release the
> reference on the previous node and take the reference on the new one
> before entering the loop code.

Yes.

> So in the skipping case, we don't need
> to release the reference as it will be done by the next iteration of
> the loop, but in the error case, since we are unexpectedly breaking the
> loop, we need to do it manually.

Correct.

> The sort of tricky thing that should be documented near
> for_each_child_of_node(), since I believe a lot of code gets this
> wrong.

Yes, lots of code gets it wrong, even the core DT code gets it wrong.
The problem will be stopping people getting it wrong in the future, now
that they've learnt the wrong way to do it - I don't think documenting
the site where for_each_child_of_node() is defined will work anymore -
how many people know of for_each_child_of_node() and don't need to look
it up, yet code exactly this bug?

TBH, the fundamental issue here is wrapping this all up in what looks
to be a harmless for_each_child_of_node() thing.  for_each_child_of_node()
has side-effects that are completely non-obvious, except to those who
have been educated about it.

I think the only solution now is to kill for_each_child_of_node() and
similar, and have people open-code the for() loop so they can _see_
what's going on, because we can't stop people from breaking out of a
for() loop.  That's a major change though, outside the scope of this
series.

I raised the issue last month with DT people, but there isn't any
interest in fixing the issue; they know about it but (iirc) have no
plans to fix it.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
