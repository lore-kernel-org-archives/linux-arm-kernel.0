From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 9 Apr 2013 17:49:47 -0300
Subject: [PATCH v6 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130409203855.GA27797@obsidianresearch.com>
References: <1365539181-29242-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365539181-29242-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130409203855.GA27797@obsidianresearch.com>
Message-ID: <20130409204946.GA2294@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 02:38:55PM -0600, Jason Gunthorpe wrote:
> On Tue, Apr 09, 2013 at 05:26:17PM -0300, Ezequiel Garcia wrote:
> > +	/*
> > +	 * Since this is only part of the workaround,
> > +	 * we can do this dirty 'ranges' property parsing.
> > +	 * Of course, this will be removed once the address windows
> > +	 * are declared in the device tree.
> > +	 */
> > +	err = of_property_read_u32_array(node, "ranges", addr_region,
> > +					 ARRAY_SIZE(addr_region));
> > +	if (err < 0) {
> > +		dev_err(dev, "%s has a malformed 'range' property\n",
> > +			node->full_name);
> > +		return err;
> > +	}
> 
> > +	/*
> > +	 * Create an mbus address windows.
> > +	 * FIXME: Remove this, together with the above code, once the
> > +	 * address windows are declared in the device tree.
> > +	 */
> > +	err = mvebu_mbus_add_window(devbus_wins[cs],
> > +				    addr_region[1], addr_region[2]);
> 
> Oh, this is a dangerous way to parse ranges.. 
> 
> Try something like:
> 
> const __be32 *prop;
> u64 base;
> u64 size;
> 
> prop = of_get_property("ranges",&psize);
> if (prop == NULL || psize != of_n_addr_cells(node) + of_n_size_cells(node))
>    err;
> base = of_translate_address(node,prop);
> if (base == OF_BAD_ADDR)
>    err;
> size = of_read_number(prop + of_n_addr_cells(node),of_n_size_cells(node));
> 
> err = mvebu_mbus_add_window(devbus_wins[cs],base,size);
>

No problem, I'll try something like the above.

Mind explaining me why do you think it's dangerous
or in what cases do you expect the other (dirty) solution to break?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
