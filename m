From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 18 Nov 2015 11:46:43 +0000
Subject: [PATCH v3 24/62] arm: Introduce a generic way to use a device
 from acpi
In-Reply-To: <564BE459.6000006@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-25-git-send-email-shannon.zhao@linaro.org>
 <564B2023.8010801@citrix.com> <564B29EA.3060107@huawei.com>
 <564B38F6.9070101@citrix.com> <564BE459.6000006@huawei.com>
Message-ID: <564C6523.5090800@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/15 02:37, Shannon Zhao wrote:
> 
> 
> On 2015/11/17 22:25, Julien Grall wrote:
>> On 17/11/15 13:21, Shannon Zhao wrote:
>>>> AFAICT, it does only works for SPCR table used for UART device. For the
>>>> GIC you've hardcoded the value and I can't find any version number in
>>>> the table.
>>>>
>>> No, I didn't hardcode the GIC version. Since ACPI 6.0 introduces GIC
>>> version in generic distributor table, it could get the version from
>>> that. Please see [PATCH v3 28/62].
>>
>> +    if ( dist->version == ACPI_MADT_GIC_VERSION_V2 )
>> +        rc = acpi_device_init(DEVICE_GIC, NULL, GIC_V2);
>> +    else if ( dist->version == ACPI_MADT_GIC_VERSION_V3 )
>> +        rc = acpi_device_init(DEVICE_GIC, NULL, GIC_V3);
>>
>> Every single time a new GIC version will be added, we will had to add
>> another else if. I'm sorry but it's what I call hardcoding.
>>
> 
> Oh, I see. If it uses the enum acpi_madt_gic_version for ACPI GIC not
> the enum gic_version, it could match 1:1. Something like below:
> 
> It uses ACPI_MADT_GIC_VERSION_V2 for GICv2.
> 
> ACPI_DEVICE_START(agicv2, "GICv2", DEVICE_GIC)
>         .class_type = ACPI_MADT_GIC_VERSION_V2,
>         .init = acpi_gicv2_preinit,
> ACPI_DEVICE_END
> 
> Then get the GIC version from MADT table and call
> 
> acpi_device_init(DEVICE_GIC, NULL, dist->version);
> 
> How about this way?

That would be better. We want the common mode as agnostic as possible
from the GIC version.

Regards,

-- 
Julien Grall
