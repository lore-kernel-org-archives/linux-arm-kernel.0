From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 21 Aug 2011 15:53:57 -0400 (EDT)
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting DEBUG_LL
	UART
In-Reply-To: <20110821191835.GA19678@n2100.arm.linux.org.uk>
References: <20110818160712.GA26691@e102144-lin.cambridge.arm.com>
	<20110819045956.GB12527@S2100-06.ap.freescale.net>
	<20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1108211522280.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:

> On Sun, Aug 21, 2011 at 03:02:25PM -0400, Nicolas Pitre wrote:
> > Obviously the way to go is to use a .data variable.
> > 
> > And it can be referenced from assembly code in a position independent 
> > manner:
> > 
> >         .macro  get_ptr_pic, ptr, symbol
> >         b       199f
> >         .align
> > 198:    .long   .
> >         .long   \symbol
> > 199:    adr     \ptr, 198b              @ get relative address of 198b
> >         ldr     ip, [\ptr]              @ get absolute address of 198b
> >         sub     ip, ip, \ptr            @ offset between abs and rel
> >         ldr     \ptr, [\ptr, #4]        @ absolute address of \symbol
> >         sub     \ptr, \ptr, ip          @ make it relative
> >         .endm
> 
> And have you checked that you can crap over 'ip' in the early assembly
> code?  There are some (small) places where that register is used, which
> means you accidentally corrupt that register.

You are down to details now.  I'm still trying to validate concepts.  
Implementation details such this can be sorted out trivially later.

> > > This is just getting _idiotic_.  There are times when "no" is the word
> > > which has to be used, and this is one of them.
> > 
> > You are saying "no" to the possibility of getting rid of the zImage 
> > decompressor serial output.
> >
> > And now you're saying "no" to any possibility of keeping it alive in the 
> > context of a multi-SOC kernel.
> 
> The decompressor has nothing to do with this.

Sure it does, since it relies on early serial output capabilities, just 
like earlyprintk, or possibly even the senduart code.  Solving this once 
for them all, *appropriately*, would certainly be nice.  I would be glad 
to see this need addressed without making further ugly abuses like the 
OMAP people did with their OMAP_UART_INFO and the 
arch/arm/plat-omap/include/plat/uncompress.h abomination.

> > Are you also saying "no" to the multi-SOC kernel?  If so you'll have to 
> > convince many more people than just me.
> 
> No, I am saying no to the low level debugging code which *developers*
> rely upon working being fucked up and rendered useless - and so requiring
> a new implementation to be written - in the name of multi-SoC support.
> That is what I'm *strongly* objecting to.

I really don't mind leaving that code well alone actually.

We can well work something out for earlyprintk and zImage needs first, 
see how it works, get some confidence in it, and then if that appears to 
be a worthwhile thing to do then _maybe_ a version of the DEBUG_LL code 
could be implemented in terms of it.

In the meantime, if CONFIG_DEBUG_LL is really really meant to be _only_ 
for early assembly debugging by seasoned developers then I don't think 
that expanding its configurability through a Kconfig menu is a good 
thing.  Instead, it should probably be _removed_ from Kconfig entirely.


Nicolas
