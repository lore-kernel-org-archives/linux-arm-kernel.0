From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 15 Nov 2016 15:48:33 +0000
Subject: [PATCH V7 1/3] ACPI: Retry IRQ conversion if it failed previously
In-Reply-To: <1479074375-2629-2-git-send-email-agustinv@codeaurora.org>
References: <1479074375-2629-1-git-send-email-agustinv@codeaurora.org>
 <1479074375-2629-2-git-send-email-agustinv@codeaurora.org>
Message-ID: <20161115154833.GA16906@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2016 at 04:59:33PM -0500, Agustin Vega-Frias wrote:
> This allows probe deferral to work properly when a dependent device
> fails to get a valid IRQ because the IRQ domain was not registered
> at the time the resources were added to the platform_device.
> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  drivers/acpi/resource.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/base/platform.c |  9 +++++++-
>  include/linux/acpi.h    |  7 ++++++
>  3 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 56241eb..4beda15 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -664,3 +664,62 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
>  	return (type & types) ? 0 : 1;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_filter_resource_type);
> +
> +struct acpi_irq_get_ctx {
> +	unsigned int index;
> +	struct resource *res;
> +};
> +
> +static acpi_status acpi_irq_get_cb(struct acpi_resource *ares, void *context)
> +{
> +	struct acpi_irq_get_ctx *ctx = context;
> +	struct acpi_resource_irq *irq;
> +	struct acpi_resource_extended_irq *ext_irq;
> +
> +	switch (ares->type) {
> +	case ACPI_RESOURCE_TYPE_IRQ:
> +		irq = &ares->data.irq;
> +		if (ctx->index < irq->interrupt_count) {
> +			acpi_dev_resource_interrupt(ares, ctx->index, ctx->res);
> +			return AE_CTRL_TERMINATE;
> +		}
> +		ctx->index -= irq->interrupt_count;

I do not understand this code, mind explaining what it is meant to do ?

In particular I do not understand the logic behind the index decrement,
I think I am missing something here.

> +		break;
> +	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> +		ext_irq = &ares->data.extended_irq;
> +		if (ctx->index < ext_irq->interrupt_count) {
> +			acpi_dev_resource_interrupt(ares, ctx->index, ctx->res);
> +			return AE_CTRL_TERMINATE;
> +		}
> +		ctx->index -= ext_irq->interrupt_count;

Ditto.

Thanks,
Lorenzo

> +		break;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +/**
> + * acpi_irq_get - Look for the ACPI IRQ resource with the given index and
> + *                use it to initialize the given Linux IRQ resource.
> + * @handle ACPI device handle
> + * @index  ACPI IRQ resource index to lookup
> + * @res    Linux IRQ resource to initialize
> + *
> + * Return: 0 on success
> + *         -EINVAL if an error occurs
> + *         -EPROBE_DEFER if the IRQ lookup/conversion failed
> + */
> +int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
> +{
> +	struct acpi_irq_get_ctx ctx = { index, res };
> +	acpi_status status;
> +
> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> +				     acpi_irq_get_cb, &ctx);
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +	if (res->flags & IORESOURCE_DISABLED)
> +		return -EPROBE_DEFER;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_irq_get);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index c4af003..61423d2 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -102,6 +102,14 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>  	}
>  
>  	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> +	if (r && r->flags & IORESOURCE_DISABLED && ACPI_COMPANION(&dev->dev)) {
> +		int ret;
> +
> +		ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/*
>  	 * The resources may pass trigger flags to the irqs that need
>  	 * to be set up. It so happens that the trigger flags for
> @@ -1450,4 +1458,3 @@ void __init early_platform_cleanup(void)
>  		memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
>  	}
>  }
> -
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 689a8b9..325bdb9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -406,6 +406,7 @@ bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
>  unsigned int acpi_dev_get_irq_type(int triggering, int polarity);
>  bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  				 struct resource *res);
> +int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res);
>  
>  void acpi_dev_free_resource_list(struct list_head *list);
>  int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
> @@ -763,6 +764,12 @@ static inline int acpi_reconfig_notifier_unregister(struct notifier_block *nb)
>  	return -EINVAL;
>  }
>  
> +static inline int acpi_irq_get(acpi_handle handle, unsigned int index,
> +			       struct resource *res)
> +{
> +	return -EINVAL;
> +}
> +
>  #endif	/* !CONFIG_ACPI */
>  
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> -- 
> Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
