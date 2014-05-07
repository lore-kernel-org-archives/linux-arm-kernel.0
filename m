From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 7 May 2014 23:56:19 +0530
Subject: [PATCH v2 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM
 bindings
In-Reply-To: <536A675F.9040204@samsung.com>
References: <1399363824-23543-1-git-send-email-sachin.kamat@linaro.org>
 <53691187.80101@gmail.com>
 <CAK9yfHz6PVT2C-TZkFHqtdj4rT-R8w+aU=jTTnLMF5k4JOXGxg@mail.gmail.com>
 <536A675F.9040204@samsung.com>
Message-ID: <CAK9yfHwH_nwjKjOa3ea3RYK8VEgVbo1ax9xOwvSB8zhoksDHog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 7 May 2014 22:33, Tomasz Figa <t.figa@samsung.com> wrote:
> On 06.05.2014 20:09, Sachin Kamat wrote:
> [snip]
>> On 6 May 2014 22:14, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> [snip]
>>> On 06.05.2014 10:10, Sachin Kamat wrote:
> [snip]
>>>> diff --git a/arch/arm/mach-exynos/platsmp.c
>>>> b/arch/arm/mach-exynos/platsmp.c
>>>> index 03e5e9f94705..ccbcdd7b8a86 100644
>>>> --- a/arch/arm/mach-exynos/platsmp.c
>>>> +++ b/arch/arm/mach-exynos/platsmp.c
>>>> @@ -20,6 +20,7 @@
>>>>   #include <linux/jiffies.h>
>>>>   #include <linux/smp.h>
>>>>   #include <linux/io.h>
>>>> +#include <linux/of_address.h>
>>>>
>>>>   #include <asm/cacheflush.h>
>>>>   #include <asm/smp_plat.h>
>>>> @@ -33,11 +34,35 @@
>>>>
>>>>   extern void exynos4_secondary_startup(void);
>>>>
>>>> +static void __iomem *sram_base_addr;
>>>> +void __iomem *sram_ns_base_addr;
>>>
>>>
>>> This is probably just a matter of preference, but I'd make this static and
>>> provide a getter function, like exynos_get_sram_ns_base();
>>>
>>> Also this address seems to be used by the firmware code exclusively. If we
>>> want to make the firmware code more self-contained, maybe the mapping of
>>> firmware-specific SRAM region could be handled there, instead? This would
>>> also eliminate the need for having an exported variable or getter function.
>>> What do you think?
>>
>> I thought of the same. However 2 reasons prevented me from implementing this.
>>
>> 1. Code duplication
>> 2. This code should be executed only once. I put it in exynos_firmware_init.
>> However it gave a crash while doing of_iomap. So moved it back to the current
>> location.
>>
>
> Right, exynos_firmware_init() is called too early, before ioremap() is
> available, so there is no good place to put this in firmware code. So,
> let's keep this as is for now and eventually move it to firmware if
> needed and/or a proper method of initialization is available.

OK.

>
>>>
>>>
>>>> +
>>>> +static void __init exynos_smp_prepare_sram(void)
>>>> +{
>>>> +       struct device_node *node;
>>>> +
>>>> +       for_each_compatible_node(node, NULL, "samsung,exynos4210-sram") {
>>>> +               if (of_device_is_available(node)) {
>>>> +                       sram_base_addr = of_iomap(node, 0);
>>>> +                       if (!sram_base_addr)
>>>> +                               pr_err("Secondary CPU boot address not
>>>> found\n");
>>>
>>>
>>> I don't think this is an error at this stage. Some platforms might not have
>>> either of these SRAM reserved regions (such as those using INFORM registers
>>> instead). Instead, the base address should be checked whenever it is needed
>>> and errors should be handled then, like in exynos_set_cpu_boot_addr().
>>
>> Yes. This is more from an information perspective. Probably pr_warn or
>> pr_info would
>> be better?
>>
>
> IMHO this shouldn't produce any messages at this stage. Just whenever
> either of addresses is actually needed and is not initialized a message
> should be printed.

OK.

>>>> +}
>>>> +
>>>>   static inline void __iomem *cpu_boot_reg_base(void)
>>>>   {
>>>>         if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
>>>>                 return S5P_INFORM5;
>>>> -       return S5P_VA_SYSRAM;
>>>> +       return sram_base_addr;
>>>>   }
>>>>
>>>>   static inline void __iomem *cpu_boot_reg(int cpu)
>>>> @@ -147,7 +172,8 @@ static int exynos_boot_secondary(unsigned int cpu,
>>>> struct task_struct *idle)
>>>>                  * and fall back to boot register if it fails.
>>>>                  */
>>>>                 if (call_firmware_op(set_cpu_boot_addr, phys_cpu,
>>>> boot_addr))
>>>> -                       __raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
>>>> +                       if (cpu_boot_reg_base())
>>>> +                               __raw_writel(boot_addr,
>>>> cpu_boot_reg(phys_cpu));
>>>
>>>
>>> I'd rework this for proper error handling, e.g.
>>>
>>>         int ret;
>>>
>>>         /* ... */
>>>
>>>         ret = call_firmware_op(set_cpu_boot_addr, phys_cpu, boot_addr);
>>>         if (ret && ret != -ENOSYS)
>>>                 goto fail;
>>>         if (ret == -ENOSYS) {
>>>                 /* Fall back to firmware-less way. */
>>>                 void __iomem *boot_reg = cpu_boot_reg(phys_cpu);
>>>
>>>                 if (IS_ERR(boot_reg)) {
>>>                         ret = PTR_ERR(boot_reg);
>>>                         goto fail;
>>>                 }
>>>         }
>>>
>>>         /* ... */
>>>
>>> fail:
>>>         /* Clean-up after error */
>>>
>>> Of course, cpu_boot_reg() will need to be converted to follow the ERR_PTR()
>>> model, but IMHO proper error handling is a good reason to do so.
>>
>> How about handling this separately outside this patch?
>>
>
> This patch is already changing surroundings of this code, so I'd say it
> should do it the right way from the start.

Yes, I have incorporated it in my patch. Will send the same tomorrow.

-- 
With warm regards,
Sachin
