From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 20:22:42 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <20110821191835.GA19678@n2100.arm.linux.org.uk>
References: <20110819045956.GB12527@S2100-06.ap.freescale.net>
	<20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
Message-ID: <20110821192242.GB19678@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 08:18:35PM +0100, Russell King - ARM Linux wrote:
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

And further to this, I'll point out that the debugging functions are
*explicitly* designed to avoid corrupting any more than just r0-r3
and lr.  That's not just the IO functions but also the hex and string
printing functions.

And the head*.S code is explicitly written to expect r0-r3 to be
corrupted - which basically means that no long-term values are held in
those registers.
