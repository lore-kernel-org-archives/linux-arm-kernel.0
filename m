From: david.jander@protonic.nl (David Jander)
Date: Tue, 11 Sep 2012 10:49:25 +0200
Subject: GCC 4.6.x miscompiling arm-linux?
In-Reply-To: <20558.61974.299424.536837@pilspetsen.it.uu.se>
References: <20120910171654.1d4972b2@archvile>
 <w51bohddcqw.fsf@mail.mattleach.net>
 <20120911092753.7b8315d4@archvile>
 <20558.61974.299424.536837@pilspetsen.it.uu.se>
Message-ID: <20120911104925.3461603e@archvile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dear Mikael,

On Tue, 11 Sep 2012 10:11:02 +0200
Mikael Pettersson <mikpe@it.uu.se> wrote:

> David Jander writes:
>  > 
>  > Hi Matt,
>  > 
>  > On Mon, 10 Sep 2012 18:11:19 +0100
>  > Matthew Leach <matthew@mattleach.net> wrote:
>  > > David Jander <david.jander@protonic.nl> writes:
>  > > > ...
>  > > > 	.text
>  > > > 	.align	2
>  > > > 	.global	flexcan_chip_start
>  > > > 	.type	flexcan_chip_start, %function
>  > > > flexcan_chip_start:
>  > > > 	@ args = 0, pretend = 0, frame = 0
>  > > > 	@ frame_needed = 0, uses_anonymous_args = 0
>  > > > 	@ link register save eliminated.
>  > > > 	mov	r3, #0
>  > > > 	cmp	r0, #9
>  > > > 	str	r3, [r1, #0]
>  > > > 	ldrle	r3, [r1, #4]
>  > > > 	mov	r0, #0
>  > > > 	str	r3, [r1, #4]
>  > > > 	bx	lr
>  > > > 	.size	flexcan_chip_start, .-flexcan_chip_start
>  > > > 	.ident	"GCC: (OSELAS.Toolchain-2011.11.1) 4.6.2"
>  > > > 	.section	.note.GNU-stack,"",%progbits
>  > > >
>  > > 
>  > > This does indeed look wrong. I had a go at compile your code snippet the
>  > > following assembly was produced:
>  > > 
>  > >         .text
>  > >         .align  2
>  > >         .global flexcan_chip_start
>  > >         .type   flexcan_chip_start, %function
>  > > flexcan_chip_start:
>  > >         @ Function supports interworking.
>  > >         @ args = 0, pretend = 0, frame = 0
>  > >         @ frame_needed = 0, uses_anonymous_args = 0
>  > >         @ link register save eliminated.
>  > >         cmp     r0, #9
>  > >         mov     r3, #0
>  > >         str     r3, [r1, #0]
>  > >         mov     r0, #0
>  > >         strgt   r3, [r1, #4]
>  > >         bx      lr
>  > >         .size   flexcan_chip_start, .-flexcan_chip_start
>  > >         .ident  "GCC: (GNU) 4.3.3"
>  > >         .section        .note.GNU-stack,"",%progbits
>  > > 
>  > > I think this looks correct. Perhaps you could try the angstrom arm5te
>  > > toolchain and see if it's a toolchain issue?
>  > 
>  > Yes, this looks a lot better, and is exactly what I get when I compile this
>  > code with CodeSourcery GCC-4.4.1
>  > 
>  > I have tries building gcc-4.6.3 also with OSELAS/PTXdist, and it gives the
>  > same (wrong) result as with gcc-4.6.2
>  > 
>  > > I think this looks correct. Perhaps you could try the angstrom arm5te
>  > > toolchain and see if it's a toolchain issue?
>  > >
>  > > http://www.angstrom-distribution.org/toolchains/angstrom-2011.03-i686-linux-armv5te-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2
>  > 
>  > This toolchain is a lot older:
>  > 
>  > $ ./usr/local/angstrom/arm/bin/arm-angstrom-linux-gnueabi-gcc --version
>  > arm-angstrom-linux-gnueabi-gcc (GCC) 4.3.3
>  > Copyright (C) 2008 Free Software Foundation, Inc.
>  > This is free software; see the source for copying conditions.  There is NO
>  > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>  > 
>  > The tar-ball says 4.6.3, but that is probably the version number of the qte
>  > library, not that of gcc, which is 4.3.3, It does indeed produce
>  > the same (correct) output as in your case.
>  > 
>  > The newest angstrom (next) toolchain has gcc version 4.5.3, and it produces
>  > this (correct) output:
>  > 
>  > flexcan_chip_start:
>  >         @ Function supports interworking.
>  >         @ args = 0, pretend = 0, frame = 0
>  >         @ frame_needed = 0, uses_anonymous_args = 0
>  >         @ link register save eliminated.
>  >         mov     r3, #0
>  >         cmp     r0, #9
>  >         str     r3, [r1, #0]
>  >         mov     r0, #0
>  >         strgt   r3, [r1, #4]
>  >         bx      lr
>  >         .size   flexcan_chip_start, .-flexcan_chip_start
>  >         .ident  "GCC: (GNU) 4.5.3 20110311 (prerelease)"
>  >         .section        .note.GNU-stack,"",%progbits
>  > 
>  > Anyone knows where I can download a pre-built toolchain for 32-bit linux that
>  > is based on gcc-4.6 and/or gcc-4.7 to try out?
>  > 
>  > I have quite a hard time believing this issue is a yet unknown bug in GCC...
>  > I'd rather believe that I lack sufficient GCC knowledge to know how to
>  > correctly tell the compiler that this is a memory-IO operation. Anyone knows
>  > how to do this correctly? Or to explain why the output of gcc-4.6 looks less
>  > optimal than the output of older versions of GCC?
> 
> Well, my toolchain generates:
> 
> flexcan_chip_start:
>         @ args = 0, pretend = 0, frame = 0
>         @ frame_needed = 0, uses_anonymous_args = 0
>         @ link register save eliminated.
>         mov     r3, #0
>         cmp     r0, #9
>         str     r3, [r1, #0]
>         mov     r0, #0
>         strgt   r3, [r1, #4]
>         bx      lr
>         .size   flexcan_chip_start, .-flexcan_chip_start
>         .ident  "GCC: (GNU) 4.6.3 20120706 (Brewer Linux 4.6.3-3)"
> 
> which looks correct.

This is indeed strange. I have tried with unpatched gcc-4.6.3,
OSELAS.Toolchain gcc 4.6.2 and linaro gcc 4.6.3 (see my previous e-mail to
the list), and they all produce wrong results.
Can you tell me where I can get your toolchain (Brewer Linux)? It also looks
like your version is patched somehow (version number ends in -3). What patches
are included in this version?

> Your bug may be a consequence of using an antique gcc, how that gcc was
> configured, or "OSELAS/PTXdist" may have applied a broken patch to their
> gcc sources. When in doubt, _alway_ report suspected gcc problems to whoever
> supplied you with your gcc binaries.

Yes, the guys from OSELAS/Pengutronix are in CC (at least Sascha was from the
beginning). OSELAS is based on PTXdist, and as such does not distribute
binaries, but rather as build-scripts (recipes) a la gentoo.

> If you do decide to report this to gcc.gnu.org's bugzilla, be prepared to:
> 1: first reproduce the bug with a gcc built from unmodified gcc 4.6.3, 4.7.1,
>    or 4.8 sources -- older gccs are unmaintained and unsupported by upstream,

I think I already did. I just changed the version string in OSELAS.Toolchain
script from 4.6.2 to 4.6.3. AFAIK (Sascha may confirm) this should
automatically build an unpatched version of gcc-4.6.3, since the PTXdist patch
series exists only for gcc-4.6.2. It worked, and it produced wrong code.
Should I call the GCC police?

> 2: include the output of gcc -v which tells how that gcc was configured,
> 3: give the exact set of gcc options used then compiling the test case.

That should be easy.

> In this case the test case is so small it's not a problem, but in general
> self-contained executable tests that generate explicit runtime errors in
> case they were mis-compiled are preferred over tests that require a human
> to analyze the generated assembly code.

That's understandable, and probably a good explanation as of why this bug may
have slipped so far through in the first place: not enough people looking at
the assembly output generated by the compiler, and thus not noticing that it
produces code that is wrong but produces correct results if it can be executed
without bus-errors. It could get noticed in code-efficiency tests though,
since it is a tad less optimal than what both older and newer versions of GCC
produce :-)

Best regards,

-- 
David Jander
Protonic Holland.
