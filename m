From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Tue, 17 Jan 2017 10:07:32 -0500
Subject: [PATCH V9 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <587E1275.7030007@huawei.com>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <1481753438-3905-3-git-send-email-agustinv@codeaurora.org>
 <587E1275.7030007@huawei.com>
Message-ID: <cc305557e91d2de4ae53daf1f5e8fe5a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 2017-01-17 07:47, Hanjun Guo wrote:
> On 2016/12/15 6:10, Agustin Vega-Frias wrote:
>> ACPI extended IRQ resources may contain a ResourceSource to specify
>> an alternate interrupt controller. Introduce acpi_irq_get and use it
>> to implement ResourceSource/IRQ domain mapping.
>> 
>> The new API is similar to of_irq_get and allows re-initialization
>> of a platform resource from the ACPI extended IRQ resource, and
>> provides proper behavior for probe deferral when the domain is not
>> yet present when called.
>> 
>> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
>> ---
>>  drivers/acpi/Makefile         |   2 +-
>>  drivers/acpi/{gsi.c => irq.c} | 182 
>> ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/base/platform.c       |   9 ++-
>>  include/linux/acpi.h          |  10 +++
>>  4 files changed, 201 insertions(+), 2 deletions(-)
>>  rename drivers/acpi/{gsi.c => irq.c} (32%)
>> 
> [...]
>> +/**
>> + * acpi_irq_parse_one_cb - Handle the given resource
>> + * @ares: resource to handle
>> + * @context: context for the walk, contains the lookup index and 
>> references
>> + *           to the flags and fwspec where the result is returned
>> + *
>> + * This is called by acpi_walk_resources passing each resource 
>> returned by
>> + * the _CRS method. We only inspect IRQ resources. Since IRQ 
>> resources
>> + * might contain multiple interrupts we check if the index is within 
>> this
>> + * one's interrupt array, otherwise we subtract the current resource 
>> IRQ
>> + * count from the lookup index to prepare for the next resource.
>> + * Once a match is found we call acpi_irq_parse_one_match to populate
>> + * the result and end the walk by returning AE_CTRL_TERMINATE.
>> + *
>> + * Return AE_OK if the walk should continue, AE_CTRL_TERMINATE if a 
>> matching
>> + * IRQ resource was found.
>> + */
>> +static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
>> +					 void *context)
>> +{
>> +	struct acpi_irq_parse_one_ctx *ctx = context;
>> +	struct acpi_resource_irq *irq;
>> +	struct acpi_resource_extended_irq *eirq;
>> +	struct fwnode_handle *fwnode;
>> +
>> +	switch (ares->type) {
>> +	case ACPI_RESOURCE_TYPE_IRQ:
>> +		irq = &ares->data.irq;
>> +		if (ctx->index >= irq->interrupt_count) {
>> +			ctx->index -= irq->interrupt_count;
>> +			return AE_OK;
>> +		}
>> +		fwnode = acpi_gsi_domain_id;
>> +		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
>> +					 irq->triggering, irq->polarity,
>> +					 irq->sharable, ctx);
>> +		return AE_CTRL_TERMINATE;
>> +	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>> +		eirq = &ares->data.extended_irq;
> 
> If it's an interrupt producer, I think we don't need to map the 
> interrupts in
> any irqdomain, and return AE_CTRL_TERMINATE here.
> 
>         case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>                 eirq = &ares->data.extended_irq;
> +         if (eirq->producer_consumer == ACPI_PRODUCER)
> +                 return AE_CTRL_TERMINATE;
>                 if (ctx->index >= eirq->interrupt_count) {

Agreed. I'll add the check. However, we need to return AE_OK, not
AE_CTRL_TERMINATE, since that terminates the walk and there might
be other resources to check after this one.

Thanks,
Agustin

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
