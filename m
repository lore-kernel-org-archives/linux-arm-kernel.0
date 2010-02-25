From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 24 Feb 2010 23:28:45 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <4B85C4A4.4060005@marcansoft.com>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
Message-ID: <alpine.LFD.2.00.1002242309030.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Feb 2010, Hector Martin wrote:

> Russell King - ARM Linux wrote:
> > On Thu, Feb 25, 2010 at 12:57:20AM +0100, Hector Martin wrote:
> >> Russell King - ARM Linux wrote:
> >>> On Wed, Feb 24, 2010 at 06:34:49PM -0500, Nicolas Pitre wrote:
> >>>> What about simply not compiling the decompressor with -fPIC when using 
> >>>> ZBOOT_ROM=y?  That would certainly solve the problem with the only 
> >>>> restriction that such kernel images won't be bootable from RAM which is 
> >>>> probably an acceptable compromize.
> >>> Unfortunately, that doesn't solve the stack-bashing with ZBOOT_ROM=n.
> >> Yes it does, that's exactly what my first version of the patch did. Once
> >> you get rid of the partial relocation used for ROM builds (with split
> >> text/bss) you don't need -Dstatic=, and once you get rid of that you
> >> solve the stack-bashing. The ROM build becomes a bog standard
> >> non-relocatable ROM image (with the usual LMA/VMA linker script stuff to
> >> copy initialized data to RAM), and the RAM build becomes a bog standard
> >> relocatable image (a single contiguous blob including
> >> text/rodata/data/bss) that doesn't suffer from any issues when you move
> >> it around.
> > 
> > Did you bother to read my previous reply explaining that this is not
> > a hack for the toolchain?  It sounds to me like you didn't.
> 
> Are you new to C? It looks like you are seriously still claiming that
> -Dstatic= is A-OK under all circumstances. It very obviously isn't.

I didn't see Russell make any such claim anywhere.  We're talking about 
a very particular case here.

> In your other e-mail, you're missing the point. You're arguing that
> compiler behavior regarding access to data (particularly that with
> static vs. global visibility) is well-defined enough that you can
> guarantee that GOT-relative accesses will not happen as long as you
> avoid static data. I'm still not convinced, but that's not my main point.
> 
> The problem is that -Dstatic= isn't a magical safe way of making objects
> globally visible, because the 'static' keyword in C means different
> things in different places. Specifically, it means a totally different
> thing inside functions.  [...]

Yes we all know that.

> static void zlib_fixedtables(struct inflate_state *state)
> 
> {
> 
> #   include "inffixed.h"  /* static blah {len,dist}fix[] = {...}; */
>     state->lencode = lenfix;
> 
>     state->lenbits = 9;
> 
>     state->distcode = distfix;
> 
>     state->distbits = 5;
> 
> }
> 
> Guess what happens when you remove the static keywords there.
> 
> Long story short, -Dstatic= isn't accomplishing what you want, because
> it's crude and doesn't handle all cases properly. If you want to keep
> the current model, you have to be willing to manually watch changes to
> the decompressor implementations so they do not violate your assumptions
> (i.e. never use static inside functions and rely on it, at least),
> because -Dstatic= will break valid C code. Under _all_ circumstances, no
> matter what your other compiler flags are or how you link and load
> stuff, -Dstatic= is guaranteed to break some valid C code, and that's
> what's happening here.

Obviously.  But that's the core of the argument: we made sure that the 
previous implementation didn't use any static within functions.  Why do 
you need to do that?  This is usually a bad idea anyway as this makes 
the function non reentrant.

> Sure, you could patch up the issue by moving the #include out of the
> function above, but then you'd better be willing to watch for anything
> like that anywhere in decompressor code used for ARM, because other
> kernel developers aren't going to know that ARM silently discards their
> static keywords. I'm not even sure this is the only broken code so far,
> there could be more.

Two possibilities that I can see:

Put this in a common header file for the decompressor code:

/* ARM wants to redefine this sometimes */
#ifndef static_func
#define static_func
#endif

Then declare your functions with static_func, and ARM can use 
-Dstatic_func.

Or, we give up the ability to load in RAM a ROMable zImage.

Personally I'd favor first solution.


Nicolas
