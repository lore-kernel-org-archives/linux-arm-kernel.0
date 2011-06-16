From: david@gibson.dropbear.id.au (David Gibson)
Date: Thu, 16 Jun 2011 11:43:53 +1000
Subject: [PATCH] Support multiple MEM tags with atags->fdt conversion
In-Reply-To: <alpine.LFD.2.00.1106151540230.2142@xanadu.home>
References: <1308094074-24898-1-git-send-email-davidb@codeaurora.org>
	<alpine.LFD.2.00.1106151540230.2142@xanadu.home>
Message-ID: <20110616014353.GB16214@yookeroo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 03:50:37PM -0400, Nicolas Pitre wrote:
> On Tue, 14 Jun 2011, David Brown wrote:
> 
> > Some targets have multiple memory regions.  Parse up to 8 of these
> > when converting the atags to fdt.
> > 
> > Signed-off-by: David Brown <davidb@codeaurora.org>
> 
> I've added your patch to my zImage patch queue.
> 
> > With this change, I am able to boot MSM8x60 combining ATAGS and my DT.
> > It seems to work as long as my device tree has placeholders for all of
> > the properties I need.
> 
> I think those missing nodes should simply be created if missing.  I 
> however don't see any function in the libfdt API to do that -- there is 
> fdt_add_subnode() but no fdt_add_node().  Any DT expert please?

fdt_add_subnode() will create a new node as you require.  The
"subnode" is just supposed to indicate that the parameters are in the
form of the offset of the parent node and the new node's immediate
name, rather than taking a full path name for the new node.

> Also, should the DTB be enlarged in order to add new nodes, or even 
> modify existing ones with larger properties?  In other words, 
> should something like fdt_move(fdt, fdt, fdt_totalsize(fdt)+HEADROOM) be 
> used beforehand?

Yes, you will need to do this, fdt_open_into() is the function you
want.  Without making room first, adding nodes or expanding existing
properties will return -FDT_ERR_NOSPACE.  Once you've made whatever
edits you need, you can use fdt_pack() to collapse the tree back to
its minimum size.

Although this is somewhat awkward, this approach is a deliberate
design decision, to avoid making libfdt dependent on a working general
purpose allocator, which may not be available when libfdt is used in
very limited environments such as a firmware/bootloader.

If you do find things you need to do which libfdt doesn't support, I'm
more than happy to extend it as necessary.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
