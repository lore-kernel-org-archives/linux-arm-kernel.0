From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 27 Jul 2015 11:46:25 -0700
Subject: [PATCH] irq-bcm2836: Move SMP boot to the irqchip code.
In-Reply-To: <1438022532-14576-1-git-send-email-eric@anholt.net>
References: <alpine.DEB.2.11.1507261150500.18576@nanos>
 <1438022532-14576-1-git-send-email-eric@anholt.net>
Message-ID: <55B67C81.1010900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/07/15 11:42, Eric Anholt wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> Thomas: The problem with delaying IPI unmasking until secondary boot
> is that it means we need the secondary boot process to integrate with
> the irqchip code, which seems unusual given the dearth of includes I
> could find between arch/arm/mach-* SMP boot code and drivers/irqchip/
> to get function prototypes.  However, since the irqchip is most of
> this register space already, it might make sense to just have the SMP
> boot live in drivers/irqchip/.  Here's a patch that would do that,
> that could be squashed into my change.

I do not think this patch is going to work, there are CPU notifiers that
allows you to listen for events (CPU_ONLINE, CPU_DEAD...) as to when
(re)configuration of an interrupt controller can become necessary in
other areas of the kernel.

drivers/irqchip/irq-gic*.c contains code that deals with this for instance.

> 
>  drivers/irqchip/irq-bcm2836.c | 57 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
> index 87340b0..5f2a40e 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -49,14 +49,16 @@
>  /* Same status bits as above, but for FIQ. */
>  #define LOCAL_FIQ_PENDING0		0x070
>  /*
> - * Mailbox0 write-to-set bits.  There are 16 mailboxes, 4 per CPU, and
> + * Mailbox write-to-set bits.  There are 16 mailboxes, 4 per CPU, and
>   * these bits are organized by mailbox number and then CPU number.  We
>   * use mailbox 0 for IPIs.  The mailbox's interrupt is raised while
>   * any bit is set.
>   */
>  #define LOCAL_MAILBOX0_SET0		0x080
> +#define LOCAL_MAILBOX3_SET0		0x08c
>  /* Mailbox0 write-to-clear bits. */
>  #define LOCAL_MAILBOX0_CLR0		0x0c0
> +#define LOCAL_MAILBOX3_CLR0		0x0cc
>  
>  #define LOCAL_IRQ_CNTPSIRQ	0
>  #define LOCAL_IRQ_CNTPNSIRQ	1
> @@ -195,6 +197,46 @@ static void bcm2836_arm_irqchip_send_ipi(const struct cpumask *mask,
>  		writel(1 << ipi, mailbox0_base + 16 * cpu);
>  	}
>  }
> +
> +/* Requests boot of a secondary CPU.
> + *
> + * The Raspberry Pi firmware has already started up the CPU and set it
> + * spinning in a loop in low memory waiting for a value in mailbox 3
> + * indicating what OS code it should jump to.
> + */
> +int __init bcm2836_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	int timeout = 20;
> +	void __iomem *mailbox3_set_base = intc.base + LOCAL_MAILBOX3_SET0;
> +	void __iomem *mailbox3_clr_base = intc.base + LOCAL_MAILBOX3_CLR0;
> +	unsigned long secondary_startup_phys =
> +		(unsigned long) virt_to_phys((void *)secondary_startup);
> +
> +	/* Unmask IPIs to the target cpu. */
> +	bcm2836_arm_irqchip_unmask_per_cpu_irq(LOCAL_MAILBOX_INT_CONTROL0, 0,
> +					       cpu);
> +
> +	dsb();
> +
> +	writel(secondary_startup_phys, mailbox3_set_base + 16 * cpu);
> +
> +	while (true) {
> +		int val = readl(mailbox3_clr_base + 16 * cpu);
> +
> +		if (val == 0)
> +			return 0;
> +		if (timeout-- == 0)
> +			return -ETIMEDOUT;
> +		cpu_relax();
> +	}
> +
> +	return 0;
> +}
> +
> +static struct smp_operations bcm2836_smp_ops __initdata = {
> +	.smp_boot_secondary	= bcm2836_smp_boot_secondary,
> +};
> +
>  #endif
>  
>  static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
> @@ -205,14 +247,15 @@ static void
>  bcm2836_arm_irqchip_smp_init(void)
>  {
>  #ifdef CONFIG_SMP
> -	int i;
> +	/* Unmask IPIs to the boot CPU. Other CPUs will be unmasked as
> +	 * they're brought up.
> +	 */
> +	bcm2836_arm_irqchip_unmask_per_cpu_irq(LOCAL_MAILBOX_INT_CONTROL0, 0,
> +					       smp_processor_id());
>  
> -	/* unmask IPIs */
> -	for_each_possible_cpu(i) {
> -		bcm2836_arm_irqchip_unmask_per_cpu_irq(
> -			LOCAL_MAILBOX_INT_CONTROL0, 0, i);
> -	}
>  	set_smp_cross_call(bcm2836_arm_irqchip_send_ipi);
> +
> +	smp_set_ops(&bcm2836_smp_ops);
>  #endif
>  }
>  
> 


-- 
Florian
