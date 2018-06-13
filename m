From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 13 Jun 2018 12:14:24 +0100
Subject: [PATCH v4 24/26] irqchip/gic-v3: Add base support for pseudo-NMI
In-Reply-To: <1527241772-48007-25-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
 <1527241772-48007-25-git-send-email-julien.thierry@arm.com>
Message-ID: <79b13ea0-a549-418c-b69f-1fad87c06357@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/05/18 10:49, Julien Thierry wrote:
> Provide a higher priority to be used for pseudo-NMIs. When such an
> interrupt is received, enter the NMI state and prevent other NMIs to
> be raised.
> 
> When returning from a pseudo-NMI, skip preemption and tracing if the
> interrupted context has interrupts disabled.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/include/asm/arch_gicv3.h   |  6 ++++++
>   arch/arm64/include/asm/arch_gicv3.h |  6 ++++++
>   arch/arm64/kernel/entry.S           | 43 +++++++++++++++++++++++++++++++++++++
>   drivers/irqchip/irq-gic-v3.c        | 41 +++++++++++++++++++++++++++++++++++
>   4 files changed, 96 insertions(+)
> 

[...]

> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index b144f73..4be5996 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -371,6 +379,20 @@ static u64 gic_mpidr_to_affinity(unsigned long mpidr)
>   	return aff;
>   }
>   
> +static void do_handle_nmi(unsigned int hwirq, struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +	unsigned int irq;
> +
> +	nmi_enter();

RAS/SEA also enters NMI state and things will break if asynchronous 
error occurs during a pseudo-NMI.

I'll have this fixed in the next version.

-- 
Julien Thierry
