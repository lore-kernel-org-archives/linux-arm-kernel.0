From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 09:09:59 -0800
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <20140220112248.GC32456@localhost>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <5302B306.8090503@samsung.com>
 <CAOesGMhnUDcUL7hREV=EYEGr5YG-ZLL6v9NiGcrBr6477WfdyQ@mail.gmail.com>
 <6032891.ndY8FikAMY@wuerfel>
 <CALAqxLX6STNqUeVO2G18bm_HKabpoRxZTa3uK6i-JP97zEYVZg@mail.gmail.com>
 <CAOesGMjLR3PGXeyJPAvGwam4yK97+vnDfq5MVutJz75aKPX8gw@mail.gmail.com>
 <CALAqxLU7ehHfvQa58HpdzojRU-2zhNpEgkr9KEJ3cf550WcnWw@mail.gmail.com>
 <CAOesGMjSjzZ4iX3NVA6eS4LHJF2MQQ=KJpNgKWikJb6YkQxNpQ@mail.gmail.com>
 <20140220112248.GC32456@localhost>
Message-ID: <CAOesGMhfhdqqb4hJ0hC5HbSWWMQc0FDaaZYO0rZ1cdFtuRgdig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 3:22 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Feb 20, 2014 at 09:03:30AM +0000, Olof Johansson wrote:
>> So, after giving this some more thought (and getting my hands dirty in
>> some of this code), I think I'm going to change my mind on this. For
>> mobile platforms I think it might make sense to bring over the
>> toplevel platform Kconfig from arch/arm, to simplify dependencies
>> without tearing up the driver subtree with churn like this.
>>
>> This, of course, only holds true for v8 mobile platforms. Samsung
>> isn't saying if GH7 is a server platform and not, and they don't have
>> to tell us. But I think we should consider only enabling and bringing
>> over the mobile ones (and ideally try to avoid even that, but it might
>> make sense to do some of them at least initially -- it does provide
>> some convenient ways to enable larger subsets of default drivers per
>> platform/vendor family).
>>
>> I.e. I'd be OK with an
>> ARCH_EXYNOS/ARCH_TEGRA/ARCH_IMX/ARCH_<whatever>, but I don't think we
>> should add more finegrained options than that globally on ARM64, at
>> least not until truly proven to be needed. We're trying to push back
>> against new per-SoC Kconfig entries on 32-bit as well right now.
>
> I'm fine with this. Do we still need something for ARMv8 server
> platforms like ARCH_ARM_SBSA? The only advantage would be to make it
> easier for mobile targeted kernel builds to disable server features but
> I'm not sure there are so many such features, people can trim the
> .config manually.

I don't think there's all that much that's unique to SBSA for a
Kconfig entry. If anything it could be useful to describe dependencies
(i.e. you very likely don't want to turn off the standardized UART
driver, etc). But doing that through Kconfig is a bit clumsy, we might
be better off doing it through example defconfigs. I'm not sure we
want to do it through selects.

> Two additional points:
>
> 1. Single arm64 defconfig file covering everything
> 2. Modules rather than built-in by default where possible (especially
>    for server platforms)

Sounds good to me. Are you also willing to pick up one defconfig per
vendor (but not more)? I think it's been useful to have those on arm,
even on multiplatform kernels. We used them on powerpc as well, where
we had a two-layer approach (ppc64_defconfig and per-platform configs,
pseries/iseries/pasemi/g5/cell).


-Olof
