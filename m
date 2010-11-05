From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 5 Nov 2010 13:12:48 +0100
Subject: recent ARM Erratas 742231 & 742230 broken.
In-Reply-To: <-5088739724674874052@unknownmsgid>
References: <AANLkTim6LRZQhW6R83P0n70GdqEwFnFvb55KC8459KwY@mail.gmail.com>
	<-5088739724674874052@unknownmsgid>
Message-ID: <AANLkTik3ipJHcPtsy5cTuO1PhmAbKwGfSqAE_gUKjhiG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/20 Will Deacon <will.deacon@arm.com>:

> The diagnostic register is only writable from secure mode so you'll need to
> look at what these patches do (they perform simple read-modify-writes) and
> incorporate that code into your secure software.
> (...)
> I doubt that your secure monitor exposes the diagnostic register through an
> SMC interface so you'll need to change the secure boot code to enable these
> workarounds when the system comes out of reset.

These SMC:s (System Management Call?) are getting hairier now.

Can't you add an abstraction for the stuff we need to poke into
diagnostics registers, enabling platform-specific overrides, like
we do for l2x0 in mm/cache-l2x0.c?

Like if arch/arm/include/asm/proc-v7-diagnostics.h:
(modeled on arch/arm/include/asm/outercache.h)

struct v7_core_diagnostics {
  void (*foo)(void);
  void (*bar)(void);
};

Then we can override thes during .machine_init or even .fixup if
it's needed real early on.

This way each platform (including I think U8500 and OMAP4) can respond
correctly to the errata patches once we have proper SMCs in place.

Yours,
Linus Walleij
