From: matthew@mattleach.net (Matthew Leach)
Date: Mon, 10 Sep 2012 18:11:19 +0100
Subject: GCC 4.6.x miscompiling arm-linux?
In-Reply-To: <20120910171654.1d4972b2@archvile> (David Jander's message of
 "Mon, 10 Sep 2012 17:16:54 +0200")
References: <20120910171654.1d4972b2@archvile>
Message-ID: <w51bohddcqw.fsf@mail.mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

David Jander <david.jander@protonic.nl> writes:
> ...
> 	.text
> 	.align	2
> 	.global	flexcan_chip_start
> 	.type	flexcan_chip_start, %function
> flexcan_chip_start:
> 	@ args = 0, pretend = 0, frame = 0
> 	@ frame_needed = 0, uses_anonymous_args = 0
> 	@ link register save eliminated.
> 	mov	r3, #0
> 	cmp	r0, #9
> 	str	r3, [r1, #0]
> 	ldrle	r3, [r1, #4]
> 	mov	r0, #0
> 	str	r3, [r1, #4]
> 	bx	lr
> 	.size	flexcan_chip_start, .-flexcan_chip_start
> 	.ident	"GCC: (OSELAS.Toolchain-2011.11.1) 4.6.2"
> 	.section	.note.GNU-stack,"",%progbits
>

This does indeed look wrong. I had a go at compile your code snippet the
following assembly was produced:

        .text
        .align  2
        .global flexcan_chip_start
        .type   flexcan_chip_start, %function
flexcan_chip_start:
        @ Function supports interworking.
        @ args = 0, pretend = 0, frame = 0
        @ frame_needed = 0, uses_anonymous_args = 0
        @ link register save eliminated.
        cmp     r0, #9
        mov     r3, #0
        str     r3, [r1, #0]
        mov     r0, #0
        strgt   r3, [r1, #4]
        bx      lr
        .size   flexcan_chip_start, .-flexcan_chip_start
        .ident  "GCC: (GNU) 4.3.3"
        .section        .note.GNU-stack,"",%progbits

I think this looks correct. Perhaps you could try the angstrom arm5te
toolchain and see if it's a toolchain issue?

http://www.angstrom-distribution.org/toolchains/angstrom-2011.03-i686-linux-armv5te-linux-gnueabi-toolchain-qte-4.6.3.tar.bz2

Thanks,
Matt
