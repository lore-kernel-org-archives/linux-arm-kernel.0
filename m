From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 18 Jan 2017 21:45:56 +0200
Subject: [PATCH V10 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <1484766276-9668-1-git-send-email-agustinv@codeaurora.org>
References: <1484766276-9668-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <CAHp75Vem=mCOGVoOpCJFYHcO17mJ9gexsQxa0Pjf4Lbt3hibRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 9:04 PM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> ACPI extended IRQ resources may contain a ResourceSource to specify
> an alternate interrupt controller. Introduce acpi_irq_get and use it
> to implement ResourceSource/IRQ domain mapping.
>
> The new API is similar to of_irq_get and allows re-initialization
> of a platform resource from the ACPI extended IRQ resource, and
> provides proper behavior for probe deferral when the domain is not
> yet present when called.

Thanks, looks better now.

>  /**
> + * acpi_get_irq_source_fwhandle() - Retrieve the fwhandle of the given
> + *                                  acpi_resource_source which is used
> + *                                  as an IRQ domain id

Please, make short description here and put long one below

> + * @source: acpi_resource_source to use for the lookup
> + *

* Description:
* ...
*

> + * Returns: The appropriate IRQ fwhandle domain id
> + *          NULL on failure

* Return:
* blablabla

> + */
> +static struct fwnode_handle *
> +acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
> +{
> +       struct fwnode_handle *result;
> +       struct acpi_device *device;
> +       acpi_handle handle;
> +       acpi_status status;
> +
> +       if (!source->string_length)
> +               return acpi_gsi_domain_id;
> +
> +       status = acpi_get_handle(NULL, source->string_ptr, &handle);
> +       if (ACPI_FAILURE(status)) {

> +               pr_warn("Could not find handle for %s\n", source->string_ptr);
> +               return NULL;
> +       }
> +
> +       device = acpi_bus_get_acpi_device(handle);
> +       if (!device) {
> +               pr_warn("Could not get device for %s\n", source->string_ptr);

I'm not sure both messages have a value.

> +               return NULL;
> +       }

> +/**

You mark as kernel doc, but in fact it's just a comment.

> + * Context for the resource walk used to lookup IRQ resources.
> + */
> +struct acpi_irq_parse_one_ctx {
> +       int rc;
> +       unsigned int index;
> +       unsigned long *res_flags;
> +       struct irq_fwspec *fwspec;
> +};
> +
> +/**
> + * acpi_irq_parse_one_match - Handle a matching IRQ resource

This looks better, but lacks of parameter descriptions.

> + */

> +/**
> + * acpi_irq_parse_one_cb - Handle the given resource
> + * @ares: resource to handle

> + * @context: context for the walk, contains the lookup index and references
> + *           to the flags and fwspec where the result is returned

Make it shorter, ideally into one line

> + *

* Description:

> + * This is called by acpi_walk_resources passing each resource returned by
> + * the _CRS method. We only inspect IRQ resources. Since IRQ resources
> + * might contain multiple interrupts we check if the index is within this
> + * one's interrupt array, otherwise we subtract the current resource IRQ
> + * count from the lookup index to prepare for the next resource.
> + * Once a match is found we call acpi_irq_parse_one_match to populate
> + * the result and end the walk by returning AE_CTRL_TERMINATE.
> + *
> + * Return AE_OK if the walk should continue, AE_CTRL_TERMINATE if a matching

* Return:
* blablabla

> + * IRQ resource was found.
> + */

> +/**
> + * acpi_irq_parse_one - Resolve an interrupt for a device
> + * @handle: the device whose interrupt is to be resolved
> + * @index: index of the interrupt to resolve
> + * @fwspec: structure irq_fwspec filled by this function
> + * @flags: resource flags filled by this function
> + *
> + * This function resolves an interrupt for a device by walking its CRS resources
> + * to find the appropriate ACPI IRQ resource and populating the given structure
> + * which can be used to retrieve a Linux IRQ number.
> + *
> + * Returns the result stored in ctx.rc by the callback, or -EINVAL if the given
> + * index is out of range.

Ditto for Description and Return.

> + */
> +static int acpi_irq_parse_one(acpi_handle handle, unsigned int index,
> +                             struct irq_fwspec *fwspec, unsigned long *flags)
> +{
> +       struct acpi_irq_parse_one_ctx ctx = { -EINVAL, index, flags, fwspec };
> +       acpi_status status;
> +
> +       status = acpi_walk_resources(handle, METHOD_NAME__CRS,
> +                                    acpi_irq_parse_one_cb, &ctx);

> +       if (ACPI_FAILURE(status))
> +               return -EINVAL;

Shouldn't you have the same in rc? Would be redundant.

> +       return ctx.rc;
> +}
> +
> +/**
> + * acpi_irq_get - Look for the ACPI IRQ resource with the given index and
> + *                use it to initialize the given Linux IRQ resource.
> + * @handle ACPI device handle
> + * @index  ACPI IRQ resource index to lookup
> + * @res    Linux IRQ resource to initialize

Ah, you missed colons after field names:
* @field1:

> + *
> + * Return:

Next line:  0 on success

> + *         -EINVAL if an error occurs
> + *         -EPROBE_DEFER if the IRQ lookup/conversion failed
> + */
> +int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *res)
> +{

> +       int rc;

Put this last in the definition block.

> +       struct irq_fwspec fwspec;
> +       struct irq_domain *domain;
> +       unsigned long flags;
> +
> +       rc = acpi_irq_parse_one(handle, index, &fwspec, &flags);
> +       if (rc)
> +               return rc;
> +
> +       domain = irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
> +       if (!domain)
> +               return -EPROBE_DEFER;

Hmm... Could it be other issues here?

> +
> +       rc = irq_create_fwspec_mapping(&fwspec);
> +       if (rc <= 0)
> +               return -EINVAL;
> +

> +       res->start = rc;
> +       res->end = rc;
> +       res->flags = flags;

Perhaps struct resource *r should be a parameter to acpi_irq_parse_one().

> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_irq_get);
> +
> +/**
>   * acpi_set_irq_model - Setup the GSI irqdomain information
>   * @model: the value assigned to acpi_irq_model
>   * @fwnode: the irq_domain identifier for mapping and looking up
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index c4af003..61423d2 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -102,6 +102,14 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
>         }
>
>         r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> +       if (r && r->flags & IORESOURCE_DISABLED && ACPI_COMPANION(&dev->dev)) {

has_acpi_companion() ?

> +               int ret;
> +
> +               ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
> +               if (ret)
> +                       return ret;
> +       }

> @@ -1450,4 +1458,3 @@ void __init early_platform_cleanup(void)
>                 memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
>         }
>  }
> -

It doesn't belong here.

-- 
With Best Regards,
Andy Shevchenko
