From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 1 Aug 2017 17:15:39 +0100
Subject: [RFC PATCH v2 11/19] genirq: Document vcpu_info usage for per-CPU
 interrupts
In-Reply-To: <20170717142718.13853-12-cdall@linaro.org>
References: <20170717142718.13853-1-cdall@linaro.org>
 <20170717142718.13853-12-cdall@linaro.org>
Message-ID: <7a872305-40fb-bc76-4ac0-8ebe8b5ce7c1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/17 15:27, Christoffer Dall wrote:
> It is currently unclear how to set the VCPU affinity for an interrupt
> which is of the per-CPU kind, since the Linux irq_data structure

very minor nit (which I should have noticed before, my bad): we have two
kinds of per-CPU interrupts in the kernel. percpu, and percpu_devid. For
the percpu variety, the IRQ number represents a single interrupt line,
delivered to a given CPU (and non migrate-able). The percpu_devid
variant represents multiple interrupts, each assigned to one CPU.

It'd be nice if the commit message (and the comment below) reflected
this distinction.

> describes the state for multiple interrupts when the interrupt is a
> per-CPU interrupt, one for each physical CPU on the system.  Since each
> such interrupt can be associated with different VCPUs or none at all,
> associating a single VCPU state with such an interrupt does not capture
> the necessary semantics.
> 
> The implementers of irq_set_affinity are the Intel and AMD IOMMUs, and
> the ARM GIC irqchip.  The Intel and AMD callers do not appear to use
> per-CPU interrupts, and the ARM GIC implementation only checks the
> pointer against NULL vs. non-NULL.
> 
> Therefore, simply update the function documentation to explain the
> expected use in the context of per-CPU interrupts, allowing future
> changes or additions to irqchip implementers to do the right thing.
> 
> This allows us to set the VCPU affinity for the virtual timer interrupt
> in KVM/ARM, which is a per-CPU (PPI) interrupt.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
> ---
>  kernel/irq/manage.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 5624b2d..050b9f6 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -381,7 +381,8 @@ int irq_select_affinity_usr(unsigned int irq)
>  /**
>   *	irq_set_vcpu_affinity - Set vcpu affinity for the interrupt
>   *	@irq: interrupt number to set affinity
> - *	@vcpu_info: vCPU specific data
> + *	@vcpu_info: vCPU specific data or pointer to a percpu array of vCPU
> + *	            specific data for per-CPU interrupts
>   *
>   *	This function uses the vCPU specific data to set the vCPU
>   *	affinity for an irq. The vCPU specific data is passed from
> 

Otherwise a worthy clarification of the feature.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
