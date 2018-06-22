From: gerg@linux-m68k.org (Greg Ungerer)
Date: Fri, 22 Jun 2018 10:58:37 +1000
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile
 machine for no-MMU
In-Reply-To: <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
 <20180618141905.7789-5-gerg@linux-m68k.org>
 <CAMuHMdUyCEq0U_CJindwcSEF+0dR-SJc1v8zGT-CcUqVkdOeVw@mail.gmail.com>
Message-ID: <0376105d-6a8e-ad8f-6516-a39244303e0b@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 22/06/18 01:59, Geert Uytterhoeven wrote:
> CC Chris, Arnd, Nicolas
> On Mon, Jun 18, 2018 at 4:21 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> Allow the arm versatile machine to be configured for no-MMU operation.
>>
>> Older kernels had the ability to build the versatile machine with the MMU
>> disabled (!CONFIG_MMU). Recent changes to convert the versatile machine
>> to device tree lost this ability. (Although older kernels could be built
>> they did not run due to a bug in the IO_ADDRESS() mapping on this machine).
>>
>> The motivation for this is that the versatile machine is well supported
>> in qemu. And this provides an excellent platform for development and
>> testing no-MMU support on ARM in general.
>>
>> This patch adds a versatile platform selection in the upper level arm
>> system type menu - where it appeared in older kernel versions - when
>> configuring for the no-MMU case. There is no visible change to the way
>> versatile is selected for the MMU enabled case.
>>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Thanks for your patch! I'm happy to see nommu spreading ;-)

Not sure if it is a good thing or not :-)


>> ---
>>   arch/arm/Kconfig                | 11 +++++++++++
>>   arch/arm/Kconfig.debug          |  3 ++-
>>   arch/arm/mach-versatile/Kconfig |  5 +++--
>>   3 files changed, 16 insertions(+), 3 deletions(-)
>>
>> v2: don't use a multiplatform setup, move versatile choice to top level menu
>> v3: rebase on top of linux-4.10
>> v3: rebase on top of linux-4.17
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 54eeb8d00bc6..0608a6a32fac 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -356,6 +356,17 @@ config ARM_SINGLE_ARMV7M
>>          select SPARSE_IRQ
>>          select USE_OF
>>
>> +config ARM_SINGLE_ARCH_VERSATILE
>> +       bool "ARM Ltd. Versatile family"
>> +       depends on !MMU
>> +       select AUTO_ZRELADDR
>> +       select CLKSRC_OF
>> +       select COMMON_CLK
>> +       select GENERIC_CLOCKEVENTS
>> +       select GPIOLIB
>> +       select SPARSE_IRQ
>> +       select USE_OF
>> +
> 
> I'm afraid adding (duplicating) machine entries for nommu support is not a
> sustainable solutions. Any machine can run a nommu kernel, in theory.

I don't disagree with you, my first patch for this did not duplicate
the machine type:

   https://patchwork.kernel.org/patch/9350033/

Vladimir Murzin had an alternative that also didn't duplicate machines:

   https://www.spinics.net/lists/arm-kernel/msg546837.html

But subsequent discussions didn't really get to a final solution:

   https://patchwork.kernel.org/patch/9464017/

Regards
Greg


> I'm aware of the objection "but you cannot build a nommu kernel that can
> boot on multiple systems".  That's true (unless RAM/FLASH addresses are the
> same). So don't do that.
> 
> All of the above is true for XIP, too, hence applies with s/nommu/XIP/.
> One more reason not to have this duplication.
> 
> The current "ARM multiplatform" has actually two meanings:
>    1. It groups platforms that follow the "ARM multiplatform" framework,
>    2. It allows to build a single kernel that can be booted on multiple
>       platforms.
> To avoid the duplication, I think 2 should be relaxed when specialized
> options like XIP or NOMMU are selected.
> 
> I've just sent a patch to do that.
> 
>>   config ARCH_EBSA110
>>          bool "EBSA-110"
>>          select ARCH_USES_GETTIMEOFFSET
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 693f84392f1b..242a0f744c8a 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -1836,7 +1836,8 @@ config DEBUG_UNCOMPRESS
>>   config UNCOMPRESS_INCLUDE
>>          string
>>          default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
>> -                                       PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
>> +                                       PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
>> +                                       ARM_SINGLE_ARCH_VERSATILE
>>          default "mach/uncompress.h"
>>
>>   config EARLY_PRINTK
>> diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
>> index f5c275434d6c..06ad999d5978 100644
>> --- a/arch/arm/mach-versatile/Kconfig
>> +++ b/arch/arm/mach-versatile/Kconfig
>> @@ -1,7 +1,8 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   config ARCH_VERSATILE
>> -       bool "ARM Ltd. Versatile family"
>> -       depends on ARCH_MULTI_V5
>> +       bool "ARM Ltd. Versatile family" if ARCH_MULTI_V5
>> +       depends on ARCH_MULTI_V5 || ARM_SINGLE_ARCH_VERSATILE
>> +       default y if ARM_SINGLE_ARCH_VERSATILE
>>          select ARM_AMBA
>>          select ARM_TIMER_SP804
>>          select ARM_VIC
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> 
