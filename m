From: robherring2@gmail.com (Rob Herring)
Date: Thu, 03 Jan 2013 16:04:59 -0600
Subject: [PATCH v4 09/19] ARM: use common irqchip_init for GIC init
In-Reply-To: <201301032141.19568.arnd@arndb.de>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-10-git-send-email-robherring2@gmail.com>
 <201301032141.19568.arnd@arndb.de>
Message-ID: <50E6008B.7050303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2013 03:41 PM, Arnd Bergmann wrote:
> On Thursday 03 January 2013, Rob Herring wrote:
>> @@ -637,8 +638,6 @@ static int __init combiner_of_init(struct device_node *np,
>>  }
>>  
>>  static const struct of_device_id exynos_dt_irq_match[] = {
>> -       { .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
>> -       { .compatible = "arm,cortex-a15-gic", .data = gic_of_init, },
>>         { .compatible = "samsung,exynos4210-combiner",
>>                         .data = combiner_of_init, },
>>         {},
>> @@ -654,8 +653,10 @@ void __init exynos4_init_irq(void)
>>         if (!of_have_populated_dt())
>>                 gic_init_bases(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU, gic_bank_offset, NULL);
>>  #ifdef CONFIG_OF
>> -       else
>> +       else {
>> +               irqchip_init();
>>                 of_irq_init(exynos_dt_irq_match);
>> +       }
>>  #endif
> 
> Is this an equivalent change? I thought you are supposed to call of_irq_init
> only once so it can see the entire hierarchy. Or is it ok as long as the
> top-level controllers are probed first?

Yes, it is equivalent as the GIC will be initialized first. Ideally,
this the exynos controller needs to be moved to drivers/irqchip as well
and this can be removed, but I can't have all the fun.

Rob
