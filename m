From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 18 Dec 2012 23:34:35 +0000
Subject: [PATCH] ARM: VIC: use irq_domain_add_simple()
In-Reply-To: <507D61E7.2080704@gmail.com>
References: <1350392786-29191-1-git-send-email-linus.walleij@stericsson.com>
 <507D61E7.2080704@gmail.com>
Message-ID: <CACxGe6tBLfj3CDDZAfGmznj3B-h4OfJsrRc+85w9fnxFH6Cd_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

It looks to me like the below patch breaks versatile because it makes
it try to register a linear irq_domain instead of the legacy one that
it needs. Here are the relevant commits:

07c9249f1: "ARM: 7554/1: VIC: use irq_domain_add_simple()"
946c59a08: "ARM: vic: fix build warning caused by previous commit"

I'm working on getting it properly sorted out (and more importantly
*simplified*), but in the mean time I think the above two commits need
to be reverted. Reverting them on my tree fixes booting for me.

g.

On Tue, Oct 16, 2012 at 2:32 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 10/16/2012 08:06 AM, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> Instead of allocating descriptors on-the-fly for the device tree
>> initialization case, use irq_domain_add_simple() which will take
>> care of this if you pass negative as the first_irq.
>>
>> Alter the signature of __vic_init() to pass the first_irq as
>> signed so this works as expected.
>>
>> Switching the VIC to use irq_domain_add_simple() also has the
>> upside of displaying the same WARNING when you boot with
>> pre-allocated descriptors on systems using SPARSE_IRQ but
>> yet not using device tree.
>>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
>
> Rob
>
>> ---
>>  arch/arm/common/vic.c               | 18 ++++++------------
>>  arch/arm/include/asm/hardware/vic.h |  2 +-
>>  2 files changed, 7 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
>> index e0d5388..4fd5d98 100644
>> --- a/arch/arm/common/vic.c
>> +++ b/arch/arm/common/vic.c
>> @@ -218,7 +218,7 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
>>       v->resume_sources = resume_sources;
>>       v->irq = irq;
>>       vic_id++;
>> -     v->domain = irq_domain_add_legacy(node, fls(valid_sources), irq, 0,
>> +     v->domain = irq_domain_add_simple(node, fls(valid_sources), irq,
>>                                         &vic_irqdomain_ops, v);
>>  }
>>
>> @@ -350,7 +350,7 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
>>       vic_register(base, irq_start, vic_sources, 0, node);
>>  }
>>
>> -void __init __vic_init(void __iomem *base, unsigned int irq_start,
>> +void __init __vic_init(void __iomem *base, int irq_start,
>>                             u32 vic_sources, u32 resume_sources,
>>                             struct device_node *node)
>>  {
>> @@ -416,18 +416,12 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
>>       if (WARN_ON(!regs))
>>               return -EIO;
>>
>> -     irq_base = irq_alloc_descs(-1, 0, 32, numa_node_id());
>> -     if (WARN_ON(irq_base < 0))
>> -             goto out_unmap;
>> -
>> -     __vic_init(regs, irq_base, ~0, ~0, node);
>> +     /*
>> +      * Passing -1 as first IRQ makes the simple domain allocate descriptors
>> +      */
>> +     __vic_init(regs, -1, ~0, ~0, node);
>>
>>       return 0;
>> -
>> - out_unmap:
>> -     iounmap(regs);
>> -
>> -     return -EIO;
>>  }
>>  #endif /* CONFIG OF */
>>
>> diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
>> index e14af1a..2bebad3 100644
>> --- a/arch/arm/include/asm/hardware/vic.h
>> +++ b/arch/arm/include/asm/hardware/vic.h
>> @@ -47,7 +47,7 @@
>>  struct device_node;
>>  struct pt_regs;
>>
>> -void __vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources,
>> +void __vic_init(void __iomem *base, int irq_start, u32 vic_sources,
>>               u32 resume_sources, struct device_node *node);
>>  void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
>>  int vic_of_init(struct device_node *node, struct device_node *parent);
>>
>



--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
