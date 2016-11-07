From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 7 Nov 2016 22:29:41 +0530
Subject: [3/4] ARM: EXYNOS: Remove static mapping of SCU SFR
In-Reply-To: <582007F1.5050803@samsung.com>
References: <1478230764-13748-4-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161104132822epcas3p1e87e73117ab69f4615c220714d73deae@epcas3p1.samsung.com>
 <581C8C8F.5080100@samsung.com> <581FE87E.2040607@samsung.com>
 <582007F1.5050803@samsung.com>
Message-ID: <CAGcde9FyZw4GKQitT94_6v9B=rL3YiWbVbNHrDBEBU+qXQaM+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alim,

On 7 November 2016 at 10:19, Alim Akhtar <alim.akhtar@samsung.com> wrote:
>
> Hi Pankaj,
>
>
> On 11/07/2016 08:05 AM, pankaj.dubey wrote:
>>
>> Hi Alim,
>>
>> On Friday 04 November 2016 06:56 PM, Alim Akhtar wrote:
>>>
>>> Hi Pankaj,
>>>
>>> On 11/04/2016 09:09 AM, Pankaj Dubey wrote:
>>>>
>>>> Lets remove static mapping of SCU SFR mainly used in CORTEX-A9 SoC
>>>> based boards.
>>>> Instead use mapping from device tree node of SCU.
>>>>
>>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>> ---
>>>>    arch/arm/mach-exynos/exynos.c                | 22
>>>> ----------------------
>>>>    arch/arm/mach-exynos/include/mach/map.h      |  2 --
>>>>    arch/arm/mach-exynos/platsmp.c               | 18 +++++++++++-------
>>>>    arch/arm/mach-exynos/pm.c                    | 14 +++++++++++---
>>>>    arch/arm/mach-exynos/suspend.c               | 15 +++++++++++----
>>>>    arch/arm/plat-samsung/include/plat/map-s5p.h |  4 ----
>>>>    6 files changed, 33 insertions(+), 42 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-exynos/exynos.c
>>>> b/arch/arm/mach-exynos/exynos.c
>>>> index 757fc11..fa08ef9 100644
>>>> --- a/arch/arm/mach-exynos/exynos.c
>>>> +++ b/arch/arm/mach-exynos/exynos.c
>>>> @@ -28,15 +28,6 @@
>>>>
>>>>    #include "common.h"
>>>>
>>>> -static struct map_desc exynos4_iodesc[] __initdata = {
>>>> -    {
>>>> -        .virtual    = (unsigned long)S5P_VA_COREPERI_BASE,
>>>> -        .pfn        = __phys_to_pfn(EXYNOS4_PA_COREPERI),
>>>> -        .length        = SZ_8K,
>>>> -        .type        = MT_DEVICE,
>>>> -    },
>>>> -};
>>>> -
>>>>    static struct platform_device exynos_cpuidle = {
>>>>        .name              = "exynos_cpuidle",
>>>>    #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
>>>> @@ -99,17 +90,6 @@ static int __init exynos_fdt_map_chipid(unsigned
>>>> long node, const char *uname,
>>>>        return 1;
>>>>    }
>>>>
>>>> -/*
>>>> - * exynos_map_io
>>>> - *
>>>> - * register the standard cpu IO areas
>>>> - */
>>>> -static void __init exynos_map_io(void)
>>>> -{
>>>> -    if (soc_is_exynos4())
>>>> -        iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
>>>> -}
>>>> -
>>>>    static void __init exynos_init_io(void)
>>>>    {
>>>>        debug_ll_io_init();
>>>> @@ -118,8 +98,6 @@ static void __init exynos_init_io(void)
>>>>
>>>>        /* detect cpu id and rev. */
>>>>        s5p_init_cpu(S5P_VA_CHIPID);
>>>> -
>>>> -    exynos_map_io();
>>>>    }
>>>>
>>>>    /*
>>>> diff --git a/arch/arm/mach-exynos/include/mach/map.h
>>>> b/arch/arm/mach-exynos/include/mach/map.h
>>>> index 5fb0040..0eef407 100644
>>>> --- a/arch/arm/mach-exynos/include/mach/map.h
>>>> +++ b/arch/arm/mach-exynos/include/mach/map.h
>>>> @@ -18,6 +18,4 @@
>>>>
>>>>    #define EXYNOS_PA_CHIPID        0x10000000
>>>>
>>>> -#define EXYNOS4_PA_COREPERI        0x10500000
>>>> -
>>>>    #endif /* __ASM_ARCH_MAP_H */
>>>> diff --git a/arch/arm/mach-exynos/platsmp.c
>>>> b/arch/arm/mach-exynos/platsmp.c
>>>> index a5d6841..553d0d9 100644
>>>> --- a/arch/arm/mach-exynos/platsmp.c
>>>> +++ b/arch/arm/mach-exynos/platsmp.c
>>>> @@ -224,11 +224,6 @@ static void write_pen_release(int val)
>>>>        sync_cache_w(&pen_release);
>>>>    }
>>>>
>>>> -static void __iomem *scu_base_addr(void)
>>>> -{
>>>> -    return (void __iomem *)(S5P_VA_SCU);
>>>> -}
>>>> -
>>>>    static DEFINE_SPINLOCK(boot_lock);
>>>>
>>>>    static void exynos_secondary_init(unsigned int cpu)
>>>> @@ -387,14 +382,23 @@ fail:
>>>>
>>>>    static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
>>>>    {
>>>> +    struct device_node *np;
>>>> +    void __iomem *scu_base;
>>>>        int i;
>>>>
>>>>        exynos_sysram_init();
>>>>
>>>>        exynos_set_delayed_reset_assertion(true);
>>>>
>>>> -    if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
>>>> -        scu_enable(scu_base_addr());
>>>> +    if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
>>>> +        np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>>>
>>>
>>> what if of_find_compatible_node() fails? May be add a error check for
>>> the same?
>>
>>
>> Thanks for review.
>>
>> You are right of_find_compatible_node() is bound to fail, but only in
>> case supplied compatible is missing in DT. In our case this piece of
>> code will execute only for Cortex-A9 based SoC (which in case of Exynos
>> SoC is applicable only for Exynos4 series) and we will for sure
>> providing "arm,cortex-a9-scu" in DT, so there is no chance of failure.
>> So I feel extra check on "np" for NULL will add no benefit here.
>>
> Well I am not entirely convenience here, I still feel it better to have those check, lets not assume anything about future, but when I see of_find_compatible_node() uses elsewhere in kernel, both kind of uses are there (with/without error check).
> So, I leave it to you and maintainer to take a call on this, otherwise this patch looks good.
>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>

Well, I further checked details of of_find_compatible_node() and
of_iomap and below is function call chain

of_find_compatible_node  //Returns vaild pointer for match, and NULL
for no match
   --> __of_device_is_compatible () //Returns 0 for no match, and a
positive integer on match

So in our case lets say for any reason "arm,cortex-a9-scu" compatible
is not present, "np" will be set as NULL.

Next we have following line without check on "np" for NULL,
scu_base = of_iomap(np, 0);

If we see function call sequence of of_iomap we have,

of_iomap(..)  //Returns NULL is of_address_to_resource returns non-zero
   --> of_address_to_resource(...) // Returns -EINVAL if "addrp" is NULL
         --> of_get_address(...)  //Returns NULL if "parent" is NULL
               --> of_get_parent(...)  //Returns np with refcount
incremented if np is NOT NULL else returns NULL

So in our case we will get scu_base as NULL if we pass "np" as NULL,
and on very next line we have check on scu_base, which will prevent us
from de-referencing a NULL pointer. So there won't be any CRASH or
abnormal behavior, due to not checking "np" for NULL.

I think this is the reason in many places in kernel there is no check
for NULL for of_find_compatible_node, surely some places there are
checks, but as per current code flow if someone is calling of_iomap
with np as NULL there won't be any crash and of_iomap will gracefully
returns NULL in that case. Also of_node_put and of_node_get has check
for NULL received device_node and handles it gracefully.

But one thing I missed is that in case scu_base is NULL we are not
suppose to move ahead in function exynos_smp_prepare_cpus(..), This
part I will update and post next version with appropriate change.

Thanks,
Pankaj Dubey

>>
>>
>> Thanks,
>> Pankaj Dubey
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
