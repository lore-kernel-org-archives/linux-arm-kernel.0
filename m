From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 16 Dec 2016 16:24:39 +0000
Subject: [PATCH V9 1/3] ACPI: Generic GSI: Do not attempt to map non-GSI
 IRQs during bus scan
In-Reply-To: <1481753438-3905-2-git-send-email-agustinv@codeaurora.org>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <1481753438-3905-2-git-send-email-agustinv@codeaurora.org>
Message-ID: <20161216162439.GA24673@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 05:10:36PM -0500, Agustin Vega-Frias wrote:
> ACPI extended IRQ resources may contain a Resource Source field to specify
> an alternate interrupt controller, attempting to map them as GSIs is
> incorrect, so just disable the platform resource.
> 
> Since this field is currently ignored, we make this change conditional
> on CONFIG_ACPI_GENERIC_GSI to keep the current behavior on x86 platforms,
> in case some existing ACPI tables are using this incorrectly.
> 
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  drivers/acpi/resource.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 56241eb..76ca4e9 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -43,6 +43,18 @@ static inline bool acpi_iospace_resource_valid(struct resource *res)
>  acpi_iospace_resource_valid(struct resource *res) { return true; }
>  #endif
>  
> +#ifdef CONFIG_ACPI_GENERIC_GSI
> +static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
> +{
> +	return ext_irq->resource_source.string_length == 0;
> +}
> +#else
> +static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
> +{
> +	return true;
> +}
> +#endif

Well, patch is simple there is not much to say other that on the
firmware side I honestly do not see many options, either we remove the
ifdeffery above and make the check unconditional (ie we do check on
x86/ia64 too instead of always returning true) and see if things hold up
on x86 (at least we try) or we will never know and will never be able to
use this on x86 if there will ever be need.

It would be certainly weird to find out that a descriptor has a
resource_source pointer put there by mistake (because that's what we are
talking about, things work on x86/ia64 by ignoring the resource_source
pointer so any string there is just an unfortunate mistake AFAICS).

I am quite tempted to remove the ifdef and make the is_gsi() check effective on
x86/ia64 too.

Lorenzo

> +
>  static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
>  {
>  	u64 reslen = end - start + 1;
> @@ -470,9 +482,12 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  			acpi_dev_irqresource_disabled(res, 0);
>  			return false;
>  		}
> -		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
> +		if (is_gsi(ext_irq))
> +			acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
>  					 ext_irq->triggering, ext_irq->polarity,
>  					 ext_irq->sharable, false);
> +		else
> +			acpi_dev_irqresource_disabled(res, 0);
>  		break;
>  	default:
>  		res->flags = 0;
> -- 
> Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
