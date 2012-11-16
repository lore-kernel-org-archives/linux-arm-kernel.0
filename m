From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Nov 2012 10:05:50 +0000
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
In-Reply-To: <50A50C24.9010702@gmail.com>
References: <50A3EBCD.3040801@ti.com>
 <20121114202244.GE3332@n2100.arm.linux.org.uk>
 <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com>
 <20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com>
 <20121115110137.GA25985@arm.com> <50A4FCC5.2080604@gmail.com>
 <20121115143714.GF25985@arm.com> <50A50C24.9010702@gmail.com>
Message-ID: <20121116100550.GI3332@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 09:37:08AM -0600, Rob Herring wrote:
> >> Does that work for Versatile Express CA9? It needs ARM_ERRATA_751472.
> > 
> > On VE Linux runs in secure mode, so it's fine.
> 
> WTF? You are contradicting yourself.

No, it's already been explained; the problem is lack of understanding.

Versatile Express does indeed run in secure mode; it doesn't have any
secure monitor present.  OMAP and many other platforms run in non-secure
mode.

The work-arounds are applied to secure mode registers which are sensitive
to writes in the following manner:
- we check the revision of the CPU to see whether the workaround is
  applicable.  If it is, then...
  - the register is read.
  - the bit(s) are checked to see whether the work-around has already been
    applied.
  - the bit(s) is set to the appropriate state.
  - the register is written _if_ the work-around has not already been applied.

That means a platform running in secure mode gets the work-arounds applied
as appropriate for the CPU.  It also means that a platform running in non-
secure mode won't boot if the work-around has not already been applied.
That is a good thing; some work-arounds fix data corrupting bugs, and we
don't want an unsafe kernel running on such platforms.

So, we don't detect whether we're running in secure mode or not; as I've
already stated, we don't have a way to do that.  We instead only apply
work-arounds which aren't already enabled prior to the kernel booting.
So, even on a secure mode platform, we will avoid writing the bits if the
work-around has already been applied.
