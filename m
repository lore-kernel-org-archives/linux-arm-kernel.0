From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 15 May 2015 22:48:36 +0200 (CEST)
Subject: [RFC v1 11/11] genirq: Pass irq_data to helper function
 __irq_set_chip_handler_name_locked()
In-Reply-To: <1430709339-29083-12-git-send-email-jiang.liu@linux.intel.com>
References: <1430709339-29083-1-git-send-email-jiang.liu@linux.intel.com>
 <1430709339-29083-12-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505152247280.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 May 2015, Jiang Liu wrote:
>  /* caller has locked the irq_desc and both params are valid */
>  static inline void
> -__irq_set_chip_handler_name_locked(unsigned int irq, struct irq_chip *chip,
> +__irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chip,
>  				   irq_flow_handler_t handler, const char *name)
>  {
>  	struct irq_desc *desc;
>  
> -	desc = irq_to_desc(irq);
> -	irq_desc_get_irq_data(desc)->chip = chip;
> +	desc = irq_to_desc(data->irq);

We should have a irq_data_to_desc() helper and use that instead of
going through a full lookup again.

Thanks,

	tglx
