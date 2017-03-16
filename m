From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 16 Mar 2017 22:17:18 +0100
Subject: [RFC PATCH 30/33] irqchip/gic-v4: Add VPE command interface
In-Reply-To: <1484648454-21216-31-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-31-git-send-email-marc.zyngier@arm.com>
Message-ID: <d9282979-e586-41d9-6ccf-feea48554218@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 17/01/2017 11:20, Marc Zyngier wrote:
> Add the required interfaces to schedule a VPE and perform a
> VINVALL command.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

I think it would have helped me to get the VPE and VLPI API earlier
since it brings the user point of you.

Eric

> ---
>  drivers/irqchip/irq-gic-v4.c       | 31 +++++++++++++++++++++++++++++++
>  include/linux/irqchip/arm-gic-v4.h |  2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
> index b9a0b34..7d74089 100644
> --- a/drivers/irqchip/irq-gic-v4.c
> +++ b/drivers/irqchip/irq-gic-v4.c
> @@ -109,3 +109,34 @@ void its_free_vcpu_irqs(struct its_vm *vm, int nr_vpes)
>  
>  	irq_domain_free_irqs(irq, nr_vpes);
>  }
> +
> +static int its_send_vpe_cmd(struct its_vpe *vpe, struct its_cmd_info *info)
> +{
> +	unsigned int irq;
> +	irq_hw_number_t hwirq;
> +
> +	WARN_ON(preemptible());
> +
> +	hwirq = vpe->vpe_db_lpi - vpe->its_vm->db_lpi_base;
> +	irq = irq_find_mapping(vpe->its_vm->domain, hwirq);
> +
> +	return irq_set_vcpu_affinity(irq, info);
> +}
> +
> +int its_schedule_vpe(struct its_vpe *vpe, bool on)
> +{
> +	struct its_cmd_info info;
> +
> +	info.cmd_type = on ? SCHEDULE_VPE : DESCHEDULE_VPE;
> +
> +	return its_send_vpe_cmd(vpe, &info);
> +}
> +
> +int its_invall_vpe(struct its_vpe *vpe)
> +{
> +	struct its_cmd_info info = {
> +		.cmd_type = INVALL_VPE,
> +	};
> +
> +	return its_send_vpe_cmd(vpe, &info);
> +}
> diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
> index 2463d70..1c58add 100644
> --- a/include/linux/irqchip/arm-gic-v4.h
> +++ b/include/linux/irqchip/arm-gic-v4.h
> @@ -91,5 +91,7 @@ struct its_cmd_info {
>  
>  int its_alloc_vcpu_irqs(struct its_vm *vm, struct its_vpe **vpes, int nr_vpes);
>  void its_free_vcpu_irqs(struct its_vm *vm, int nr_vpes);
> +int its_schedule_vpe(struct its_vpe *vpe, bool on);
> +int its_invall_vpe(struct its_vpe *vpe);
>  
>  #endif
> 
