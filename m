From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 26 Jan 2017 02:47:09 +0200
Subject: [PATCH V11 1/3] ACPI: Generic GSI: Do not attempt to map non-GSI
 IRQs during bus scan
In-Reply-To: <1484879660-1960-2-git-send-email-agustinv@codeaurora.org>
References: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
 <1484879660-1960-2-git-send-email-agustinv@codeaurora.org>
Message-ID: <CAHp75VdTnjupjzWyc27JPi_wUsd=+q-4FuzRV=WvjfSe1HdoKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 4:34 AM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> ACPI extended IRQ resources may contain a Resource Source field to specify
> an alternate interrupt controller, attempting to map them as GSIs is
> incorrect, so just disable the platform resource.
>
> Since this field is currently ignored, we make this change conditional
> on CONFIG_ACPI_GENERIC_GSI to keep the current behavior on x86 platforms,
> in case some existing ACPI tables are using this incorrectly.

> @@ -43,6 +43,19 @@ static inline bool acpi_iospace_resource_valid(struct resource *res)
>  acpi_iospace_resource_valid(struct resource *res) { return true; }
>  #endif
>
> +#ifdef CONFIG_ACPI_GENERIC_GSI

#if IS_ENABLED() ?

> +static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
> +{
> +       return ext_irq->resource_source.string_length == 0 &&
> +              ext_irq->producer_consumer == ACPI_CONSUMER;
> +}
> +#else
> +static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
> +{
> +       return true;
> +}
> +#endif
> +
>  static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
>  {
>         u64 reslen = end - start + 1;
> @@ -470,9 +483,12 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>                         acpi_dev_irqresource_disabled(res, 0);
>                         return false;
>                 }
> -               acpi_dev_get_irqresource(res, ext_irq->interrupts[index],

> +               if (is_gsi(ext_irq))
> +                       acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
>                                          ext_irq->triggering, ext_irq->polarity,
>                                          ext_irq->sharable, false);
> +               else
> +                       acpi_dev_irqresource_disabled(res, 0);

And why not to create a helper called acpi_dev_get_gsi_irqresource()
instead of that one?

-- 
With Best Regards,
Andy Shevchenko
