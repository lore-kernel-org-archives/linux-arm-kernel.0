From: robherring2@gmail.com (Rob Herring)
Date: Thu, 5 Dec 2013 22:10:42 -0600
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <201312052250.38986.arnd@arndb.de>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312052125.57644.arnd@arndb.de>
 <CAL_Jsq+ReNLYNUm4SofNTu=bD3m2F3rCfVP-tQna4+7Dhmv79Q@mail.gmail.com>
 <201312052250.38986.arnd@arndb.de>
Message-ID: <CAL_JsqLf0Ubi55mc-p0-qPwY0LzHEZ-SF9QwcELkKPfZH=9t_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 3:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 05 December 2013, Rob Herring wrote:
>> On Thu, Dec 5, 2013 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 05 December 2013, Rob Herring wrote:
>> >> select ARM_AMBA
>> >> select ARM_GIC if CPU_V7
>> >> select HAVE_SMP if CPU_V7
>> >> select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
>> >> select ARCH_HAS_CPUFREQ
>> >> select ARCH_HAS_OPP
>> >
>> > Not sure about ARM_GIC and HAVE_SMP, as they won't typically be
>> > set on Cortex-A8, Scorpion and PJ4. The other suggestions sound
>> > good, and your patch looks fine as well.
>>
>> HAVE_SMP only enables visibility of the SMP kconfig option. That could
>> cause randconfig builds that would not boot if SMP_ON_UP was not
>> enabled, but a "select SMP_ON_UP if SMP" here would fix that though.
>
> Ok, I see. "select HAVE_SMP if CPU_V7" maybe "select HAVE_SMP if
> ARCH_MULTI_V7" sounds reasonable then, at least I'd prefer that over
> the "select SMP_ON_UP if SMP" option, which would make having SMP_ON_UP
> as an option pointless, since you could no longer turn it off.
>
> If you set HAVE_SMP for CPU_V7, it would be logical to also set it for
> CPU_V6K, although I'm unsure if we actually still support any SMP V6K
> platforms in practice: CNS3xxx is the only such platform I'm aware of,
> and the SMP support for that one was never merged (it's in openwrt
> though).

We should be able to boot an SMP kernel on it whether or not the
platform has SMP support added, right?

Practically every v6 platform selects v6K. We should probably default
to V6K for ARCH_MULTI_V6 and let platforms select CPU_V6 instead if
needed. I believe that will give the v6 versions of code only as
needed and will give better versions of code if only v6K is selected.
imx31 is one that doesn't select v6K, but only very early revs did not
have v6K version of the 1136. I don't think any of those parts went
into production (maybe into the original Zune?).

I assume we expect a v6 SMP kernel to run on a non-v6K v6 platform? if
so, doing more digging I think we have a problem with
__kuser_cmpxchg64 on a v6 only platform with v6K enabled in the
kernel. Adding Nico since he wrote this. The code is ifdef'ed like
this:

#if defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
(only true for pre-v6)
...
#elif defined(CONFIG_CPU_32v6K)
(true when v6K gets enabled)
...
#elif !defined(CONFIG_SMP)
#ifdef CONFIG_MMU
(this is the correct condition for a v6 only platform)
...
#else
#warning "NPTL on non MMU needs fixing"
...
#endif
#else
#error "incoherent kernel configuration"
#endif

Any build with v6K enabled will get the double exclusive instructions
which won't work on v6 only platforms. It seems we need some
ALT_SMP/ALT_UP magic here.

>> GIC is on probably 90% of the v7 platforms, so seems like a small cost
>> to carry it. We've tried to avoid putting core specific knowledge into
>> the kernel, but effectively it is still there. It's just duplicated in
>> each platform selecting the individual options (GIC, SCU, TWD, errata,
>> etc.) rather than a core type.
>
> Hmm, I realize that this only controls the compilation of one file and
> no other #ifdef at this point, but I'm still hesitant here, since I can
> think of a few people that were actually worried about a potential kernel
> binary size increase after enabling CONFIG_MULTIPLATFORM. I think so
> far we have been really good at keeping the size difference close to
> zero, and while this is not a lot of code, it seems wrong to intentionally
> grow the kernel here. No strong objections though, if you can find other
> developers that think it's a good idea to have this automatically turned on.

Agreed. I doubt we'd get agreement here which is why I did not do it
from the start.

Rob
