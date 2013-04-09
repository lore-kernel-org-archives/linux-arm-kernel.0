From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 8 Apr 2013 21:42:54 -0300
Subject: [PATCH v4 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130408171940.GA8815@obsidianresearch.com>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365419194-20871-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130408171940.GA8815@obsidianresearch.com>
Message-ID: <20130409004253.GA2258@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason

On Mon, Apr 08, 2013 at 11:19:40AM -0600, Jason Gunthorpe wrote:
> Looks OK to me, though with mbus dt bindings we'd see some more
> changes.
> 

Thanks for the review!

> Just to note on them for future:
> 
> > +	child = of_get_next_child(node, NULL);
> > +	if (!child) {
> > +		dev_err(dev, "%s has no childs\n", node->full_name);
> > +		return -EINVAL;
> > +	}
> 
> This isn't really necessary anymore, the ranges of the node itself
> should be parsed to get the window start/end. The driver should never
> need to look at the children directly..
> 

You mean the above will not be necessary in the *future*,
once we add mbus DT bindings, right?

AFAICT, it's needed for the current workaround to work.
FWIW, the whole code below the *FIXME* is part of the temporary
to-be-removed thing.

Maybe I'll add a special comment on each chunk that's meant
to be removed to avoid confusions.

> > +	/* Get the CS to choose the window string */
> > +	err = of_property_read_u32(node, "ranges", &cs);
> > +	if (err < 0)
> > +		return err;
> 
> .. and this is why you've kept the 2 cells address - the top cell is
> still encoding the target id. This would go away eventually too..
> 
> Maybe it would be better in the interm to compute the CS offset from
> the control register offset?
> 
> (reg.start % 0x400)/8 should do the trick?
> 

Yes, I'll do this and drop the 2-cell address.

> > +	devbus->child = of_platform_device_create(child, NULL, &pdev->dev);
> > +	if (!devbus->child) {
> > +		dev_warn(dev, "cannot create child device %s\n", child->name);
> > +		/* Remove the allocated window */
> > +		mvebu_mbus_del_window(devbus->child_mem.start,
> > +				      resource_size(&devbus->child_mem));
> > +	}
> 
> This can probably just be of_platform_populate or similar to do all
> children? For instance, I often use many DT nodes to represent a FPGA,
> since the my FPGA's tend to have many functionally orthogonal units
> inside.
> 

In the past I've found it's not possible to use of_platform_populate,
altough I can be wrong.

The problem seems to be that through of_platform_populate() it's
possible that the child device (cfi-flash, for instance) gets probed
before the devbus controller. In other words, the actual parent-child
relationship gets lost and it's necesarry to use some child probe deferal
mechanism.

This has been recently discussed [1] when implementing GPMC where for simplicity
the of_platform_device_create() solution was chosen.
Anyway, I'll try of_platform_populate early tomorrow.

Thanks,

[1]  http://www.mail-archive.com/linux-omap at vger.kernel.org/msg85897.html
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
