From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 15 Sep 2014 07:52:54 +0200
Subject: [PATCH 6/7] irqchip: add irq-asm9260 driver
In-Reply-To: <20140914073738.GQ21986@titan.lakedaemon.net>
References: <1410646408-28901-1-git-send-email-linux@rempel-privat.de>
 <1410646408-28901-7-git-send-email-linux@rempel-privat.de>
 <20140914073738.GQ21986@titan.lakedaemon.net>
Message-ID: <54167EB6.2020008@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

thx for review.
How about irq priority system which provide this controller, do it make
sense to implement it? Or it es better to allow kernel make needed decision?

Am 14.09.2014 um 09:37 schrieb Jason Cooper:
> Oleksij,
> 
> On Sun, Sep 14, 2014 at 12:13:27AM +0200, Oleksij Rempel wrote:
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> ---
>>  drivers/irqchip/Makefile      |   1 +
>>  drivers/irqchip/irq-asm9260.c | 237 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 238 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-asm9260.c
> 
> Please don't forget to Cc me, I'm helping tglx with irqchip-related
> stuff.
> 
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index 62a13e5..3400ec8 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -30,3 +30,4 @@ obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
>>  obj-$(CONFIG_XTENSA_MX)			+= irq-xtensa-mx.o
>>  obj-$(CONFIG_IRQ_CROSSBAR)		+= irq-crossbar.o
>>  obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
>> +obj-$(CONFIG_MACH_ASM9260)		+= irq-asm9260.o
>> diff --git a/drivers/irqchip/irq-asm9260.c b/drivers/irqchip/irq-asm9260.c
>> new file mode 100644
>> index 0000000..62e0607
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-asm9260.c
>> @@ -0,0 +1,237 @@
>> +/*
>> + * Copyright (C) 2014 Oleksij Rempel <linux@rempel-privat.de>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write to the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <asm/exception.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +
>> +#include "irqchip.h"
>> +
>> +#define SET_REG 4
>> +#define CLR_REG 8
>> +
>> +#define HW_ICOLL_VECTOR				0x0000
>> +/* bits 31:2
>> + * This register presents the vector address for the interrupt currently
>> + * active on the CPU IRQ input. Writing to this register notifies the
>> + * interrupt collector that the interrupt service routine for the current
>> + * interrupt has been entered.
>> + * The exception trap should have a LDPC instruction from this address:
>> + * LDPC HW_ICOLL_VECTOR_ADDR; IRQ exception at 0xffff0018
>> + */
>> +
>> +#define HW_ICOLL_LEVELACK			0x0010
>> +/* The Interrupt Collector Level Acknowledge Register is used by software to
>> + * indicate the completion of an interrupt on a specific level.
>> + * This register is written at the very end of an interrupt service routine. If
>> + * nesting is used then the CPU irq must be turned on before writing to this
>> + * register to avoid a race condition in the CPU interrupt hardware.
>> + */
>> +#define BM_LEVELn(nr)				BIT(nr)
>> +
>> +#define HW_ICOLL_CTRL				0x0020
>> +/* BM_CTRL_SFTRST and BM_CTRL_CLKGATE are not available on asm9260. */
>> +#define BM_CTRL_SFTRST				BIT(31)
>> +#define BM_CTRL_CLKGATE				BIT(30)
>> +#define BM_CTRL_NO_NESTING			BIT(19)
>> +/* disable interrupt level nesting */
>> +#define BM_CTRL_ARM_RSE_MODE			BIT(18)
>> +/* Set this bit to one enable the RISC32-style read side effect associated with
>> + * the vector address register. In this mode, interrupt in-service is signaled
>> + * by the read of the HW_ICOLL_VECTOR register to acquire the interrupt vector
>> + * address. Set this bit to zero for normal operation, in which the ISR signals
>> + * in-service explicitly by means of a write to the HW_ICOLL_VECTOR register.
>> + * 0 - Must Write to Vector register to go in-service.
>> + * 1 - Go in-service as a read side effect
>> + */
>> +#define BM_CTRL_IRQ_ENABLE			BIT(16)
>> +
>> +#define HW_ICOLL_STAT_OFFSET			0x0030
>> +/* bits 5:0
>> + * Vector number of current interrupt. Multiply by 4 and add to vector base
>> + * address to obtain the value in HW_ICOLL_VECTOR.
>> + */
>> +
>> +#define HW_ICOLL_RAW0				0x0040
>> +#define HW_ICOLL_RAW1				0x0050
>> +/* This register provides a read-only view of the raw interrupt request lines
>> + * coming from various parts of the chip. Its purpose is to improve diagnostic
>> + * observability.
>> + */
> 
> wrt all of the above comment, please follow the kernel coding style:
> 
>   /*
>    * Begin multi-line text.
>    */
> 
> Also, please place the comment _above_ the code it is referring to.
> 
>> +
>> +#define	HW_ICOLL_INTERRUPT0			0x0060
>> +#define	HW_ICOLL_INTERRUPTn(n)			(0x0060 + ((n) >> 2) * 0x10)
>> +#define	HW_ICOLL_INTERRUPTn_SET(n)		(HW_ICOLL_INTERRUPTn(n) \
>> +		+ SET_REG)
>> +#define	HW_ICOLL_INTERRUPTn_CLR(n)		(HW_ICOLL_INTERRUPTn(n) \
>> +		+ CLR_REG)
>> +#define BM_INT_PRIORITY_MASK			0x3
>> +/* WARNING: Modifying the priority of an enabled interrupt may result in
>> + * undefined behavior. */
> 
> multi-line comment style.
> 
>> +#define BM_INT_ENABLE				BIT(2)
>> +#define BM_INT_SOFTIRQ				BIT(3)
>> +
>> +#define BM_ICOLL_INTERRUPTn_SHIFT(n)		(((n) & 0x3) << 3)
>> +#define BM_ICOLL_INTERRUPTn_ENABLE(n)		(1 << (2 + \
>> +			BM_ICOLL_INTERRUPTn_SHIFT(n)))
>> +
>> +#define HW_ICOLL_VBASE				0x0160
>> +/* bits 31:2
>> + * This bitfield holds the upper 30 bits of the base address of the vector
>> + * table. */
>> +
>> +#define HW_ICOLL_CLEAR0				0x01d0
>> +#define	HW_ICOLL_CLEAR1				0x01e0
>> +#define HW_ICOLL_CLEARn(n)			(0x01d0 + ((n >> 5) * 0x10) \
>> +							+ SET_REG)
>> +#define BM_CLEAR_BIT(n)				BIT(n & 0x1f)
>> +
>> +#define HW_ICOLL_UNDEF_VECTOR			0x01f0
>> +/* Scratchpad */
>> +
>> +#define ICOLL_NUM_IRQS		64
>> +
>> +static void __iomem *icoll_base;
>> +static struct irq_domain *icoll_domain;
>> +static int use_cached_level = 1;
>> +static u8 level_cache[ICOLL_NUM_IRQS];
>> +
>> +static unsigned int irq_get_level(struct irq_data *d)
>> +{
>> +	unsigned int tmp;
>> +
>> +	if (use_cached_level)
>> +		return level_cache[d->hwirq];
>> +
>> +	tmp = readl_relaxed(icoll_base + HW_ICOLL_INTERRUPTn_SET(d->hwirq));
>> +	return (tmp >> BM_ICOLL_INTERRUPTn_SHIFT(d->hwirq)) & 0x3;
>> +}
>> +
>> +static void irq_set_level(int hwirq, int level)
>> +{
>> +	if (unlikely(level < 0 || level > 3)) {
>> +		pr_err("%s Wrong level (%i) for irq (%i)!", __func__, level,
>> +				hwirq);
>> +		return;
>> +	}
>> +	if (use_cached_level)
>> +		level_cache[hwirq] = level;
>> +
>> +	writel_relaxed(level << BM_ICOLL_INTERRUPTn_SHIFT(hwirq),
>> +			icoll_base + HW_ICOLL_INTERRUPTn(hwirq));
>> +}
>> +
>> +static void icoll_ack_irq(struct irq_data *d)
>> +{
>> +	readl_relaxed(icoll_base + HW_ICOLL_VECTOR);
>> +}
>> +
>> +static void icoll_mask_irq(struct irq_data *d)
>> +{
>> +	writel_relaxed(BM_ICOLL_INTERRUPTn_ENABLE(d->hwirq),
>> +			icoll_base + HW_ICOLL_INTERRUPTn_CLR(d->hwirq));
>> +}
>> +
>> +static void icoll_unmask_irq(struct irq_data *d)
>> +{
>> +	u32 level;
>> +
>> +	writel_relaxed(BM_CLEAR_BIT(d->hwirq),
>> +			icoll_base + HW_ICOLL_CLEARn(d->hwirq));
>> +
>> +	level = irq_get_level(d);
>> +	writel_relaxed(BM_LEVELn(level), icoll_base + HW_ICOLL_LEVELACK);
>> +
>> +	writel_relaxed(BM_ICOLL_INTERRUPTn_ENABLE(d->hwirq),
>> +			icoll_base + HW_ICOLL_INTERRUPTn_SET(d->hwirq));
> 
> mutex?
> 
>> +}
>> +
>> +static struct irq_chip asm9260_icoll_chip = {
>> +	.irq_ack = icoll_ack_irq,
>> +	.irq_mask = icoll_mask_irq,
>> +	.irq_unmask = icoll_unmask_irq,
>> +};
>> +
>> +asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
>> +{
>> +	u32 irqnr;
>> +
>> +	irqnr = irq_find_mapping(icoll_domain,
>> +			readl_relaxed(icoll_base + HW_ICOLL_STAT_OFFSET));
> 
> Please check the return value of irq_find_mapping()
> 
>> +
>> +	handle_IRQ(irqnr, regs);
> 
> We're in the progress of converting to handle_domain_irq(), please take
> a look at the series in
> 
>   git://git.infradead.org/users/jcooper/linux.git irqchip/handle_domain
> 
>> +}
>> +
>> +static int icoll_irq_domain_map(struct irq_domain *d, unsigned int virq,
>> +				irq_hw_number_t hw)
>> +{
>> +	irq_set_chip_and_handler(virq, &asm9260_icoll_chip, handle_level_irq);
>> +	set_irq_flags(virq, IRQF_VALID);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct irq_domain_ops icoll_irq_domain_ops = {
>> +	.map = icoll_irq_domain_map,
>> +	.xlate = irq_domain_xlate_onecell,
>> +};
>> +
>> +static int __init icoll_of_init(struct device_node *np,
>> +			  struct device_node *interrupt_parent)
>> +{
>> +	struct resource res;
>> +	int i;
>> +
>> +	of_address_to_resource(np, 0, &res);
> 
> Please check the return value of of_address_to_resource().
> 
>> +	if (!request_mem_region(res.start, resource_size(&res), np->name))
>> +		panic("%s: unable to request mem region", np->name);
>> +
>> +	icoll_base = ioremap_nocache(res.start, resource_size(&res));
>> +	if (!icoll_base)
>> +		panic("%s: unable to map resource", np->name);
>> +
>> +	/* enable IRQ controller */
>> +	writel_relaxed(BM_CTRL_ARM_RSE_MODE | BM_CTRL_IRQ_ENABLE,
>> +			icoll_base + HW_ICOLL_CTRL);
>> +
>> +	/* This ICOLL has no reset option. So, set all priorities
>> +	 * manually to 0. */
>> +	for (i = 0; i < 16 * 0x10; i += 0x10)
>> +		writel(0, icoll_base + HW_ICOLL_INTERRUPT0 + i);
>> +
>> +	/* set timer 0 priority level high. TODO: should be done by DT  */
>> +	irq_set_level(29, 3);
>> +
>> +	icoll_domain = irq_domain_add_linear(np, ICOLL_NUM_IRQS,
>> +					     &icoll_irq_domain_ops, NULL);
> 
> Please check return value of irq_domain_add_linear().
> 
> thx,
> 
> Jason.
> 
>> +
>> +	irq_set_default_host(icoll_domain);
>> +
>> +	set_handle_irq(icoll_handle_irq);
>> +
>> +	return icoll_domain ? 0 : -ENODEV;
>> +}
>> +IRQCHIP_DECLARE(asm9260, "alpscale,asm9260-icall", icoll_of_init);
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/2b51b1fa/attachment.sig>
