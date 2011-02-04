From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 04 Feb 2011 15:16:00 -0500 (EST)
Subject: [PATCH 3/5] omap: Add support for CONFIG_AUTO_ZRELADDR for
	DEBUG_LL
In-Reply-To: <20110204170249.GV3322@atomide.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
	<20110204012709.26410.78100.stgit@baageli.muru.com>
	<alpine.LFD.2.00.1102032205140.12104@xanadu.home>
	<20110204170249.GV3322@atomide.com>
Message-ID: <alpine.LFD.2.00.1102041445360.12104@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Feb 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [110203 19:32]:
> > On Thu, 3 Feb 2011, Tony Lindgren wrote:
> > 
> > > This way we can have the debug-macro.S be common for omap1 and omap2+
> > > and get sensible error messages booting the wrong zImage with
> > > CONFIG_AUTO_ZRELADDR selected. Note that this does not seem to work
> > > with u-boot and uImage.
> ...
>  
> > Gaaaaah!  This is horrible.
> 
> -ENOREGISTERS :)
>  
> > OK, you do want to store data in memory, right?  So the best way to 
> > always be position independent, even cross section, is to do the 
> > following (inspired by RMK's trick in the p2v series):
> > 
> > 	.data
> > 
> > foo:	.word	0	@ value for sput
> > 	.word	0	@ value for nik
> > 
> > 	.text
> > 
> > bar:	.word	.
> > 	.word	foo
> > 
> > sputnik:
> > 
> > 	adr	r0, bar		@ get relative address of bar
> > 	ldr	r1, [r0]	@ get absolute address of bar
> > 	sub	r1, r1, r0	@ difference between abs and rel address
> > 	ldr	r0, [r0, #4]	@ get absolute address of foo
> > 	sub	r0, r0, r1	@ turn that into a relative address
> > 
> > 	ldmia	r0, {r1, r2}	@ retrieve sput and nik
> > 	add	r0, r1, r2
> > 	mov	pc, lr
> > 
> > This code is totally position independent, so it works whether or not 
> > the MMU is active.  Therefore a similar technique in your macro (you 
> > could even put it into a macro for it) would allow you to get rid of the 
> > mrc and test for MMU active, get rid of the #ifdef, and not be limited 
> > to a 128 MB mask, etc.  And it is just one word longer than your 
> > shortest version i.e. 2 constants + 5 instructions vs 4 instructions + 2 
> > literal pool entries.
> 
> I think if we keep the address of the memory location in rx instead of
> the port address value, then this could be done.
> 
> That would limit all the trickery to inituart only. Then addruart and
> busyuart could just do ldr from the memory location to get the port
> data without any trickery.

Just create a get_config_ptr macro or similar and the trickery will be 
nicely encapsulated.  You'd have:

	.macro get_config_ptr ptr, tmp
	b	9002f
	.align
9001:	.long	.
	.long	uart_param_storage
9002:	adr	\ptr, 9001b
	ldr	\tmp, [\ptr]
	sub	\tmp, \tmp, \ptr
	ldr	\ptr, [\ptr, #4]
	sub	\ptr, \ptr, \tmp
	.endm

	.macro addruart rp, rv
	get_config_ptr \rv
	ldr	\rp, [\rv]
	ldr	\rv, [\rv, #4]
	.endm

And for the other macros, you get the hardware address to use already, 
but you can still use get_config_ptr for extra config values you 
need if necessary.

> In that case the mapping of IO space for the serial port in head.S
> would have to be changed as that relies on rx containing the port
> IO address..

Yes, and I'm not sure if it is worth changing that at this point when it 
is possible to do it without introducing such a change which would 
affect all machines again.


Nicolas
