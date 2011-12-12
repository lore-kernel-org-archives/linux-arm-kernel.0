From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 12 Dec 2011 21:32:10 +0530
Subject: [RESEND][PATCH] ARM: Exynos: Add irq domain and device tree
 support for interrupt combiner
In-Reply-To: <4EE5781E.2060702@gmail.com>
References: <1323586114-24486-1-git-send-email-thomas.abraham@linaro.org>
 <4EE5781E.2060702@gmail.com>
Message-ID: <CAJuYYwS=d92ra9-R0W0Q8nwv1aPfe192FcOb-5QM9ZnQAO_T3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 12 December 2011 09:12, Rob Herring <robherring2@gmail.com> wrote:
>> +Example:
>> +
>> + ? ? combiner:interrupt-controller at 10440000 {
>> + ? ? ? ? ? ? compatible = "samsung,exynos4120-combiner";
>> + ? ? ? ? ? ? #interrupt-cells = <2>;
>> + ? ? ? ? ? ? interrupt-controoler;
>
> s/controoler/controller/

Ok. I will fix this.

>
>> + ? ? ? ? ? ? reg = <0x10440000 0x1000>;
>> + ? ? };
>
> [snip]
>
>> +
>> +int __init combiner_init_irq_domain(unsigned int irq_base, unsigned int nr_irq,
>
> Make irq_base signed.

Ok.

>
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct device_node *np)
>> +{
>> + ? ? struct irq_domain *domain = &combiner_irq_domain;
>> +
>> + ? ? domain->irq_base = irq_alloc_descs(irq_base, irq_base, nr_irq, 0);
>
> This should be irq_alloc_descs(irq_base, 1,
>
> So that dynamic allocation can work when irq_base is -1.

Ok. I will modify this.

>
>> + ? ? if (domain->irq_base < 0) {
>> + ? ? ? ? ? ? pr_err("failed to alloc irq descs, combiner init failed\n");
>> + ? ? ? ? ? ? return -EBUSY;
>
> On failure, just warn and do:
>
> domain->irq_base = irq_base
>
> instead of returning unless all platforms using this are completely
> converted over to support dynamic Linux virq mapping.

Ok.

>
> Also you should update your platforms' to set mdesc.nr_irq to
> NR_IRQS_LEGACY. And test with SPARSE_IRQ turned on.

Ok. I will test with NR_IRQS_LEGACY. Hope nothing breaks!

Thank you Rob for you review and comments on this patch.

Regards,
Thomas.

>
> Rob
