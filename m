From: phil@raspberrypi.org (Phil Elwell)
Date: Mon, 7 Aug 2017 08:47:20 +0100
Subject: [PATCH 3/3] irqchip: bcm2836: Move SMP startup code to arch/arm
In-Reply-To: <1502058731-12462-4-git-send-email-stefan.wahren@i2se.com>
References: <1502058731-12462-1-git-send-email-stefan.wahren@i2se.com>
 <1502058731-12462-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <143fe51b-50d8-ef6d-2946-47a675f0337e@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 06/08/2017 23:32, Stefan Wahren wrote:
> In order to easily provide SMP for BCM2837 on 32-bit and 64-bit
> the SMP startup code was placed in irq-bcm2836. That's not the
> right approach. So move this code where it belongs.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: 41f4988cc287 ("irqchip/bcm2836: Add SMP support for the 2836")
> ---
>  arch/arm/mach-bcm/Makefile          |  3 ++
>  arch/arm/mach-bcm/platsmp.c         | 35 ++++++++++++++++
>  drivers/irqchip/irq-bcm2836.c       | 79 +------------------------------------
>  include/linux/irqchip/irq-bcm2836.h | 70 ++++++++++++++++++++++++++++++++
>  4 files changed, 110 insertions(+), 77 deletions(-)
>  create mode 100644 include/linux/irqchip/irq-bcm2836.h
> 
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 980f585..637cd9e 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -43,6 +43,9 @@ endif
>  
>  # BCM2835
>  obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
> +ifeq ($(CONFIG_ARCH_BCM2835),y)
> +obj-$(CONFIG_SMP)		+= platsmp.o
> +endif
>  
>  # BCM5301X
>  obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
> diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/mach-bcm/platsmp.c
> index 9e3f275..3fa1a99 100644
> --- a/arch/arm/mach-bcm/platsmp.c
> +++ b/arch/arm/mach-bcm/platsmp.c
> @@ -17,6 +17,7 @@
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/irqchip/irq-bcm2836.h>
>  #include <linux/jiffies.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -287,6 +288,35 @@ static int nsp_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	return ret;
>  }
>  
> +static int bcm2836_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	void __iomem *intc_base;
> +	struct device_node *dn;
> +	char *name;
> +
> +	name = "brcm,bcm2836-l1-intc";
> +	dn = of_find_compatible_node(NULL, NULL, name);
> +	if (!dn) {
> +		pr_err("unable to find intc node\n");
> +		return -ENODEV;
> +	}
> +
> +	intc_base = of_iomap(dn, 0);
> +	of_node_put(dn);
> +
> +	if (!intc_base) {
> +		pr_err("unable to remap intc base register\n");
> +		return -ENOMEM;
> +	}
> +
> +	writel(virt_to_phys(secondary_startup),
> +	       intc_base + LOCAL_MAILBOX3_SET0 + 16 * cpu);

I was going to upstream the patch to add dsb+sev today, but now the goalposts are
(literally) moving. Should I produce two patchsets - one for before your patch is
appied, and one for after - or will you add the required lines here?:
 
+       dsb(sy); /* Ensure write has completed before waking the other CPUs */
+       sev();
+

> +
> +	iounmap(intc_base);
> +
> +	return 0;
> +}
> +
>  static const struct smp_operations kona_smp_ops __initconst = {
>  	.smp_prepare_cpus	= bcm_smp_prepare_cpus,
>  	.smp_boot_secondary	= kona_boot_secondary,
> @@ -305,3 +335,8 @@ static const struct smp_operations nsp_smp_ops __initconst = {
>  	.smp_boot_secondary	= nsp_boot_secondary,
>  };
>  CPU_METHOD_OF_DECLARE(bcm_smp_nsp, "brcm,bcm-nsp-smp", &nsp_smp_ops);
> +
> +static const struct smp_operations bcm2836_smp_ops __initconst = {
> +	.smp_boot_secondary	= bcm2836_boot_secondary,
> +};
> +CPU_METHOD_OF_DECLARE(bcm_smp_bcm2836, "brcm,bcm2836-smp", &bcm2836_smp_ops);
> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
> index e7463e3..cb4a6f5 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -19,62 +19,9 @@
>  #include <linux/of_irq.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqdomain.h>
> -#include <asm/exception.h>
> -
> -#define LOCAL_CONTROL			0x000
> -#define LOCAL_PRESCALER			0x008
> +#include <linux/irqchip/irq-bcm2836.h>
>  
> -/*
> - * The low 2 bits identify the CPU that the GPU IRQ goes to, and the
> - * next 2 bits identify the CPU that the GPU FIQ goes to.
> - */
> -#define LOCAL_GPU_ROUTING		0x00c
> -/* When setting bits 0-3, enables PMU interrupts on that CPU. */
> -#define LOCAL_PM_ROUTING_SET		0x010
> -/* When setting bits 0-3, disables PMU interrupts on that CPU. */
> -#define LOCAL_PM_ROUTING_CLR		0x014
> -/*
> - * The low 4 bits of this are the CPU's timer IRQ enables, and the
> - * next 4 bits are the CPU's timer FIQ enables (which override the IRQ
> - * bits).
> - */
> -#define LOCAL_TIMER_INT_CONTROL0	0x040
> -/*
> - * The low 4 bits of this are the CPU's per-mailbox IRQ enables, and
> - * the next 4 bits are the CPU's per-mailbox FIQ enables (which
> - * override the IRQ bits).
> - */
> -#define LOCAL_MAILBOX_INT_CONTROL0	0x050
> -/*
> - * The CPU's interrupt status register.  Bits are defined by the the
> - * LOCAL_IRQ_* bits below.
> - */
> -#define LOCAL_IRQ_PENDING0		0x060
> -/* Same status bits as above, but for FIQ. */
> -#define LOCAL_FIQ_PENDING0		0x070
> -/*
> - * Mailbox write-to-set bits.  There are 16 mailboxes, 4 per CPU, and
> - * these bits are organized by mailbox number and then CPU number.  We
> - * use mailbox 0 for IPIs.  The mailbox's interrupt is raised while
> - * any bit is set.
> - */
> -#define LOCAL_MAILBOX0_SET0		0x080
> -#define LOCAL_MAILBOX3_SET0		0x08c
> -/* Mailbox write-to-clear bits. */
> -#define LOCAL_MAILBOX0_CLR0		0x0c0
> -#define LOCAL_MAILBOX3_CLR0		0x0cc
> -
> -#define LOCAL_IRQ_CNTPSIRQ	0
> -#define LOCAL_IRQ_CNTPNSIRQ	1
> -#define LOCAL_IRQ_CNTHPIRQ	2
> -#define LOCAL_IRQ_CNTVIRQ	3
> -#define LOCAL_IRQ_MAILBOX0	4
> -#define LOCAL_IRQ_MAILBOX1	5
> -#define LOCAL_IRQ_MAILBOX2	6
> -#define LOCAL_IRQ_MAILBOX3	7
> -#define LOCAL_IRQ_GPU_FAST	8
> -#define LOCAL_IRQ_PMU_FAST	9
> -#define LAST_IRQ		LOCAL_IRQ_PMU_FAST
> +#include <asm/exception.h>
>  
>  struct bcm2836_arm_irqchip_intc {
>  	struct irq_domain *domain;
> @@ -215,24 +162,6 @@ static int bcm2836_cpu_dying(unsigned int cpu)
>  					     cpu);
>  	return 0;
>  }
> -
> -#ifdef CONFIG_ARM
> -static int __init bcm2836_smp_boot_secondary(unsigned int cpu,
> -					     struct task_struct *idle)
> -{
> -	unsigned long secondary_startup_phys =
> -		(unsigned long)virt_to_phys((void *)secondary_startup);
> -
> -	writel(secondary_startup_phys,
> -	       intc.base + LOCAL_MAILBOX3_SET0 + 16 * cpu);
> -
> -	return 0;
> -}
> -
> -static const struct smp_operations bcm2836_smp_ops __initconst = {
> -	.smp_boot_secondary	= bcm2836_smp_boot_secondary,
> -};
> -#endif
>  #endif
>  
>  static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
> @@ -249,10 +178,6 @@ bcm2836_arm_irqchip_smp_init(void)
>  			  bcm2836_cpu_dying);
>  
>  	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
> -
> -#ifdef CONFIG_ARM
> -	smp_set_ops(&bcm2836_smp_ops);
> -#endif
>  #endif
>  }
>  
> diff --git a/include/linux/irqchip/irq-bcm2836.h b/include/linux/irqchip/irq-bcm2836.h
> new file mode 100644
> index 0000000..218a6e1
> --- /dev/null
> +++ b/include/linux/irqchip/irq-bcm2836.h
> @@ -0,0 +1,70 @@
> +/*
> + * Root interrupt controller for the BCM2836 (Raspberry Pi 2).
> + *
> + * Copyright 2015 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#define LOCAL_CONTROL			0x000
> +#define LOCAL_PRESCALER			0x008
> +
> +/*
> + * The low 2 bits identify the CPU that the GPU IRQ goes to, and the
> + * next 2 bits identify the CPU that the GPU FIQ goes to.
> + */
> +#define LOCAL_GPU_ROUTING		0x00c
> +/* When setting bits 0-3, enables PMU interrupts on that CPU. */
> +#define LOCAL_PM_ROUTING_SET		0x010
> +/* When setting bits 0-3, disables PMU interrupts on that CPU. */
> +#define LOCAL_PM_ROUTING_CLR		0x014
> +/*
> + * The low 4 bits of this are the CPU's timer IRQ enables, and the
> + * next 4 bits are the CPU's timer FIQ enables (which override the IRQ
> + * bits).
> + */
> +#define LOCAL_TIMER_INT_CONTROL0	0x040
> +/*
> + * The low 4 bits of this are the CPU's per-mailbox IRQ enables, and
> + * the next 4 bits are the CPU's per-mailbox FIQ enables (which
> + * override the IRQ bits).
> + */
> +#define LOCAL_MAILBOX_INT_CONTROL0	0x050
> +/*
> + * The CPU's interrupt status register.  Bits are defined by the the
> + * LOCAL_IRQ_* bits below.
> + */
> +#define LOCAL_IRQ_PENDING0		0x060
> +/* Same status bits as above, but for FIQ. */
> +#define LOCAL_FIQ_PENDING0		0x070
> +/*
> + * Mailbox write-to-set bits.  There are 16 mailboxes, 4 per CPU, and
> + * these bits are organized by mailbox number and then CPU number.  We
> + * use mailbox 0 for IPIs.  The mailbox's interrupt is raised while
> + * any bit is set.
> + */
> +#define LOCAL_MAILBOX0_SET0		0x080
> +#define LOCAL_MAILBOX3_SET0		0x08c
> +/* Mailbox write-to-clear bits. */
> +#define LOCAL_MAILBOX0_CLR0		0x0c0
> +#define LOCAL_MAILBOX3_CLR0		0x0cc
> +
> +#define LOCAL_IRQ_CNTPSIRQ	0
> +#define LOCAL_IRQ_CNTPNSIRQ	1
> +#define LOCAL_IRQ_CNTHPIRQ	2
> +#define LOCAL_IRQ_CNTVIRQ	3
> +#define LOCAL_IRQ_MAILBOX0	4
> +#define LOCAL_IRQ_MAILBOX1	5
> +#define LOCAL_IRQ_MAILBOX2	6
> +#define LOCAL_IRQ_MAILBOX3	7
> +#define LOCAL_IRQ_GPU_FAST	8
> +#define LOCAL_IRQ_PMU_FAST	9
> +#define LAST_IRQ		LOCAL_IRQ_PMU_FAST
> 

Regards,

Phil
