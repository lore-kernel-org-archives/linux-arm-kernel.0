From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 8 Mar 2013 22:46:38 +0000
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130308200550.GD29435@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303081942.27233.arnd@arndb.de>
 <20130308200550.GD29435@obsidianresearch.com>
Message-ID: <201303082246.38910.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 March 2013, Jason Gunthorpe wrote:
> 
> On Fri, Mar 08, 2013 at 07:42:27PM +0000, Arnd Bergmann wrote:
> > > An absent ranges makes some sense from a spec perspective - however do we
> > > have the kernel infrastructure to grow an in memory DTB node?
> > 
> > I don't think it's necessary to amend the flattened DT in the DTB form,
> > although that could be done if necessary. Once we have the live DT data
> > structures, after calling unflatten_device_tree(), we can trivially call
> > of_add_property() to add the ranges.
> 
> Oh, I've never looked at those APIs, that makes it pretty nice,
> indeed. With those it would be easy to keep the in-memory DT in sync.
> 
> The only other problem with absent ranges is how do you learn the
> target id and size to do the assignment?

You just need to look at all "reg" properties of direct children
that are not status="disabled". Those properties are already in 
the 64-bit address space co ntaining the target ID, and they have
the size in them, at least for those where the size is known at
boot time, probably all but PCIe, which can get the rest.

The algorithm should probably be similar to what we do for PCI
resource assignment: collect all resources we need, sort them
by size, and fill the logical bus address space starting with
the largest one so we don't leave holes.

	Arnd
