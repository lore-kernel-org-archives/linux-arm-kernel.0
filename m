From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 17 Jul 2015 18:15:00 -0500
Subject: [PATCH v3 2/8] ACPI / irqchip: Add self-probe infrastructure to
 initialize IRQ controller
In-Reply-To: <1436525114-14425-3-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
 <1436525114-14425-3-git-send-email-hanjun.guo@linaro.org>
Message-ID: <CAOZdJXWB71tzc=OMm_UH23jc+_wsA5=pC5W9arrEM-URm_sywg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 5:45 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:

> +void __init acpi_irqchip_init(void)
> +{
> +       struct acpi_table_id *id;
> +
> +       if (acpi_disabled)
> +               return;
> +
> +       if (acpi_gic_version_init())
> +               return;
> +
> +       /* scan the irqchip table to match the GIC version and its driver */
> +       for (id = __irqchip_acpi_table; id->id[0]; id++) {
> +               if (gic_version == (u8)id->driver_data)
> +                       acpi_table_parse(id->id,
> +                                        (acpi_tbl_table_handler)id->handler);
> +       }

Should we display an error message if we don't find a matching table?
That can happen if the ACPI tables shows a GIC version number that is
not listed in __irqchip_acpi_table[]?
