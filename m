From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 8 Apr 2013 11:19:40 -0600
Subject: [PATCH v4 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <1365419194-20871-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365419194-20871-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130408171940.GA8815@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks OK to me, though with mbus dt bindings we'd see some more
changes.

Just to note on them for future:

> +	child = of_get_next_child(node, NULL);
> +	if (!child) {
> +		dev_err(dev, "%s has no childs\n", node->full_name);
> +		return -EINVAL;
> +	}

This isn't really necessary anymore, the ranges of the node itself
should be parsed to get the window start/end. The driver should never
need to look at the children directly..

> +	/* Get the CS to choose the window string */
> +	err = of_property_read_u32(node, "ranges", &cs);
> +	if (err < 0)
> +		return err;

.. and this is why you've kept the 2 cells address - the top cell is
still encoding the target id. This would go away eventually too..

Maybe it would be better in the interm to compute the CS offset from
the control register offset?

(reg.start % 0x400)/8 should do the trick?

> +	devbus->child = of_platform_device_create(child, NULL, &pdev->dev);
> +	if (!devbus->child) {
> +		dev_warn(dev, "cannot create child device %s\n", child->name);
> +		/* Remove the allocated window */
> +		mvebu_mbus_del_window(devbus->child_mem.start,
> +				      resource_size(&devbus->child_mem));
> +	}

This can probably just be of_platform_populate or similar to do all
children? For instance, I often use many DT nodes to represent a FPGA,
since the my FPGA's tend to have many functionally orthogonal units
inside.

Regards,
Jason
