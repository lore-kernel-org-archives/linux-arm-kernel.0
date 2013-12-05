From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Dec 2013 22:50:38 +0100
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <CAL_Jsq+ReNLYNUm4SofNTu=bD3m2F3rCfVP-tQna4+7Dhmv79Q@mail.gmail.com>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312052125.57644.arnd@arndb.de>
 <CAL_Jsq+ReNLYNUm4SofNTu=bD3m2F3rCfVP-tQna4+7Dhmv79Q@mail.gmail.com>
Message-ID: <201312052250.38986.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 December 2013, Rob Herring wrote:
> On Thu, Dec 5, 2013 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 05 December 2013, Rob Herring wrote:
> >> select ARM_AMBA
> >> select ARM_GIC if CPU_V7
> >> select HAVE_SMP if CPU_V7
> >> select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
> >> select ARCH_HAS_CPUFREQ
> >> select ARCH_HAS_OPP
> >
> > Not sure about ARM_GIC and HAVE_SMP, as they won't typically be
> > set on Cortex-A8, Scorpion and PJ4. The other suggestions sound
> > good, and your patch looks fine as well.
> 
> HAVE_SMP only enables visibility of the SMP kconfig option. That could
> cause randconfig builds that would not boot if SMP_ON_UP was not
> enabled, but a "select SMP_ON_UP if SMP" here would fix that though.

Ok, I see. "select HAVE_SMP if CPU_V7" maybe "select HAVE_SMP if
ARCH_MULTI_V7" sounds reasonable then, at least I'd prefer that over
the "select SMP_ON_UP if SMP" option, which would make having SMP_ON_UP
as an option pointless, since you could no longer turn it off.

If you set HAVE_SMP for CPU_V7, it would be logical to also set it for
CPU_V6K, although I'm unsure if we actually still support any SMP V6K
platforms in practice: CNS3xxx is the only such platform I'm aware of,
and the SMP support for that one was never merged (it's in openwrt
though).

> GIC is on probably 90% of the v7 platforms, so seems like a small cost
> to carry it. We've tried to avoid putting core specific knowledge into
> the kernel, but effectively it is still there. It's just duplicated in
> each platform selecting the individual options (GIC, SCU, TWD, errata,
> etc.) rather than a core type.

Hmm, I realize that this only controls the compilation of one file and
no other #ifdef at this point, but I'm still hesitant here, since I can
think of a few people that were actually worried about a potential kernel
binary size increase after enabling CONFIG_MULTIPLATFORM. I think so
far we have been really good at keeping the size difference close to
zero, and while this is not a lot of code, it seems wrong to intentionally
grow the kernel here. No strong objections though, if you can find other
developers that think it's a good idea to have this automatically turned on.

	Arnd
