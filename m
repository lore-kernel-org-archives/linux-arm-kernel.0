From: yangfei.kernel@gmail.com (Fei Yang)
Date: Mon, 22 Oct 2012 19:01:00 +0800
Subject: [RFC PATCH v2] ARM hardcoded instruction causes cpu-hotplug fail
 to work on big-endian platfrom
Message-ID: <CAKw8HL3UuPSUf3_W-JX7rmQxbwhkHQCdOyTgrT0N5oa2_HCL0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/17 Fei Yang <yangfei.kernel@gmail.com>:
> <cut>
>
>> Not handling the Thumb case is a definite bug for any file which may
>> run on v7, since the kernel could be built in Thumb for that case.
>> For example, the existing code is mach-realview/hotplug.c is broken
>> when building an SMP Thumb-2 kernel for the Realview PBX-A9.
>>
>> Cheers
>> ---Dave
>
> Thanks for pointing this out. I think we just cannot make any
> assumption about the versions of the tools used. Based on this, I have
> made a v2 of the patch against linux-3.7-rc1. I am not touching the
> CFLAGS in the patch as I am not familiar with the three ARM boards
> here.
> Can the respective board maintainers
> (mach-exynos/mach-realveiw/mach-shmobile) give any comments about v2
> of the patch?
>
> Thanks.
> ---Fei
>
> v2: Define opcode of the ARM "WFI" instruction in the right way.
>
> Signed-off-by: Fei Yang<yangfei.kernel@gmail.com>
>
> diff -urN linux-3.7-rc1/arch/arm/mach-exynos/hotplug.c
> linux/arch/arm/mach-exynos/hotplug.c
> --- linux-3.7-rc1/arch/arm/mach-exynos/hotplug.c        2012-10-15
> 05:41:04.000000000 +0800
> +++ linux/arch/arm/mach-exynos/hotplug.c        2012-10-17 19:25:49.000000000 +0800
> @@ -18,11 +18,17 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cp15.h>
>  #include <asm/smp_plat.h>
> +#include <asm/opcodes.h>
>
>  #include <mach/regs-pmu.h>
>
>  #include "common.h"
>
> +/*
> + * Define opcode of the WFI instruction.
> + */
> +#define __WFI __inst_arm_thumb16(0xe320f003, 0xbf30)
> +
>  static inline void cpu_enter_lowpower(void)
>  {
>         unsigned int v;
> @@ -72,7 +78,7 @@
>                 /*
>                  * here's the WFI
>                  */
> -               asm(".word      0xe320f003\n"
> +               asm(__WFI
>                     :
>                     :
>                     : "memory", "cc");
> diff -urN linux-3.7-rc1/arch/arm/mach-realview/hotplug.c
> linux/arch/arm/mach-realview/hotplug.c
> --- linux-3.7-rc1/arch/arm/mach-realview/hotplug.c      2012-10-15
> 05:41:04.000000000 +0800
> +++ linux/arch/arm/mach-realview/hotplug.c      2012-10-17 19:25:20.000000000 +0800
> @@ -15,6 +15,12 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cp15.h>
>  #include <asm/smp_plat.h>
> +#include <asm/opcodes.h>
> +
> +/*
> + * Define opcode of the WFI instruction.
> + */
> +#define __WFI __inst_arm_thumb16(0xe320f003, 0xbf30)
>
>  static inline void cpu_enter_lowpower(void)
>  {
> @@ -64,7 +70,7 @@
>                 /*
>                  * here's the WFI
>                  */
> -               asm(".word      0xe320f003\n"
> +               asm(__WFI
>                     :
>                     :
>                     : "memory", "cc");
> diff -urN linux-3.7-rc1/arch/arm/mach-shmobile/hotplug.c
> linux/arch/arm/mach-shmobile/hotplug.c
> --- linux-3.7-rc1/arch/arm/mach-shmobile/hotplug.c      2012-10-15
> 05:41:04.000000000 +0800
> +++ linux/arch/arm/mach-shmobile/hotplug.c      2012-10-17 19:25:34.000000000 +0800
> @@ -20,6 +20,12 @@
>  #include <mach/emev2.h>
>  #include <asm/cacheflush.h>
>  #include <asm/mach-types.h>
> +#include <asm/opcodes.h>
> +
> +/*
> + * Define opcode of the WFI instruction.
> + */
> +#define __WFI __inst_arm_thumb16(0xe320f003, 0xbf30)
>
>  static cpumask_t dead_cpus;
>
> @@ -39,7 +45,7 @@
>                 /*
>                  * here's the WFI
>                  */
> -               asm(".word      0xe320f003\n"
> +               asm(__WFI
>                     :
>                     :
>                     : "memory", "cc");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

Hi,

    Any comments on this patch? It is posted last week. Please let me
know if I missed anything.
    Thanks.

    ---Fei
