From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 10 Apr 2013 10:57:50 -0600
Subject: [PATCH v6 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130410101956.GA2250@localhost>
References: <1365539181-29242-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365539181-29242-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130409203855.GA27797@obsidianresearch.com>
 <20130410101956.GA2250@localhost>
Message-ID: <20130410165750.GA6441@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 07:19:57AM -0300, Ezequiel Garcia wrote:
> Hi Jason,
> 
> On Tue, Apr 09, 2013 at 02:38:55PM -0600, Jason Gunthorpe wrote:
> > On Tue, Apr 09, 2013 at 05:26:17PM -0300, Ezequiel Garcia wrote:
> > > +	/*
> > > +	 * Since this is only part of the workaround,
> > > +	 * we can do this dirty 'ranges' property parsing.
> > > +	 * Of course, this will be removed once the address windows
> > > +	 * are declared in the device tree.
> > > +	 */
> > > +	err = of_property_read_u32_array(node, "ranges", addr_region,
> > > +					 ARRAY_SIZE(addr_region));
> > 
> > Oh, this is a dangerous way to parse ranges.. 
> > 
> > Try something like:
> > 
> > const __be32 *prop;
> > u64 base;
> > u64 size;
> > 
> > prop = of_get_property("ranges",&psize);
> > if (prop == NULL || psize != of_n_addr_cells(node) + of_n_size_cells(node))
> >    err;
> > base = of_translate_address(node,prop);
> > if (base == OF_BAD_ADDR)
> >    err;
> > size = of_read_number(prop + of_n_addr_cells(node),of_n_size_cells(node));
> > 
> 
> Thanks for giving me these hints!

NP, the motivation for doing this properly is to support cases where
p_addr_cells/addr_cells/size_cells is != 1, and to support cases where
the parent bus address is not the CPU address. The proposed bindings
for mbus will exercise both of these conditions..

> Following your suggestion, here's a working piece of the ranges parsing code,
> how does this look?
> 
> const __be32 *ranges;
> int addr_cells, p_addr_cells, size_cells;
> int ranges_len, tuple_len;
> u32 base, size;
> 
> p_addr_cells = of_n_addr_cells(node->parent);

I wonder if of_get_parent / of_node_put is technically needed here?

> addr_cells = of_n_addr_cells(node);
> size_cells = of_n_size_cells(node);
> tuple_len = (p_addr_cells + addr_cells + size_cells) * sizeof(__be32);
> 
> ranges = of_get_property(node, "ranges", &ranges_len);
> if (ranges == NULL || ranges_len != tuple_len)
> 	return -EINVAL;
> 
> base = of_translate_address(node, ranges + addr_cells);
> if (base == 0 || base == OF_BAD_ADDR)
> 	return -EINVAL;

Why the check for base == 0?

> size = of_read_number(ranges + addr_cells + p_addr_cells, size_cells);

Everything basically looks right. I definitely forgot the include the
p_addr in my quick sample.

Jason
