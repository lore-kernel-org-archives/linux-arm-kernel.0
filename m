From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 14 Nov 2016 21:50:04 +0530
Subject: [PATCH 03/16] ARM: berlin: use generic API for enabling SCU
In-Reply-To: <20161114165134.411ae04b@xhacker>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-4-git-send-email-pankaj.dubey@samsung.com>
 <20161114165134.411ae04b@xhacker>
Message-ID: <CAGcde9EeV15V6_0fqD3U8tg0ERMAWhn3AjhvbYB4M5QeKLFn6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On 14 November 2016 at 14:21, Jisheng Zhang <jszhang@marvell.com> wrote:
> Hi Pankaj,
>
> On Mon, 14 Nov 2016 10:31:58 +0530 Pankaj Dubey wrote:
>
>> Now as we have of_scu_enable which takes care of mapping
>> scu base from DT, lets use it.
>>
>> CC: Jisheng Zhang <jszhang@marvell.com>
>> CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  arch/arm/mach-berlin/platsmp.c | 17 +++++------------
>>  1 file changed, 5 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
>> index 93f9068..25a6ca5 100644
>> --- a/arch/arm/mach-berlin/platsmp.c
>> +++ b/arch/arm/mach-berlin/platsmp.c
>> @@ -60,26 +60,21 @@ static int berlin_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>  static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
>>  {
>>       struct device_node *np;
>> -     void __iomem *scu_base;
>>       void __iomem *vectors_base;
>>
>> -     np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>> -     scu_base = of_iomap(np, 0);
>> -     of_node_put(np);
>> -     if (!scu_base)
>> -             return;
>> -
>>       np = of_find_compatible_node(NULL, NULL, "marvell,berlin-cpu-ctrl");
>>       cpu_ctrl = of_iomap(np, 0);
>>       of_node_put(np);
>>       if (!cpu_ctrl)
>> -             goto unmap_scu;
>> +             return;
>>
>>       vectors_base = ioremap(CONFIG_VECTORS_BASE, SZ_32K);
>>       if (!vectors_base)
>> -             goto unmap_scu;
>> +             return;
>> +
>> +     if (of_scu_enable())
>
> In err code path, we need to unmap vectors_base before return
>

You are correct. I missed this, Will update in v2.

Thanks for review.

Pankaj Dubey

>> +             return;
>>
>> -     scu_enable(scu_base);
>>       flush_cache_all();
>>
>>       /*
>> @@ -95,8 +90,6 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
>>       writel(virt_to_phys(secondary_startup), vectors_base + SW_RESET_ADDR);
>>
>>       iounmap(vectors_base);
>> -unmap_scu:
>> -     iounmap(scu_base);
>>  }
>>
>>  #ifdef CONFIG_HOTPLUG_CPU
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
