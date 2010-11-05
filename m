From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Nov 2010 13:13:40 +0000
Subject: recent ARM Erratas 742231 & 742230 broken.
In-Reply-To: <AANLkTik3ipJHcPtsy5cTuO1PhmAbKwGfSqAE_gUKjhiG@mail.gmail.com>
References: <AANLkTim6LRZQhW6R83P0n70GdqEwFnFvb55KC8459KwY@mail.gmail.com>
	<-5088739724674874052@unknownmsgid>
	<AANLkTik3ipJHcPtsy5cTuO1PhmAbKwGfSqAE_gUKjhiG@mail.gmail.com>
Message-ID: <20101105131340.GA23828@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 01:12:48PM +0100, Linus Walleij wrote:
> 2010/10/20 Will Deacon <will.deacon@arm.com>:
> 
> > The diagnostic register is only writable from secure mode so you'll need to
> > look at what these patches do (they perform simple read-modify-writes) and
> > incorporate that code into your secure software.
> > (...)
> > I doubt that your secure monitor exposes the diagnostic register through an
> > SMC interface so you'll need to change the secure boot code to enable these
> > workarounds when the system comes out of reset.
> 
> These SMC:s (System Management Call?) are getting hairier now.
> 
> Can't you add an abstraction for the stuff we need to poke into
> diagnostics registers, enabling platform-specific overrides, like
> we do for l2x0 in mm/cache-l2x0.c?

That's a subject which came up when the first errata were merged.  The
fact of the matter is that there's no easy way to abstract the assembly
code - it certainly can't become C code because we don't have the MMU
up and running at this point.

Running the kernel in non-secure mode is going to be painful because of
(a) the need to issue SMC calls to access protected registers, and (b)
the lack of an API for the SMC call.

(a) isn't going to change, and (b) apparantly isn't something we can
influence.

The approach generally taken by proc-v7 is to check whether the work-
around is already enabled, and if it is, it skips trying to enable it
a second time, thereby avoiding aborts etc.

So the responsibility for enabling the protected work-arounds lies with
code which has access to the registers.
