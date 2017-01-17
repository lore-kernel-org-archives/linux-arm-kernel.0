From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 17 Jan 2017 20:15:19 +0800
Subject: [PATCH V9 1/3] ACPI: Generic GSI: Do not attempt to map non-GSI
 IRQs during bus scan
In-Reply-To: <1481753438-3905-2-git-send-email-agustinv@codeaurora.org>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <1481753438-3905-2-git-send-email-agustinv@codeaurora.org>
Message-ID: <587E0AD7.40303@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/15 6:10, Agustin Vega-Frias wrote:
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

As pointed out by Lorenzo, if the interrupt resource is a Resource Producer,
it's not GSI, so maybe the code needs to be updated as

-   return ext_irq->resource_source.string_length == 0;
+ return ext_irq->resource_source.string_length == 0 &&
+        ext_irq->producer_consumer != ACPI_PRODUCER;

Thanks
Hanjun
