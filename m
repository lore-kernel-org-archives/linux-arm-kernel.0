From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 7 Dec 2012 13:49:29 +0000
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <20121207122809.GT14363@n2100.arm.linux.org.uk>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
 <20121130143435.GP19440@n2100.arm.linux.org.uk>
 <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
 <20121204221851.GJ14363@n2100.arm.linux.org.uk>
 <CAHod+Gd6NJsuJVRos52e9+NcweqcSu=HArT_qoV0ygb_Xbfaiw@mail.gmail.com>
 <20121205235836.GR14363@n2100.arm.linux.org.uk>
 <20121207122809.GT14363@n2100.arm.linux.org.uk>
Message-ID: <20121207134929.GA1969@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 12:28:09PM +0000, Russell King - ARM Linux wrote:

[...]

> Having thought about this for quite a while, I think there's three
> options:
> 
> 1. The Sharp Zaurus code is unmaintained.  Declare it to be broken, and
>    remove all the Sharp code from the kernel so that people aren't tempted
>    to think it's something that the kernel supports.  (In light of the
>    lack of maintainer for these platforms which almost no one knows much
>    about, that will lower the maintanence burden on everyone else.)
> 
> 2. Revert the hyp-mode support and say that we can't accept _any_ change
>    whatsoever to the decompressor head.S through fear that it will cause
>    a regression for Sharp Zaurus platforms.  (This effectively means we
>    can't support virtualization on ARM - which is not acceptable.)
> 
> 3. Revert the hyp-mode support and make it conditional on CPUs that have
>    hyp-mode support.
> 
> Out of those three, (3) is the best way forward.  So, unless I hear any
> objections, I'm going to revert 424e5994e63 in mainline, and wait for a
> patch to safe_svcmode_maskall so that it can be switched between the
> hyp-mode version and the non-hyp-mode.
> 
> This shouldn't be a problem for the single-zImage people; the break-point
> is the ARMv5/ARMv6 boundary which we're already keeping as separate kernels.

I've posted a separate patch which ought to accomplish the appropriate
change to safe_svc_maskall
([PATCH] ARM: head: Remove boot-time HYP mode check for v5 and below)

I've done a compile-disassemble sanity-check for v5 and v7 to make sure
that the results are sane, but I can't check whether it fixed the
problem for the affected hardware.

Marko, can you give it a try?

Cheers
---Dave
