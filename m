From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Jun 2015 16:58:05 +0100
Subject: [PATCH 06/11] ACPI / gsi: Add gsi_mutex to synchronize
 acpi_register_gsi()/acpi_unregister_gsi()
In-Reply-To: <1431953961-22706-7-git-send-email-hanjun.guo@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
 <1431953961-22706-7-git-send-email-hanjun.guo@linaro.org>
Message-ID: <55785E8D.1000909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/15 13:59, Hanjun Guo wrote:
> Add a mutex for acpi_register_gsi()/acpi_unregister_gsi() to avoid
> concurrency issues.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/gsi.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
> index 55b5f31..ab0dcb4 100644
> --- a/drivers/acpi/gsi.c
> +++ b/drivers/acpi/gsi.c
> @@ -16,6 +16,7 @@
>  enum acpi_irq_model_id acpi_irq_model;
>  /* ACPI core domian pointing to GICv2/3 core domain */
>  struct irq_domain *acpi_irq_domain __read_mostly;
> +static DEFINE_MUTEX(gsi_mutex);
>  
>  static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
>  {
> @@ -73,20 +74,24 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
>  	int irq;
>  	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
>  
> +	mutex_lock(&gsi_mutex);
>  	irq = irq_find_mapping(acpi_irq_domain, gsi);
>  	if (irq > 0)
> -		return irq;
> +		goto out;
>  
>  	irq = irq_domain_alloc_irqs(acpi_irq_domain, 1, dev_to_node(dev),
>  				    &gsi);
>  	if (irq <= 0)
> -		return -EINVAL;
> +		goto out;
>  
>  	/* Set irq type if specified and different than the current one */
>  	if (irq_type != IRQ_TYPE_NONE &&
>  		irq_type != irq_get_trigger_type(irq))
>  		irq_set_irq_type(irq, irq_type);
> -	return irq;
> +
> +out:
> +	mutex_unlock(&gsi_mutex);
> +	return irq > 0 ? irq : -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(acpi_register_gsi);
>  
> @@ -96,8 +101,12 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
>   */
>  void acpi_unregister_gsi(u32 gsi)
>  {
> -	int irq = irq_find_mapping(acpi_irq_domain, gsi);
> +	int irq;
> +
> +	mutex_lock(&gsi_mutex);
> +	irq = irq_find_mapping(acpi_irq_domain, gsi);
>  
>  	irq_dispose_mapping(irq);
> +	mutex_unlock(&gsi_mutex);
>  }
>  EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
> 

Can you point out why we need this locking? The rest of the kernel seems
to live without it pretty well. And if we really have an issue, I'd
prefer seeing it fixed in the core code rather than in something that is
very much firmware-specific.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
