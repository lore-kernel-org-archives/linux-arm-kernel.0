From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 25 Feb 2010 14:40:43 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <4B86CDC8.4080107@marcansoft.com>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
	<4B864B4C.9020805@marcansoft.com>
	<alpine.LFD.2.00.1002251332190.1946@xanadu.home>
	<4B86CDC8.4080107@marcansoft.com>
Message-ID: <alpine.LFD.2.00.1002251428410.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2010, Hector Martin wrote:

> Nicolas Pitre wrote:
> > On Thu, 25 Feb 2010, Hector Martin wrote:
> > 
> >> If you can programmatically ensure that the decompressors do not use
> >> anything but GOT entries to access data, that's certainly a better
> >> solution than what we have now (I don't mean actually "fixing" them as
> >> in -Dstatic=, just something that makes the build fail if this is not
> >> the case so someone else can go and make the required changes). Maybe
> >> building the object and then grepping the relocations for offenders, or
> >> something like that.
> > 
> > Russell made a patch which simply ends up discarding .data section.
> 
> You still have the issue of the .bss section. Though I must admit this
> would be rare, a decompressor using the .bss section would still cause
> silent breakage.

What breakage?  We do use the .bss right now.  But .bss can be fixed to 
some absolute address in RAM with no further handling besides clearing 

I found the following at the top of arch/arm/boot/compressed/misc.c:

 * Nicolas Pitre <nico@visuaide.com>  1999/04/14 :
 *  For this code to run directly from Flash, all constant variables must
 *  be marked with 'const' and all other variables initialized at run-time
 *  only.  This way all non constant variables will end up in the bss segment,
 *  which should point to addresses in RAM and cleared to 0 on start.
 *  This allows for a much quicker boot time.

> And I'm still not convinced that compiler behavior is defined such 
> that this cannot break in the future.

Seems to me that we're relying on compiler conventions that have been 
around for decades already.  What do you expect to break?

> > You are still copying the actual decompressor code which is less optimal 
> > than what we already have.  The current solution, as I explained 
> > already, involves _zero_ copying.
> 
> The overhead of copying the decompressor is negligible. We're talking
> somewhere along the lines of 0.1% of the time spent inside the
> decompressor, worst case.

Possible.  And granted this whole scheme was elaborated in 1999 when 
CPUs were much slower and the kernel much smaller relative to the 
decompressor, etc.  But again that "just works" already, without the 
copy overhead, and the code needed to make the copy (I know it's only 4 
asm instructions), and the complexity needed to care about the actual 
decompressed kernel size, etc. etc.


Nicolas
