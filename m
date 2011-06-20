From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 20 Jun 2011 00:03:21 -0400 (EDT)
Subject: [PATCH] Support multiple MEM tags with atags->fdt conversion
In-Reply-To: <20110616014353.GB16214@yookeroo.fritz.box>
References: <1308094074-24898-1-git-send-email-davidb@codeaurora.org>
	<alpine.LFD.2.00.1106151540230.2142@xanadu.home>
	<20110616014353.GB16214@yookeroo.fritz.box>
Message-ID: <alpine.LFD.2.00.1106192340510.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jun 2011, David Gibson wrote:

> On Wed, Jun 15, 2011 at 03:50:37PM -0400, Nicolas Pitre wrote:
> > On Tue, 14 Jun 2011, David Brown wrote:
> > 
> > > Some targets have multiple memory regions.  Parse up to 8 of these
> > > when converting the atags to fdt.
> > > 
> > > Signed-off-by: David Brown <davidb@codeaurora.org>
> > 
> > I've added your patch to my zImage patch queue.
> > 
> > > With this change, I am able to boot MSM8x60 combining ATAGS and my DT.
> > > It seems to work as long as my device tree has placeholders for all of
> > > the properties I need.
> > 
> > I think those missing nodes should simply be created if missing.  I 
> > however don't see any function in the libfdt API to do that -- there is 
> > fdt_add_subnode() but no fdt_add_node().  Any DT expert please?
> 
> fdt_add_subnode() will create a new node as you require.  The
> "subnode" is just supposed to indicate that the parameters are in the
> form of the offset of the parent node and the new node's immediate
> name, rather than taking a full path name for the new node.

Sure... but I'm still a total nincompoop with regard to FDT.

Let's suppose I do:

	offset = fdt_path_offset(fdt, "/memory");

but that returns -FDT_ERR_NOTFOUND.  Now what?

If I look at the documentation for fdt_add_subnode():

/**
 * fdt_add_subnode - creates a new node
 * @fdt: pointer to the device tree blob
 * @parentoffset: structure block offset of a node
 * @name: name of the subnode to locate
 * [...]

I have no node offset, and can't find the offset for the parent of an 
nonexistent node.  Should I use 0 for parentoffset here?  I'm guessing 
that "/memory" is at the top level so there is just no parent.

> > Also, should the DTB be enlarged in order to add new nodes, or even 
> > modify existing ones with larger properties?  In other words, 
> > should something like fdt_move(fdt, fdt, fdt_totalsize(fdt)+HEADROOM) be 
> > used beforehand?
> 
> Yes, you will need to do this, fdt_open_into() is the function you
> want.  Without making room first, adding nodes or expanding existing
> properties will return -FDT_ERR_NOSPACE.  Once you've made whatever
> edits you need, you can use fdt_pack() to collapse the tree back to
> its minimum size.

Excellent!

FRom a quick code inspection, fdt_open_into() appears to be fine with 
both the source and destination pointers being the same, right?

> Although this is somewhat awkward, this approach is a deliberate
> design decision, to avoid making libfdt dependent on a working general
> purpose allocator, which may not be available when libfdt is used in
> very limited environments such as a firmware/bootloader.

This is perfect.  The environment where I want to use this code is 
fairly limited indeed.


Nicolas
