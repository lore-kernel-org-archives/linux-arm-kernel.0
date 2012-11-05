From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 5 Nov 2012 17:36:04 +0000
Subject: [PATCH] ARM: Fix the "WFI" instruction opcode definition.
In-Reply-To: <CAKw8HL0ymmNRB=jgGcZn1+6k0s=FKA+qBV04y_wfeu7xMpUpkw@mail.gmail.com>
References: <DA41BE1DDCA941489001C7FBD7A8820E3CB5512E@szxeml549-mbx.china.huawei.com>
 <5091D13B.6060106@gmail.com>
 <CAKw8HL0ymmNRB=jgGcZn1+6k0s=FKA+qBV04y_wfeu7xMpUpkw@mail.gmail.com>
Message-ID: <20121105173604.GF2005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 09:40:10PM +0800, Fei Yang wrote:
> 2012/11/1 Rob Herring <robherring2@gmail.com>:
> > On 10/31/2012 08:24 PM, Yangfei (Felix) wrote:
> >> The current "WFI" opcode definiton causes CPU hot-plug feature fails to
> >> work
> >> if the kernel is built with CONFIG_THUMB2_KERNEL/CONFIG_CPU_ENDIAN_BE8
> >> being
> >> defined. An invalid instruction exception will be generated.
> >>
> >> Signed-off-by: yangfei.kernel at gmail.com
> >> ---
> >>  arch/arm/mach-exynos/hotplug.c   |    8 +++++++-
> >>  arch/arm/mach-realview/hotplug.c |    8 +++++++-
> >>  arch/arm/mach-shmobile/hotplug.c |    8 +++++++-
> >>  3 files changed, 21 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-exynos/hotplug.c
> >> b/arch/arm/mach-exynos/hotplug.c
> >> index f4d7dd2..823a0e4 100644
> >> --- a/arch/arm/mach-exynos/hotplug.c
> >> +++ b/arch/arm/mach-exynos/hotplug.c
> >> @@ -18,11 +18,17 @@
> >>  #include <asm/cacheflush.h>
> >>  #include <asm/cp15.h>
> >>  #include <asm/smp_plat.h>
> >> +#include <asm/opcodes.h>
> >>
> >>  #include <mach/regs-pmu.h>
> >>
> >>  #include "common.h"
> >>
> >> +/*
> >> + * Define opcode of the WFI instruction.
> >> + */
> >> +#define __WFI __inst_arm_thumb16(0xe320f003, 0xbf30)
> >> +
> >>  static inline void cpu_enter_lowpower(void)
> >>  {
> >>       unsigned int v;
> >> @@ -72,7 +78,7 @@ static inline void platform_do_lowpower(unsigned int
> >> cpu, int *spurious)
> >>               /*
> >>                * here's the WFI
> >>                */
> >> -             asm(".word      0xe320f003\n"
> >> +             asm(__WFI
> >
> > Wouldn't using the actual wfi instruction fix this. There is a wfi()
> > macro.
> >
> > Or just call cpu_do_idle() which will do any other things needed before
> > wfi like a dsb instruction.
> >
> > Rob
> >>                   :
> >>                   :
> >>                   : "memory", "cc");
> 
> <Cut>
> 
> Hi Rob,
>     Thanks for the reply. The way you suggested is more elegant. But
> here we worried about the version of the compiler toolchain used to
> build the kernel. The "WFI" assembler instruction may not be
> recognized if the toolchain is too old. Need the related ARM board
> maintainers to confirm this.

Maybe all the exynos platforms are new enough for this not to be a
problem?

I think mach-exynos is pretty new and v7-only anyway.  If so, then it
may be better to put

CFLAGS_hotplug.o	:= -march=armv7-a

in arch/arm/mach-exynos/Makefile, and use the real "wfi" mnemonic
directly.  People should _really_ not be building kernels containig
v7 board support with tools that are too old to support this.

Cheers
---Dave
