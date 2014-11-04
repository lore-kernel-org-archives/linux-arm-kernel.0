From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 04 Nov 2014 14:16:50 +0100
Subject: [PATCH v8 5/9] ARM: irqchip: mxs: add Alpascale ASM9260 support
In-Reply-To: <20141104130320.GB21210@tiger>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
 <1413888020-8790-6-git-send-email-linux@rempel-privat.de>
 <20141104130320.GB21210@tiger>
Message-ID: <5458D1C2.7020502@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.11.2014 um 14:03 schrieb Shawn Guo:
> Thanks Jason for pointing me the thread.
> 
> On Tue, Oct 21, 2014 at 12:40:16PM +0200, Oleksij Rempel wrote:
>> Freescale iMX23/iMX28 and Alphascale ASM9260 have similar
>> interrupt collectors. It makes easy to reuse irq-mxs code for ASM9260.
>> Differences between this devices are fallowing:
>> - different register offsets
>> - different count of intterupt lines per register
>> - ASM9260 don't provide reset bit
>> - ASM9260 don't support FIQ.
>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> ---
>>  drivers/irqchip/Kconfig                    |   9 +++
>>  drivers/irqchip/Makefile                   |   2 +-
>>  drivers/irqchip/alphascale_asm9260-icoll.h | 109 +++++++++++++++++++++++++++++
>>  drivers/irqchip/irq-mxs.c                  | 105 ++++++++++++++++++++++++---
>>  4 files changed, 216 insertions(+), 9 deletions(-)
>>  create mode 100644 drivers/irqchip/alphascale_asm9260-icoll.h
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index b8632bf..10470cb 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -113,3 +113,12 @@ config IRQ_CROSSBAR
>>  	  The primary irqchip invokes the crossbar's callback which inturn allocates
>>  	  a free irq and configures the IP. Thus the peripheral interrupts are
>>  	  routed to one of the free irqchip interrupt lines.
>> +
>> +config IRQ_MXS
>> +	bool "MXS interrupt controller"
>> +	select IRQ_DOMAIN
>> +	select STMP_DEVICE
>> +	default y if MACH_ASM9260 || CONFIG_ARCH_MXS
> 
> s/CONFIG_ARCH_MXS/ARCH_MXS

Right, thank you.

> Even with this change, the 'default y' doesn't seem to work for me.

hm... According to this lines it should work:
-obj-$(CONFIG_ARCH_MXS)			+= irq-mxs.o
+obj-$(CONFIG_IRQ_MXS)			+= irq-mxs.o

>> +	help
>> +	  Support for interrupt controller present in Freescale iMX23/iMX28 and
>> +	  Alphascale ASM9260 SoCs.
> 
> ...
> 
>> diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
>> index 681125d..8c5c3d2 100644
>> --- a/drivers/irqchip/irq-mxs.c
>> +++ b/drivers/irqchip/irq-mxs.c
>> @@ -1,5 +1,7 @@
>>  /*
>>   * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
>> + * Copyright (C) 2014 Oleksij Rempel <linux@rempel-privat.de>
>> + *	Add Alphascale ASM9260 support.
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License as published by
>> @@ -28,6 +30,7 @@
>>  #include <asm/exception.h>
>>  
>>  #include "irqchip.h"
>> +#include "alphascale_asm9260-icoll.h"
>>  
>>  /*
>>   * this device provide 4 offsets for each register:
>> @@ -63,6 +66,33 @@ struct icoll_priv {
>>  
>>  static struct icoll_priv icoll_priv;
>>  static struct irq_domain *icoll_domain;
>> +static DEFINE_RAW_SPINLOCK(icoll_lock);
>> +
>> +/* calculate bit offset depending on number of intterupt per register */
>> +static u32 icoll_intr_bitshift(struct irq_data *d, u32 bit)
>> +{
>> +	/*
>> +	 * We expect intr_per_reg to be 4 or 1, it means
>> +	 * "n" will be 3 or 0.
>> +	 */
>> +	int n = icoll_priv.intr_per_reg - 1;
>> +
>> +	/*
>> +	 * If n = 0, "bit" is never shifted.
>> +	 * If n = 3, mask lower part of hwirq to convert it
>> +	 * in 0, 1, 2 or 3 and then multiply it by 8 (or shift by 3)
>> +	 */
>> +	return bit << ((d->hwirq & n) << n);
>> +}
>> +
>> +/* calculate mem offset depending on number of intterupt per register */
>> +static void __iomem *icoll_intr_reg(struct irq_data *d)
>> +{
>> +	int n = icoll_priv.intr_per_reg >> 1;
>> +
>> +	/* offset = hwirq / intr_per_reg * 0x10 */
>> +	return icoll_priv.intr + ((d->hwirq >> n) * 0x10);
>> +}
>>  
>>  static void icoll_ack_irq(struct irq_data *d)
>>  {
>> @@ -77,14 +107,21 @@ static void icoll_ack_irq(struct irq_data *d)
>>  
>>  static void icoll_mask_irq(struct irq_data *d)
>>  {
>> -	__raw_writel(BM_ICOLL_INTR_ENABLE,
>> -			icoll_priv.intr + CLR_REG + HW_ICOLL_INTERRUPTn(d->hwirq));
>> +	__raw_writel(icoll_intr_bitshift(d, BM_ICOLL_INTR_ENABLE),
>> +			icoll_intr_reg(d) + CLR_REG);
>>  }
>>  
>>  static void icoll_unmask_irq(struct irq_data *d)
>>  {
>> -	__raw_writel(BM_ICOLL_INTR_ENABLE,
>> -			icoll_priv.intr + SET_REG + HW_ICOLL_INTERRUPTn(d->hwirq));
>> +	raw_spin_lock(&icoll_lock);
>> +	if (icoll_priv.clear)
>> +		__raw_writel(ASM9260_BM_CLEAR_BIT(d->hwirq),
>> +				icoll_priv.clear +
>> +				ASM9260_HW_ICOLL_CLEARn(d->hwirq));
>> +
>> +	__raw_writel(icoll_intr_bitshift(d, BM_ICOLL_INTR_ENABLE),
>> +			icoll_intr_reg(d) + SET_REG);
>> +	raw_spin_unlock(&icoll_lock);
>>  }
>>  
>>  static struct irq_chip mxs_icoll_chip = {
>> @@ -116,12 +153,34 @@ static struct irq_domain_ops icoll_irq_domain_ops = {
>>  	.xlate = irq_domain_xlate_onecell,
>>  };
>>  
>> +static void __init icoll_add_domain(struct device_node *np,
>> +			  int num)
>> +{
>> +	icoll_domain = irq_domain_add_linear(np, num,
>> +					     &icoll_irq_domain_ops, NULL);
>> +
>> +	if (!icoll_domain)
>> +		panic("%s: unable add irq domain", np->full_name);
>> +	irq_set_default_host(icoll_domain);
>> +	set_handle_irq(icoll_handle_irq);
>> +}
>> +
>> +static void __iomem * __init icoll_init_iobase(struct device_node *np)
>> +{
>> +	void __iomem *icoll_base;
>> +
>> +	icoll_base = of_io_request_and_map(np, 0, np->name);
> 
>   LD      kernel/built-in.o
> ../drivers/irqchip/irq-mxs.c: In function ?icoll_init_iobase?:
> ../drivers/irqchip/irq-mxs.c:172:2: warning: passing argument 3 of ?of_io_request_and_map? discards ?const? qualifier from pointer target type [enabled by default]
> In file included from ../drivers/irqchip/irq-mxs.c:27:0:
> ../include/linux/of_address.h:108:15: note: expected ?char *? but argument is of type ?const char *?


I reported this issue. It should be fixed in of_io_request_and_map.


>> +	if (!icoll_base)
>> +		panic("%s: unable to map resource", np->full_name);
>> +	return icoll_base;
>> +}
>> +
>>  static int __init icoll_of_init(struct device_node *np,
>>  			  struct device_node *interrupt_parent)
>>  {
>> -	void __iomem *icoll_base = of_iomap(np, 0);
>> -	WARN_ON(!icoll_base);
>> +	void __iomem *icoll_base;
>>  
>> +	icoll_base		= icoll_init_iobase(np);
>>  	icoll_priv.vector	= icoll_base + HW_ICOLL_VECTOR;
>>  	icoll_priv.levelack	= icoll_base + HW_ICOLL_LEVELACK;
>>  	icoll_priv.ctrl		= icoll_base + HW_ICOLL_CTRL;
>> @@ -136,8 +195,38 @@ static int __init icoll_of_init(struct device_node *np,
>>  	 */
>>  	stmp_reset_block(icoll_priv.ctrl);
>>  
>> -	icoll_domain = irq_domain_add_linear(np, ICOLL_NUM_IRQS,
>> -					     &icoll_irq_domain_ops, NULL);
>> +	icoll_add_domain(np, ICOLL_NUM_IRQS);
>> +
>>  	return icoll_domain ? 0 : -ENODEV;
>>  }
>>  IRQCHIP_DECLARE(mxs, "fsl,icoll", icoll_of_init);
>> +
>> +static int __init asm9260_of_init(struct device_node *np,
>> +			  struct device_node *interrupt_parent)
>> +{
>> +	void __iomem *icoll_base;
>> +	int i;
>> +
>> +	icoll_base = icoll_init_iobase(np);
>> +	icoll_priv.vector	= icoll_base + ASM9260_HW_ICOLL_VECTOR;
>> +	icoll_priv.levelack	= icoll_base + ASM9260_HW_ICOLL_LEVELACK;
>> +	icoll_priv.ctrl		= icoll_base + ASM9260_HW_ICOLL_CTRL;
>> +	icoll_priv.stat		= icoll_base + ASM9260_HW_ICOLL_STAT_OFFSET;
>> +	icoll_priv.intr		= icoll_base + ASM9260_HW_ICOLL_INTERRUPT0;
>> +	icoll_priv.intr_per_reg	= 4;
>> +	icoll_priv.clear	= icoll_base + ASM9260_HW_ICOLL_CLEAR0;
>> +
>> +	writel_relaxed(ASM9260_BM_CTRL_IRQ_ENABLE,
>> +			icoll_priv.ctrl);
>> +	/*
>> +	 * ASM9260 don't provide reset bit. So, we need to set level 0
>> +	 * manually.
>> +	 */
>> +	for (i = 0; i < 16 * 0x10; i += 0x10)
>> +		writel(0, icoll_priv.intr + i);
>> +
>> +	icoll_add_domain(np, ASM9260_NUM_IRQS);
>> +
>> +	return icoll_domain ? 0 : -ENODEV;
>> +}
>> +IRQCHIP_DECLARE(asm9260, "alphascale,asm9260-icoll", asm9260_of_init);
>> -- 
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141104/2b00bbe1/attachment-0001.sig>
