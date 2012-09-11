From: david.jander@protonic.nl (David Jander)
Date: Tue, 11 Sep 2012 09:27:53 +0200
Subject: GCC 4.6.x miscompiling arm-linux?
In-Reply-To: <w51bohddcqw.fsf@mail.mattleach.net>
References: <20120910171654.1d4972b2@archvile>
 <w51bohddcqw.fsf@mail.mattleach.net>
Message-ID: <20120911092753.7b8315d4@archvile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Matt,

On Mon, 10 Sep 2012 18:11:19 +0100
Matthew Leach <matthew@mattleach.net> wrote:
> David Jander <david.jander@protonic.nl> writes:
> > ...
> > 	.text
> > 	.align	2
> > 	.global	flexcan_chip_start
> > 	.type	flexcan_chip_start, %function
> > flexcan_chip_start:
> > 	@ args = 0, pretend = 0, frame = 0
> > 	@ frame_needed = 0, uses_anonymous_args = 0
> > 	@ link register save eliminated.
> > 	mov	r3, #0
> > 	cmp	r0, #9
> > 	str	r3, [r1, #0]
> > 	ldrle	r3, [r1, #4]
> > 	mov	r0, #0
> > 	str	r3, [r1, #4]
> > 	bx	lr
> > 	.size	flexcan_chip_start, .-flexcan_chip_start
> > 	.ident	"GCC: (OSELAS.Toolchain-2011.11.1) 4.6.2"
> > 	.section	.note.GNU-stack,"",%progbits
> >
> 
> This does indeed look wrong. I had a go at compile your code snippet the
> following assembly was produced:
> 
>         .text
>         .align  2
>         .global flexcan_chip_start
>         .type   flexcan_chip_start, %function
> flexcan_chip_start:
>         @ Function supports interworking.
>         @ args = 0, pretend = 0, frame = 0
>         @ frame_needed = 0, uses_anonymous_args = 0
>         @ link register save eliminated.
>         cmp     r0, #9
>         mov     r3, #0
>         str     r3, [r1, #0]
>         mov     r0, #0
>         strgt   r3, [r1, #4]
>         bx      lr
>         .size   flexcan_chip_start, .-flexcan_chip_start
>         .ident  "GCC: (GNU) 4.3.3"
>         .section        .note.GNU-stack,"",%progbits
> 
> I think this looks correct. Perhaps you could try the angstrom arm5te
> toolchain and see if it's a toolchain issue?

Yes, this looks a lot better, and is exactly what I get when I compile this
code with CodeSourcery GCC-4.4.1

I have tries building gcc-4.6.3 also with OSELAS/PTXdist, and it gives the
same (wrong) result as with gcc-4.6.2

> I think this looks correct. Perhaps you could try the angstrom arm5te
> toolchain and see if it's a toolchain issue?
>
> http://www.angstrom-distribution.org/toolchains/angstrom-2011.03-i686-linux-armv5te-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2

This toolchain is a lot older:

$ ./usr/local/angstrom/arm/bin/arm-angstrom-linux-gnueabi-gcc --version
arm-angstrom-linux-gnueabi-gcc (GCC) 4.3.3
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

The tar-ball says 4.6.3, but that is probably the version number of the qte
library, not that of gcc, which is 4.3.3, It does indeed produce
the same (correct) output as in your case.

The newest angstrom (next) toolchain has gcc version 4.5.3, and it produces
this (correct) output:

flexcan_chip_start:
        @ Function supports interworking.
        @ args = 0, pretend = 0, frame = 0
        @ frame_needed = 0, uses_anonymous_args = 0
        @ link register save eliminated.
        mov     r3, #0
        cmp     r0, #9
        str     r3, [r1, #0]
        mov     r0, #0
        strgt   r3, [r1, #4]
        bx      lr
        .size   flexcan_chip_start, .-flexcan_chip_start
        .ident  "GCC: (GNU) 4.5.3 20110311 (prerelease)"
        .section        .note.GNU-stack,"",%progbits

Anyone knows where I can download a pre-built toolchain for 32-bit linux that
is based on gcc-4.6 and/or gcc-4.7 to try out?

I have quite a hard time believing this issue is a yet unknown bug in GCC...
I'd rather believe that I lack sufficient GCC knowledge to know how to
correctly tell the compiler that this is a memory-IO operation. Anyone knows
how to do this correctly? Or to explain why the output of gcc-4.6 looks less
optimal than the output of older versions of GCC?

Best regards,

-- 
David Jander
Protonic Holland.
