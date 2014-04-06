From: olof@lixom.net (Olof Johansson)
Date: Sat, 5 Apr 2014 19:01:16 -0700
Subject: [PATCH v1 6/8] ARM: hisi: add hip04 SoC support
In-Reply-To: <8340307.jkTP7h04Ur@wuerfel>
References: <1396339430-21084-1-git-send-email-haojian.zhuang@linaro.org>
 <1396339430-21084-7-git-send-email-haojian.zhuang@linaro.org>
 <7hd2gxywf3.fsf@paris.lan> <8340307.jkTP7h04Ur@wuerfel>
Message-ID: <CAOesGMiKeSvHL8ccjQuANggkA5yg+XyQppQEN0qS=XB=1O+e6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 4, 2014 at 8:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 04 April 2014 07:57:36 Kevin Hilman wrote:
>> Haojian Zhuang <haojian.zhuang@linaro.org> writes:
>>
>> > Hisilicon Hi3xxx is based on Cortex A9 Core. Now HiP04 SoC is based on
>> > Cortex A15 Core. And HiP04 supports LPAE to support large memory.
>> >
>> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>
>> [...]
>>
>> > diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
>> > index da16efd..707abfe 100644
>> > --- a/arch/arm/mach-hisi/Kconfig
>> > +++ b/arch/arm/mach-hisi/Kconfig
>> > @@ -19,6 +19,16 @@ config ARCH_HI3xxx
>> >       help
>> >         Support for Hisilicon Hi36xx/Hi37xx processor family
>> >
>> > +config ARCH_HIP04
>> > +     bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
>> > +     select ARM_LPAE
>>
>> Presumably this SoC can support non-LPAE also, correct?  If so, LPAE
>> should't be selected here, or else it will force LPAE on in a multi_v7
>> build also.
>
> Actually even if it doesn't support non-LPAE, using "select" is still
> wrong for the same reason.
>
> I think we should actually extend the CPU selection phase for multiplatform,
> so we have separate symbols for ARCH_MULTI_V7 (non-LPAE) and
> ARCH_MULTI_V7_LPAE. These would still be selectable at the same time,
> but you should only be able to turn on CONFIG_LPAE if ARCH_MULTI_V7
> is disabled.
>
> A platform that cannot run without LPAE conversely would have to depend
> on (ARCH_MULTI_V7_LPAE && !ARCH_MULTI_V7 && !ARCH_MULTI_V6). Once it
> does this, it can 'select LPAE' without breaking other platforms.

Why not just have it depend on ARCH_MULTI_V7 && LPAE? LPAE shouldn't
be possible to enable if MULTI_V6 is enabled.

So, you'd have:

MULTI_V6
MULTI_V6 + V7
MULTI_V7 + LPAE

as valid options.

We'd need to annotate existing non-LPAE platforms with depends on
!LPAE, but that shouldn't be a big deal.

And, we should probably change the multi defconfigs to be:

multi_v6_v7_defconfig which contains what v7_defconfig does today,
plus the v6 platforms
multi_lpae_defconfig which contains only v7+lpae platforms (and would
enable kvm, etc).



-Olof
