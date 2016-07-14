From: vw@iommu.org (Wan Zongshun)
Date: Thu, 14 Jul 2016 16:52:29 +0800
Subject: [PATCH v2 02/10] irqchip: add irqchip driver for nuc900
In-Reply-To: <5434334.4rKzx80y6W@wuerfel>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1761342.TGgYi16yul@wuerfel> <5784968A.7080007@iommu.org>
 <5434334.4rKzx80y6W@wuerfel>
Message-ID: <578752CD.3010408@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?07?12? 16:26, Arnd Bergmann wrote:
> On Tuesday, July 12, 2016 3:04:42 PM CEST Wan Zongshun wrote:
>>>
>>> Ideally, this should just go away once we use SPARSE_IRQ.
>>
>> This platform also can use SPARSE_IRQ? this just a simple irq map and no
>> more irq number in this Soc.
>>
>
> SPARSE_IRQ is implied by ARCH_MULTIPLATFORM, so we will have to
> use it once that gets enabled.
>
> Your new irqchip driver already handles IRQ domains, so it will
> work out of the box with SPARSE_IRQ, but you have to change the
> reference to "NR_IRQS" into something else.
>
> I've prototyped a patch series to enable ARCH_MULTIPLATFORM,
> I hope you can start working from what I have and get it to run.

I go through the ARCH_MULTIPLATFORM and SPARSE_IRQ related codes, but I 
find I also have to define the NUC900_NR_IRQS firstly like below, so 
that I can init the .nr_irq.

+#if !defined(CONFIG_SOC_NUC970)
  #define NUC900_NR_IRQS		(IRQ_ADC+1)
+#else
+#define NUC900_NR_IRQS		62
+#endif

  DT_MACHINE_START(nuc900_dt, "Nuvoton NUC900 (Device Tree Support)")
         .dt_compat      = nuc900_dt_compat,
+       .nr_irqs        = NUC900_NR_IRQS,
  MACHINE_END

and then in my irqchip driver, I will use the NUC900_NR_IRQS:

+aic_domain = irq_domain_add_linear(node, NUC900_NR_IRQS,
+				    &aic_irq_domain_ops, NULL);


Is that a right usage?

>
> 	Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
