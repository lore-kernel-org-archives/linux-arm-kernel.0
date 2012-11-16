From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 16 Nov 2012 18:47:54 +0530
Subject: [PATCH] ARM: dts: add board dts file for Exynos4412 based SMDK
 board
In-Reply-To: <1478784.noXcLYhIRL@amdc1227>
References: <1351954172-13645-1-git-send-email-thomas.abraham@linaro.org>
 <3179451.csXCh8vt1v@amdc1227>
 <CAJuYYwTo6MUUM3oN1XPpxuQ2ta67tEr-UqVjviXG=Yg6c3ywBg@mail.gmail.com>
 <1478784.noXcLYhIRL@amdc1227>
Message-ID: <CAJuYYwSqLcPXmaDpC1p-wSSZMkxKMYCqYYECETCk6oHGBtYjUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2012 18:28, Tomasz Figa <t.figa@samsung.com> wrote:
> On Friday 16 of November 2012 18:03:15 Thomas Abraham wrote:
>> On 16 November 2012 16:41, Tomasz Figa <t.figa@samsung.com> wrote:
>> > On Thursday 15 of November 2012 13:48:55 Thomas Abraham wrote:
>> >> Hi Tomasz,
>> >>
>> >> Thanks for your comments.
>> >>
>> >> On 12 November 2012 19:37, Tomasz Figa <t.figa@samsung.com> wrote:
>> >> > Hi Thomas,
>> >> >
>> >> > On Saturday 03 of November 2012 20:19:32 Thomas Abraham wrote:
>> >> >> Add a minimal board dts file for Samsung Exynos4412 based SMDK
>> >> >> board.
>> >> >>
>> >> >> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> >> >> ---
>> >> >> This patch depends the on the following patch posted by Tomasz
>> >> >> Figa.
>> >> >> "ARM: dts: exynos4: Add support for Exynos4x12 SoCs"
>> >> >>
>> >> >>  arch/arm/boot/dts/Makefile                |    1 +
>> >> >>  arch/arm/boot/dts/exynos4412-smdk4412.dts |   45
>> >> >>
>> >> >> +++++++++++++++++++++++++++++ 2 files changed, 46 insertions(+), 0
>> >> >> deletions(-)
>> >> >>
>> >> >>  create mode 100644 arch/arm/boot/dts/exynos4412-smdk4412.dts
>> >> >>
>> >> >> diff --git a/arch/arm/boot/dts/Makefile
>> >> >> b/arch/arm/boot/dts/Makefile
>> >> >> index f37cf9f..36488a5 100644
>> >> >> --- a/arch/arm/boot/dts/Makefile
>> >> >> +++ b/arch/arm/boot/dts/Makefile
>> >> >> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
>> >> >>
>> >> >>  dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>> >> >>
>> >> >>       exynos4210-smdkv310.dtb \
>> >> >>       exynos4210-trats.dtb \
>> >> >>
>> >> >> +     exynos4412-smdk4412.dtb \
>> >> >>
>> >> >>       exynos5250-smdk5250.dtb
>> >> >>
>> >> >>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
>> >> >>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
>> >> >>
>> >> >> diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts
>> >> >> b/arch/arm/boot/dts/exynos4412-smdk4412.dts new file mode 100644
>> >> >> index 0000000..f05bf57
>> >> >> --- /dev/null
>> >> >> +++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
>> >> >> @@ -0,0 +1,45 @@
>> >> >> +/*
>> >> >> + * Samsung's Exynos4412 based SMDK board device tree source
>> >> >> + *
>> >> >> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
>> >> >> + *           http://www.samsung.com
>> >> >> + *
>> >> >> + * Device tree source file for Samsung's SMDK4412 board which is
>> >> >> based
>> >> >> on + * Samsung's Exynos4412 SoC.
>> >> >> + *
>> >> >> + * This program is free software; you can redistribute it and/or
>> >> >> modify + * it under the terms of the GNU General Public License
>> >> >> version 2 as + * published by the Free Software Foundation.
>> >> >> +*/
>> >> >> +
>> >> >> +/dts-v1/;
>> >> >> +/include/ "exynos4412.dtsi"
>> >> >> +
>> >> >> +/ {
>> >> >> +     model = "Samsung SMDK evaluation board based on Exynos4412";
>> >> >> +     compatible = "samsung,smdk4412", "samsung,exynos4412";
>> >> >> +
>> >> >> +     memory {
>> >> >> +             reg = <0x40000000 0x40000000>;
>> >> >> +     };
>> >> >
>> >> > This will not boot, because section size limit is set to 256 MiB.
>> >> >
>> >> > It might work with CONFIG_ARM_ATAG_DTB_COMPAT enabled, because the
>> >> > memory configuration from DT is ignored and values from ATAGs are
>> >> > taken instead.
>> >> >
>> >> > I suggest you to change it to 4 banks of 256 MiB.
>> >>
>> >> Thanks for pointing this out. So are there any existing exynos based
>> >> platforms that use sparse mem? If not, we should probably remove the
>> >> section length configuration itself for mach-exynos. I suspect this
>> >> setting might not help with the single kernel image support as well.
>> >
>> > Isn't sparse memory the only configuration available for ARCH_EXYNOS?
>>
>> Yes, true. Since sparsemem is choosen as default for Exynos, flatmem
>> option is not available. Theoretically, sparsemem could be used on
>> Exynos platforms, but if all existing exynos4/5 based boards have no
>> holes in memory, then why not use flatmem instead? If there are
>> performance benefits of using flatmem over sparesmem on systems
>> without any memory holes, then it is a compelling reason to stop using
>> sparsemem on Exynos. But then, what if there is a new Exynos4/5 based
>> board that comes up and that has a memory hole? Or, how about removing
>> sparsemem as default option for ARCH_EXYNOS and enabling sparsemem for
>> boards that need it.
>
> I'm not sure about any significant performance benefits of FLATMEM over
> SPARSEMEM. Some ancient benchmark from 2007 shows that overhead level of
> both is similar.
>
> You can find the benchmark here:
> http://lkml.indiana.edu/hypermail/linux/kernel/0711.1/1239.html
>
> I think we should leave it as is for the time being and just make sure
> that sections of boards are defined according to section size limit.

Ok, makes sense. Thanks. By the way, I was checking why this patch did
not lead me to a crash as you described. u-boot seems to be overriding
the memory node in the dts file and creating a new memory node with
the memory banks information that u-boot has. So looking at
/proc/device-tree/memory/reg, there are multiple 256MB sized entries
there.

Regards,
Thomas.
