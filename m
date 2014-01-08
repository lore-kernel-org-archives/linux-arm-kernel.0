From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 8 Jan 2014 14:42:47 +0530
Subject: [PATCH] Fix select-induced Kconfig warning for ZBOOT_ROM
In-Reply-To: <5463332.bvmmoGYyKm@wuerfel>
References: <E1Vyl3Q-0005Lt-Lo@rmk-PC.arm.linux.org.uk>
 <3792319.Wf518ByjFs@wuerfel>
 <CAKohpo=2qKoffu7TuLHTLtX4vxX3Vs_oPV9DUHOkXiwN_fWCPg@mail.gmail.com>
 <5463332.bvmmoGYyKm@wuerfel>
Message-ID: <CAKohponfH6KdEu6KGO-kLnp1+zDt3b28ugMVWxGoVECn8LAnkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2014 14:37, Arnd Bergmann <arnd@arndb.de> wrote:
>> > --- a/arch/arm/mach-imx/Kconfig
>> > +++ b/arch/arm/mach-imx/Kconfig
>> > @@ -3,7 +3,7 @@ config ARCH_MXC
>> >         select ARCH_REQUIRE_GPIOLIB
>> >         select ARM_CPU_SUSPEND if PM
>> >         select ARM_PATCH_PHYS_VIRT
>> > -       select AUTO_ZRELADDR if !ZBOOT_ROM
>> > +       select AUTO_ZRELADDR
>> >         select CLKSRC_MMIO
>> >         select COMMON_CLK
>> >         select GENERIC_ALLOCATOR
>>
>> Exynos already has this:
>>
>> arch/arm/mach-exynos/Kconfig
>> config SOC_EXYNOS5440
>>     ...
>>     select AUTO_ZRELADDR
>
> Yes, that is ok. The problem with the imx dependency is that the kconfig
> parser needs to know the state of the ZBOOT_ROM symbol in order to decide
> whether to select AUTO_ZRELADDR or not, but ZBOOT_ROM in turn depends on
> AUTO_ZRELADDR.
>
> On second thought, we should just remove the 'select AUTO_ZRELADDR' from
> ARCH_MXC and everything that is multiplatform enabled, since it's already
> selected by ARCH_MULTIPLATFORM. An interesting question is what to do
> about the case where you actually want ZBOOT_ROM with a multiplatform
> enabled machine. We should probably allow that, but it's not possible
> to express that in Kconfig as long as ZBOOT_ROM depends on !AUTO_ZRELADDR.
> Obviously such a kernel won't be true multiplatform (it will only
> work on systems with the right rom address), but I think that's ok as
> long as it's documented well and not enabled by default. This is similar
> to what we need to allow non-MMU builds for multiplatform machines.

I see.. So, I confirm that above diff fixes my issue.
