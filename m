From: vw@iommu.org (Wan Zongshun)
Date: Sat, 9 Jul 2016 11:25:19 +0800
Subject: [PATCH 4/6] irqchip: add irqchip driver for nuc900
In-Reply-To: <8706947.5rzUDVsB2F@wuerfel>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-5-git-send-email-vw@iommu.org> <8706947.5rzUDVsB2F@wuerfel>
Message-ID: <57806E9F.3020407@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016?06?29? 23:27, Arnd Bergmann wrote:
> On Saturday, June 25, 2016 6:37:20 PM CEST Wan Zongshun wrote:
>> +#define IRQ_WDT		W90X900_IRQ(1)
>> +#define IRQ_WWDT	W90X900_IRQ(2)
>> +#define IRQ_LVD		W90X900_IRQ(3)
>> +#define IRQ_EXT0	W90X900_IRQ(4)
>> +#define IRQ_EXT1	W90X900_IRQ(5)
>> +#define IRQ_EXT2	W90X900_IRQ(6)
>> +#define IRQ_EXT3	W90X900_IRQ(7)
>> +#define IRQ_EXT4	W90X900_IRQ(8)
>> +#define IRQ_EXT5	W90X900_IRQ(9)
>> +#define IRQ_EXT6	W90X900_IRQ(10)
>
> I'd suggest dropping the list, the contents are now in the dts.

Arnd, I will drop this file later, since old w90x900 plat still need it.
but I will remove the Macros related to nuc970 and avoid nuc970 
interrupt using those Macro.

But I still need hack this irqs.h like below, since here NR_IRQS defined 
and it is need for nuc970 irqchip driver.

#if !defined(CONFIG_SOC_NUC900)
#define NR_IRQS		(IRQ_ADC+1)
#else
#define NR_IRQS		62
#endif

>
>> diff --git a/arch/arm/mach-w90x900/include/mach/nuc970-regs-aic.h b/arch/arm/mach-w90x900/include/mach/nuc970-regs-aic.h
>> new file mode 100644
>> index 0000000..7a77016
>> --- /dev/null
>> +++ b/arch/arm/mach-w90x900/include/mach/nuc970-regs-aic.h
>> @@ -0,0 +1,53 @@
>> +#ifndef __ASM_ARCH_REGS_AIC_H
>> +#define __ASM_ARCH_REGS_AIC_H
>> +
>> +/*NUC970 AIC regs*/
>> +
>> +#define	REG_AIC_SCR1	0x00
>> +#define	REG_AIC_SCR2	0x04
>> +#define	REG_AIC_SCR3	0x08
>> +#define	REG_AIC_SCR4	0x0C
>> +#define	REG_AIC_SCR5	0x10
>
> And like the clk driver, these should all be in the irqchip driver instead
> of a separate header.
>
>> +
>> +static void __iomem *aic_base;
>> +static struct irq_domain *aic_domain;
>> +#define MAKE_HWIRQ(irqnum)	(irqnum)
>
> The macro appears to be unused.
>
>> +static void nuc970_irq_mask(struct irq_data *d)
>> +{
>> +	if (d->irq < 32)
>> +		__raw_writel(1 << (d->irq), aic_base + REG_AIC_MDCR);
>> +	else
>> +		__raw_writel(1 << (d->irq - 32), aic_base + REG_AIC_MDCRH);
>> +}
>
> writel()
>
> 	Arnd
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
