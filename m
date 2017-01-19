From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Thu, 19 Jan 2017 10:40:42 -0500
Subject: [PATCH V10 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <CAHp75Vem=mCOGVoOpCJFYHcO17mJ9gexsQxa0Pjf4Lbt3hibRA@mail.gmail.com>
References: <1484766276-9668-1-git-send-email-agustinv@codeaurora.org>
 <CAHp75Vem=mCOGVoOpCJFYHcO17mJ9gexsQxa0Pjf4Lbt3hibRA@mail.gmail.com>
Message-ID: <c5e197e8bf26429ae488f49e47760302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 2017-01-18 14:45, Andy Shevchenko wrote:
> On Wed, Jan 18, 2017 at 9:04 PM, Agustin Vega-Frias
> <agustinv@codeaurora.org> wrote:
> 
> [...]
> 
> 
>> + */
>> +static struct fwnode_handle *
>> +acpi_get_irq_source_fwhandle(const struct acpi_resource_source 
>> *source)
>> +{
>> +       struct fwnode_handle *result;
>> +       struct acpi_device *device;
>> +       acpi_handle handle;
>> +       acpi_status status;
>> +
>> +       if (!source->string_length)
>> +               return acpi_gsi_domain_id;
>> +
>> +       status = acpi_get_handle(NULL, source->string_ptr, &handle);
>> +       if (ACPI_FAILURE(status)) {
> 
>> +               pr_warn("Could not find handle for %s\n", 
>> source->string_ptr);
>> +               return NULL;
>> +       }
>> +
>> +       device = acpi_bus_get_acpi_device(handle);
>> +       if (!device) {
>> +               pr_warn("Could not get device for %s\n", 
>> source->string_ptr);
> 
> I'm not sure both messages have a value.

I'll probably just drop the explicit pr_warns and just use WARN_ON on
the if condition. Is that a reasonable alternative in your view?

> 
>> +               return NULL;
>> +       }
> 
> 
> [...]
> 
>> + */
>> +static int acpi_irq_parse_one(acpi_handle handle, unsigned int index,
>> +                             struct irq_fwspec *fwspec, unsigned long 
>> *flags)
>> +{
>> +       struct acpi_irq_parse_one_ctx ctx = { -EINVAL, index, flags, 
>> fwspec };
>> +       acpi_status status;
>> +
>> +       status = acpi_walk_resources(handle, METHOD_NAME__CRS,
>> +                                    acpi_irq_parse_one_cb, &ctx);
> 
>> +       if (ACPI_FAILURE(status))
>> +               return -EINVAL;
> 
> Shouldn't you have the same in rc? Would be redundant.
> 

Good point, since we always return -EINVAL on failure we can skip
the check since rc will only be updated on success.

>> +       return ctx.rc;
>> +}
>> +
> 
> [...]
> 
>> +       domain = irq_find_matching_fwnode(fwspec.fwnode, 
>> DOMAIN_BUS_ANY);
>> +       if (!domain)
>> +               return -EPROBE_DEFER;
> 
> Hmm... Could it be other issues here?

I'll comment on this on Lorenzo's reply.

> 
>> +
>> +       rc = irq_create_fwspec_mapping(&fwspec);
>> +       if (rc <= 0)
>> +               return -EINVAL;
>> +
> 
>> +       res->start = rc;
>> +       res->end = rc;
>> +       res->flags = flags;
> 
> Perhaps struct resource *r should be a parameter to 
> acpi_irq_parse_one().

I'll comment on this on Lorenzo's reply.

> 
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_irq_get);
>> +
>> +/**
>>   * acpi_set_irq_model - Setup the GSI irqdomain information
>>   * @model: the value assigned to acpi_irq_model
>>   * @fwnode: the irq_domain identifier for mapping and looking up

I'll address the other issues on V11.

Thanks for your thorough review,
Agustin

> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
