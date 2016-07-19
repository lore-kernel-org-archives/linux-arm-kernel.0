From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 19 Jul 2016 16:15:56 +0200 (CEST)
Subject: [PATCH v11 03/10] genirq/irq: introduce msi_doorbell_info
In-Reply-To: <1468933367-23159-4-git-send-email-eric.auger@redhat.com>
References: <1468933367-23159-1-git-send-email-eric.auger@redhat.com>
 <1468933367-23159-4-git-send-email-eric.auger@redhat.com>
Message-ID: <alpine.DEB.2.11.1607191610070.3596@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Jul 2016, Eric Auger wrote:
>  
> +/* Describe all the MSI doorbell regions for an irqchip */
> +struct irq_chip_msi_doorbell_info {
> +	union {
> +		phys_addr_t __percpu *percpu_doorbells;
> +		phys_addr_t global_doorbell;
> +	};
> +	bool doorbell_is_percpu;
> +	bool irq_remapping;	/* is irq_remapping implemented? */

Please do not use tail comments. Use proper kernel doc for documentation.

> +	size_t size;				/* size of each doorbell */
> +	int prot;				/* iommu protection flag */

Please align the members proper

	union {
		phys_addr_t __percpu	*percpu_doorbells;
		phys_addr_t 		global_doorbell;
	};
	bool	doorbell_is_percpu;
	bool	irq_remapping;

> +};
> +
>  /**
>   * struct irq_chip - hardware interrupt chip descriptor
>   *
> @@ -349,6 +361,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>   * @irq_get_irqchip_state:	return the internal state of an interrupt
>   * @irq_set_irqchip_state:	set the internal state of a interrupt
>   * @irq_set_vcpu_affinity:	optional to target a vCPU in a virtual machine
> + * @msi_doorbell_info:	return the MSI doorbell info
>   * @ipi_send_single:	send a single IPI to destination cpus
>   * @ipi_send_mask:	send an IPI to destination cpus in cpumask
>   * @flags:		chip specific flags
> @@ -394,7 +407,8 @@ struct irq_chip {
>  	int		(*irq_set_irqchip_state)(struct irq_data *data, enum irqchip_irq_state which, bool state);
>  
>  	int		(*irq_set_vcpu_affinity)(struct irq_data *data, void *vcpu_info);
> -
> +	struct irq_chip_msi_doorbell_info *(*msi_doorbell_info)(

  	irq_get_msi_doorbell_info or msi_get_doorbell_info please

> +							struct irq_data *data);

No need for a line break here. Please keep it as a single line.

Thanks

	tglx
