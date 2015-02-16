From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 16 Feb 2015 22:06:16 +0100
Subject: Extending the Marvell MBus DT binding to create remappable windows
In-Reply-To: <2408656.9iljAudXvL@wuerfel>
References: <20150216182805.529a0071@free-electrons.com>
 <2546568.bLP37K1160@wuerfel>
 <20150216214039.789560f7@free-electrons.com>
 <2408656.9iljAudXvL@wuerfel>
Message-ID: <20150216220616.626d26e0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 16 Feb 2015 21:54:38 +0100, Arnd Bergmann wrote:

> > I am not sure what this "offset within the window" is supposed to mean.
> > Ezequiel, any idea?
> 
> I think it means exactly what we need.

Well, I don't really understand the "remap" mechanism as an "offset
within the window". The "remap" thing is apparently to make the target
device believe that the memory access is not done at 0xe80000012 (which
is offset 0x12 from the window base address 0xe8000000 as visible on
the CPU side), but really at address 0x10012 (because this window is
configured with a remap address of 0x10000).


> >                 /*
> >                  * An entry with a non-zero custom field do not
> >                  * correspond to a static window, so skip it.
> >                  */
> >                 windowid = of_read_number(r, 1);
> >                 if (CUSTOM(windowid))
> >                         continue;
> > 
> >                 target = TARGET(windowid);
> >                 attr = ATTR(windowid);
> > 
> >                 base = of_read_number(r + c_addr_cells, addr_cells);
> >                 size = of_read_number(r + c_addr_cells + addr_cells,
> >                                       c_size_cells);
> >                 ret = mbus_dt_setup_win(mbus, base, size, target, attr);
> >                 if (ret < 0)
> >                         return ret;
> >         }
> >         return 0;
> > }
> 
> Hmm, I have no idea what that comment and the 'continue' line are
> about.

This I know: we have a "fake" window entry, for the internal registers.
They are described like a MBus window in the DT, with a fake target ID
and attribute, which we handle specially here.

> > And finally, with a "0" value in 'b' as you suggest, you have no idea
> > whether it means:
> > 
> >  * That you want a remap address to be set to 0.
> > 
> >  * Or that you don't want any remap address.
> > 
> > This difference is quite important, because out of the 20 windows
> > available, 9 of them are remappable windows, and 11 are not remappable.
> > So you don't want to use windows that have the remap capability for no
> > reason.
> >
> > Or, we should make b == c to indicate that the CPU side address and the
> > MBus local address are the same, and in this case, it indicates that we
> > don't want the remap capability to be enabled for this window. However,
> > if b != c, then we need to enable the remapping capability.
> 
> I suspect we made a mistake with the implementation here if an offset
> of zero is defined to mean an identity mapping within the window.

I'm sorry but I don't parse this sentence :-/

> That would be very unfortunate. Back when the driver was introduced,
> I only reviewed the binding in detail and it all made sense, but it
> seems that the driver does not actually implement the binding if
> I understand you correctly.

I have no problem adjusting the driver implementation, I just need to
understand the binding a bit better. Is my proposal using b == c and
b != c to detect if we need the remap capability the right solution?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
