From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 2 Aug 2015 12:22:24 +0200 (CEST)
Subject: [PATCH] irqchip: bcm2836: Use a CPU notifier enable IPIs.
In-Reply-To: <1438027789-1637-1-git-send-email-eric@anholt.net>
References: <55B67C81.1010900@gmail.com>
 <1438027789-1637-1-git-send-email-eric@anholt.net>
Message-ID: <alpine.DEB.2.11.1508021221370.3825@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jul 2015, Eric Anholt wrote:
> +/* Unmasks the IPI on the CPU wen it's first brought online. */

when

> +static int bcm2836_arm_irqchip_cpu_notify(struct notifier_block *nfb,
> +					  unsigned long action, void *hcpu)
> +{
> +	unsigned int cpu = (unsigned long)hcpu;
> +	unsigned int int_reg = LOCAL_MAILBOX_INT_CONTROL0;
> +	unsigned int mailbox = 0;
> +
> +	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
> +		bcm2836_arm_irqchip_unmask_per_cpu_irq(int_reg, mailbox, cpu);

Shouldn't you mask the irq on CPU_DYING?

Thanks,

	tglx
