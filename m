From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Feb 2015 21:54:38 +0100
Subject: Extending the Marvell MBus DT binding to create remappable windows
In-Reply-To: <20150216214039.789560f7@free-electrons.com>
References: <20150216182805.529a0071@free-electrons.com>
 <2546568.bLP37K1160@wuerfel> <20150216214039.789560f7@free-electrons.com>
Message-ID: <2408656.9iljAudXvL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 February 2015 21:40:39 Thomas Petazzoni wrote:
> On Mon, 16 Feb 2015 21:05:52 +0100, Arnd Bergmann wrote:
> 
> > Looking at for example arch/arm/boot/dts/armada-xp-netgear-rn2120.dts,
> > I find the following mbus ranges
> > 
> >             ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
> >                       MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
> >                          ^                ^ ^     ^         ^
> >                          a                b c     c         d
> > 
> > and here the table should get set up from the fields like
> > 
> > a) mbus target (32 bit)
> > b) mbus-local address (32 bit)
> > c) cpu-physical address (64 bit)
> > d) window size
> > 
> > with the registers from the spec, this seems to map to
> > 
> > a) 0x00020000
> > b) 0x00020008
> > c) 0x00020004
> > d) 0x00020000
> > 
> > so you just need to put the remap-address into the second cell and ensure
> > that it is correctly evaluated by the driver.
> > 
> > Did you miss that part of the binding, or did I miss what you are
> > trying to say?
> 
> Well what you are saying here does not really match exactly what the
> binding document is saying. From
> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/bus/mvebu-mbus.txt#L77:
> 
>  77 ** MBus address decoding window specification
>  78 
>  79 The MBus children address space is comprised of two cells: the first one for
>  80 the window ID and the second one for the offset within the window.
>  81 In order to allow to describe valid and non-valid window entries, the
>  82 following encoding is used:
>  83 
>  84   0xSIAA0000 0x00oooooo
> 
> I am not sure what this "offset within the window" is supposed to mean.
> Ezequiel, any idea?

I think it means exactly what we need.

> In addition, the current implementation of the mvebu-mbus driver
> considers that all windows described in the DT ranges property are
> non-remappable windows:
> 
> static int __init mbus_dt_setup(struct mvebu_mbus_state *mbus,
>                                 struct device_node *np)
> {
>         int addr_cells, c_addr_cells, c_size_cells;
>         int i, ret, cell_count;
>         const __be32 *r, *ranges_start, *ranges_end;
> 
>         ret = mbus_parse_ranges(np, &addr_cells, &c_addr_cells,
>                                 &c_size_cells, &cell_count,
>                                 &ranges_start, &ranges_end);
>         if (ret < 0)
>                 return ret;
> 
>         for (i = 0, r = ranges_start; r < ranges_end; r += cell_count, i++) {
>                 u32 windowid, base, size;
>                 u8 target, attr;
> 
>                 /*
>                  * An entry with a non-zero custom field do not
>                  * correspond to a static window, so skip it.
>                  */
>                 windowid = of_read_number(r, 1);
>                 if (CUSTOM(windowid))
>                         continue;
> 
>                 target = TARGET(windowid);
>                 attr = ATTR(windowid);
> 
>                 base = of_read_number(r + c_addr_cells, addr_cells);
>                 size = of_read_number(r + c_addr_cells + addr_cells,
>                                       c_size_cells);
>                 ret = mbus_dt_setup_win(mbus, base, size, target, attr);
>                 if (ret < 0)
>                         return ret;
>         }
>         return 0;
> }

Hmm, I have no idea what that comment and the 'continue' line are
about.

> And finally, with a "0" value in 'b' as you suggest, you have no idea
> whether it means:
> 
>  * That you want a remap address to be set to 0.
> 
>  * Or that you don't want any remap address.
> 
> This difference is quite important, because out of the 20 windows
> available, 9 of them are remappable windows, and 11 are not remappable.
> So you don't want to use windows that have the remap capability for no
> reason.
>
> Or, we should make b == c to indicate that the CPU side address and the
> MBus local address are the same, and in this case, it indicates that we
> don't want the remap capability to be enabled for this window. However,
> if b != c, then we need to enable the remapping capability.

I suspect we made a mistake with the implementation here if an offset
of zero is defined to mean an identity mapping within the window.
That would be very unfortunate. Back when the driver was introduced,
I only reviewed the binding in detail and it all made sense, but it
seems that the driver does not actually implement the binding if
I understand you correctly.

> Notice also that the remap address can be a 64 bits address, even
> though I don't really understand in which scenarios this is used.

In order to support that, we'd have to use #address-cells=<3>, but
that would be a logical extension if we ever need it.

	Arnd
