From: david@gibson.dropbear.id.au (David Gibson)
Date: Tue, 30 Jul 2013 08:29:20 +1000
Subject: [Ksummit-2013-discuss] Defining schemas for Device Tree
In-Reply-To: <20130729172339.GT29916@titan.lakedaemon.net>
References: <2469263.vMN09Q7Tzi@flatron>
 <20130729150124.GS29916@titan.lakedaemon.net>
 <20130729164905.GB2280@localhost.localdomain>
 <20130729172339.GT29916@titan.lakedaemon.net>
Message-ID: <20130729222920.GF29970@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 01:23:39PM -0400, Jason Cooper wrote:
> On Mon, Jul 29, 2013 at 05:49:05PM +0100, Dave Martin wrote:
> > On Mon, Jul 29, 2013 at 11:01:24AM -0400, Jason Cooper wrote:
> > > On Mon, Jul 29, 2013 at 02:21:52AM +0200, Tomasz Figa wrote:
> 
> > > > b) What information should be specified in schemas? What level of 
> > > >    granularity is required?
> > > 
> > > One item I don't see in this list is node ordering.  There's been some
> > > discussion lately on deferred probing (re boot times).  If we were to
> > > intentionally declare that DT are parsed in the order written, then a
> > > lot of deferred probes could be avoided by moving eg the pinctrl node to
> > > near the top of the tree.
> > > 
> > > This doesn't impact buses as much, since the nodes needing the bus are
> > > already children.  However, anything accessed via phandles: pins,
> > > clocks, regulators, etc could benefit from declaring and enforcing this.
> > > Eg having the dtc warn when a phandle is used before it's corresponding
> > > node is declared.
> > > 
> > > Not critical though, just a thought.
> > 
> > I don't think that siblings have any defined order in DT.  If reading a
> > device tree, there's no guarantee you get nodes or properties out in the
> > same order as the original .dts file.
> 
> That's why I raised the point.  If people think encoding initialization
> order in the DT is a good idea, then we should change the dtc so it
> compiles/decompiles in the same order.

I've always considered the DT to be unordered, although the flattened
representation obviously has to have some order.  It is much safer to
explicitly represent any required orderings with properties, rather
than to rely on the flattened tree order.  I really don't think trying
to have dtc magically understand device initialization ordering in
this way is a good idea.

Fwiw, dtc generally preserves order between input and output, with the
exception of the -s option, which sorts the subnodes of each node by
name (useful for dtdiff).

> > Provided child/parent relationships are maintained and the set of nodes
> > and values is the same, I think completely rearranging a .dts file does
> > not change its meaning.
> > 
> > "depends-on" relationships mostly have to come from the semantics of
> > the bindings themselves: for example, if a device is connected to some
> > clocks and regulators, the kernel may need to probe those first.
> 
> true, the answer to this problem may be to create a depgraph of the
> nodes based on phandles and child status, then init.  However, if the
> goal is to accelerate boot times, then that should not be calculated
> during each boot, especially since it doesn't likely change from boot to
> boot.
> 
> Which means it would either go in the dtc (dts node ordering is
> irrelevant), or in the dts.  I'm inclined to say dtc should do it, but I
> like the aesthetics of things being in the proper order in something I
> can read.  After all, C requires functions to be declared before use,
> even though the compiler could figure it out.

It's not necessarily possible to encode device initialization order in
flattened tree order.  Suppose you have bus A with devices A1 and A2,
and bus B with devices B1 and B2.  A1 must be initialized before B1,
but B2 must be initialized before A2.  There are no loops there, it's
a valid set of initialization order constraints, but you can't get
both of them right in the flat tree ordering.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/c63ed571/attachment.sig>
