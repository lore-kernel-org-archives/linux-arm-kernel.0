From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 21:15:33 +0200
Subject: [PATCH v4 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130408171940.GA8815@obsidianresearch.com>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365419194-20871-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130408171940.GA8815@obsidianresearch.com>
Message-ID: <201304082115.33882.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Jason Gunthorpe wrote:
> > +     /* Get the CS to choose the window string */
> > +     err = of_property_read_u32(node, "ranges", &cs);
> > +     if (err < 0)
> > +             return err;
> 
> .. and this is why you've kept the 2 cells address - the top cell is
> still encoding the target id. This would go away eventually too..
> 
> Maybe it would be better in the interm to compute the CS offset from
> the control register offset?
> 
> (reg.start % 0x400)/8 should do the trick?

Yes, we came to the axact same conclusion on IRC.

> > +     devbus->child = of_platform_device_create(child, NULL, &pdev->dev);
> > +     if (!devbus->child) {
> > +             dev_warn(dev, "cannot create child device %s\n", child->name);
> > +             /* Remove the allocated window */
> > +             mvebu_mbus_del_window(devbus->child_mem.start,
> > +                                   resource_size(&devbus->child_mem));
> > +     }
> 
> This can probably just be of_platform_populate or similar to do all
> children? For instance, I often use many DT nodes to represent a FPGA,
> since the my FPGA's tend to have many functionally orthogonal units
> inside.

Good idea, yes.

	Arnd
