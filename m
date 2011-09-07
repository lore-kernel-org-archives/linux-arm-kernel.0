From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Sep 2011 18:04:52 +0100
Subject: [PATCH] ARM: alignment: setup alignment handler earlier
In-Reply-To: <yw1xipp4cnis.fsf@unicorn.mansr.com>
References: <87ehzstr07.fsf@vostro.fn.ogness.net>
	<20110907144016.GA30719@e102109-lin.cambridge.arm.com>
	<20110907162857.GB2327@n2100.arm.linux.org.uk>
	<yw1xipp4cnis.fsf@unicorn.mansr.com>
Message-ID: <20110907170452.GC2327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2011 at 05:42:19PM +0100, M?ns Rullg?rd wrote:
> There are such instructions (ldrd, ldm), but gcc will not emit those
> unless the address is known to be aligned.  For ARMv6 and later, gcc 4.6
> *will* emit potentially unaligned ldr and ldrh since these very clearly
> allow an unaligned address and are faster than the alternatives in all
> implementations to date.  This is unless strict alignment checking is
> explicitly enabled, which unfortunately the Linux kernel does for no
> apparent reason at all.

"no apparant reason at all" heh.  The reason is to keep the code
simple and free from bugs.  To do otherwise means that each of the
CPU files needs to be littered with ifdefs to deal with the alignment
fault configuration, of which there are 16 of them (ignoring v6 and v7.)

If you think code maintanence of the same thing in 16 places is efficient
then I guess there is "no apparant reason".  I beg to differ, being one
of those folk who have had to edit 18 different places several times.

So no, I do not intend to move this:

#ifdef CONFIG_ALIGNMENT_TRAP
        orr     r0, r0, #CR_A
#else
        bic     r0, r0, #CR_A
#endif

into 16 separate places in the kernel.
