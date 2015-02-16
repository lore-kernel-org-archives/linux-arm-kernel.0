From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Feb 2015 22:39:05 +0100
Subject: Extending the Marvell MBus DT binding to create remappable windows
In-Reply-To: <20150216220616.626d26e0@free-electrons.com>
References: <20150216182805.529a0071@free-electrons.com>
 <2408656.9iljAudXvL@wuerfel> <20150216220616.626d26e0@free-electrons.com>
Message-ID: <5587493.9jDdgHIN6B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 February 2015 22:06:16 Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Mon, 16 Feb 2015 21:54:38 +0100, Arnd Bergmann wrote:
> 
> > > I am not sure what this "offset within the window" is supposed to mean.
> > > Ezequiel, any idea?
> > 
> > I think it means exactly what we need.
> 
> Well, I don't really understand the "remap" mechanism as an "offset
> within the window". The "remap" thing is apparently to make the target
> device believe that the memory access is not done at 0xe80000012 (which
> is offset 0x12 from the window base address 0xe8000000 as visible on
> the CPU side), but really at address 0x10012 (because this window is
> configured with a remap address of 0x10000).

Then I think it's just a case of mismatched terminology: The way I read
the binding, each entry in the 'ranges' property defines one mbus window
that directly corresponds to set of registers in the mbus controller.

The way that the 'ranges' property works is to define a window from
the parent bus address space to the child address space, using a triplet
of <child address> <parent address> <size>. Both child and parent are
64-bit addresses here. The parent address is in the CPU space, and is
64-bit wide because the CPU may use LPAE, while the child address
uses the upper bits to identify one of many mbus-internal address
spaces and the lower bits to identify the offset within that address
space.

Doing the access to 0xe80000012 means we look up the address window
in the mbus ranges (or in the hardware registers, which are equivalent)
and find an entry that defines

	ranges = <MBUS_ID(0xab, 0xcd) 0x10000   0 0xe8000000  0x10000>;

The address 0xe80000012 is within the range 0xe8000000-0xe8010000, so
we match that address to this entry. We subtract the start CPU address
and add the start mbus address and get

	0xe8000012 - 0x00000000.e8000000 + 0xabcd0000.00010000
	= 0xabcd0000.00010012

which is offset 0x10012 into the mbus device identified as <MBUS_ID(0xab, 0xcd)>

Does that way of looking at it make it clearer?

> > >                 /*
> > >                  * An entry with a non-zero custom field do not
> > >                  * correspond to a static window, so skip it.
> > >                  */
> > >                 windowid = of_read_number(r, 1);
> > >                 if (CUSTOM(windowid))
> > >                         continue;
> > > 
> > >                 target = TARGET(windowid);
> > >                 attr = ATTR(windowid);
> > > 
> > >                 base = of_read_number(r + c_addr_cells, addr_cells);
> > >                 size = of_read_number(r + c_addr_cells + addr_cells,
> > >                                       c_size_cells);
> > >                 ret = mbus_dt_setup_win(mbus, base, size, target, attr);
> > >                 if (ret < 0)
> > >                         return ret;
> > >         }
> > >         return 0;
> > > }
> > 
> > Hmm, I have no idea what that comment and the 'continue' line are
> > about.
> 
> This I know: we have a "fake" window entry, for the internal registers.
> They are described like a MBus window in the DT, with a fake target ID
> and attribute, which we handle specially here.

We should probably change the code to match on the fake window entry
instead of the offset then.

> > > And finally, with a "0" value in 'b' as you suggest, you have no idea
> > > whether it means:
> > > 
> > >  * That you want a remap address to be set to 0.
> > > 
> > >  * Or that you don't want any remap address.
> > > 
> > > This difference is quite important, because out of the 20 windows
> > > available, 9 of them are remappable windows, and 11 are not remappable.
> > > So you don't want to use windows that have the remap capability for no
> > > reason.
> > >
> > > Or, we should make b == c to indicate that the CPU side address and the
> > > MBus local address are the same, and in this case, it indicates that we
> > > don't want the remap capability to be enabled for this window. However,
> > > if b != c, then we need to enable the remapping capability.
> > 
> > I suspect we made a mistake with the implementation here if an offset
> > of zero is defined to mean an identity mapping within the window.
> 
> I'm sorry but I don't parse this sentence :-/
> 
> > That would be very unfortunate. Back when the driver was introduced,
> > I only reviewed the binding in detail and it all made sense, but it
> > seems that the driver does not actually implement the binding if
> > I understand you correctly.
> 
> I have no problem adjusting the driver implementation, I just need to
> understand the binding a bit better. Is my proposal using b == c and
> b != c to detect if we need the remap capability the right solution?

It really depends on what address the devices see for a non-remapped
address. If the device is always mapped at offset zero within the mbus
window for non-remapped addresses, we are fine with the existing
implementation and can just check for b==0 to set up a non-remapping
window. If however the device actually has its registers at the same
address that the CPU sees, then we need to check for b==c but find a
way to convert all the existing DT files while providing backwards
compatibility.

	Arnd
