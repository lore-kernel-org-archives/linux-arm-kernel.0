From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Oct 2018 10:35:08 +0100
Subject: [PATCH] [ALTERNATIVE] ARM: fix copypage functions for clang
In-Reply-To: <20181017090417.833924-1-arnd@arndb.de>
References: <CAK8P3a3XUdkBmrnMUn2TePEBAh49=QvvxRiOk_+JnSp1fSwXJg@mail.gmail.com>
 <20181017090417.833924-1-arnd@arndb.de>
Message-ID: <20181017093508.GG30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 11:04:17AM +0200, Arnd Bergmann wrote:
> The constraints were originally added in commit 9a40ac86152c ("ARM:
> 6164/1: Add kto and kfrom to input operands list.") as a gcc-4.5
> workaround. Another workaround for the same problem was added in commit
> 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone and noinline
> on __naked functions") and should have obsoleted the first one.

That is an incorrect statement - please read the discussion back then,
particularly Mikael Pettersson's reply:

"I've tested and verified that this bit enables a gcc-4.5 compiled kernel
to boot on TS-119 (Kirkwood) when combined with my fix for __naked.
With neither or only one of the patches applied, the kernel oopses hard
in copy_user_page() as it tries to start /sbin/init."

That is very clear that it is not "one or the other" patch, and it's
certainly not true that one patch obsoletes the other.

Mikael is also very clear in the effects that are going on - to re-quote
what I've already quoted (and clearly you missed):

"- the asm() bodies of these __naked functions have inadequate input
  parameter constraints, in particular they fail to declare any
  dependencies on the functions' formal parameters; gcc-4.5 sees this
  and skips the parameter setup before calling these functions, causing
  runtime crashes"

This description makes it clear that it's not the naked function that
is wrong, but the function that _calls_ the naked function - stating
that GCC fails to setup the parameters _for_ _the_ _called_ _naked_
_function_.

So, there are two issues here:

1. gcc-4.5 has been observed to clone and inline naked functions, which
   you claim has been fixed.
2. gcc-4.5 fails to setup parameters for naked functions, which we have
   no idea whether it's been fixed.

> I've used this on my randconfig build setup, and it makes all
> configurations build without warnings, but I have not done
> any runtime testing on it.

Since the problem has always been a runtime issue, a build-only test is
insufficient.

Sorry, but no, this is way too risky in its current form.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
