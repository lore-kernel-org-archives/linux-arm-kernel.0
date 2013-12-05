From: robherring2@gmail.com (Rob Herring)
Date: Thu, 5 Dec 2013 15:34:17 -0600
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <201312052125.57644.arnd@arndb.de>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312052125.57644.arnd@arndb.de>
Message-ID: <CAL_Jsq+ReNLYNUm4SofNTu=bD3m2F3rCfVP-tQna4+7Dhmv79Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 05 December 2013, Rob Herring wrote:
>> select ARM_AMBA
>> select ARM_GIC if CPU_V7
>> select HAVE_SMP if CPU_V7
>> select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
>> select ARCH_HAS_CPUFREQ
>> select ARCH_HAS_OPP
>
> Not sure about ARM_GIC and HAVE_SMP, as they won't typically be
> set on Cortex-A8, Scorpion and PJ4. The other suggestions sound
> good, and your patch looks fine as well.

HAVE_SMP only enables visibility of the SMP kconfig option. That could
cause randconfig builds that would not boot if SMP_ON_UP was not
enabled, but a "select SMP_ON_UP if SMP" here would fix that though.

GIC is on probably 90% of the v7 platforms, so seems like a small cost
to carry it. We've tried to avoid putting core specific knowledge into
the kernel, but effectively it is still there. It's just duplicated in
each platform selecting the individual options (GIC, SCU, TWD, errata,
etc.) rather than a core type.

Rob
