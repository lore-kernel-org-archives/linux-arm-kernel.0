From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 20 Jul 2015 17:32:18 +0800
Subject: [PATCH v3 2/8] ACPI / irqchip: Add self-probe infrastructure
 to initialize IRQ controller
In-Reply-To: <CAOZdJXWB71tzc=OMm_UH23jc+_wsA5=pC5W9arrEM-URm_sywg@mail.gmail.com>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>	<1436525114-14425-3-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXWB71tzc=OMm_UH23jc+_wsA5=pC5W9arrEM-URm_sywg@mail.gmail.com>
Message-ID: <55ACC022.1000800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2015 07:15 AM, Timur Tabi wrote:
> On Fri, Jul 10, 2015 at 5:45 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>
>> +void __init acpi_irqchip_init(void)
>> +{
>> +       struct acpi_table_id *id;
>> +
>> +       if (acpi_disabled)
>> +               return;
>> +
>> +       if (acpi_gic_version_init())
>> +               return;
>> +
>> +       /* scan the irqchip table to match the GIC version and its driver */
>> +       for (id = __irqchip_acpi_table; id->id[0]; id++) {
>> +               if (gic_version == (u8)id->driver_data)
>> +                       acpi_table_parse(id->id,
>> +                                        (acpi_tbl_table_handler)id->handler);
>> +       }
>
> Should we display an error message if we don't find a matching table?
> That can happen if the ACPI tables shows a GIC version number that is
> not listed in __irqchip_acpi_table[]?

Hmm, did you get the error message like: "Invalid GIC version 5 in
MADT"? or just use ACPI_MADT_GIC_VERSION_V1 as the gic_version? if
the later one, it will show everything is fine, but failed to probe
the GIC.

I agree with you that we need to print some error message here,
I will update my patch.

Thanks
Hanjun
