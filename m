From: julien.grall@arm.com (Julien Grall)
Date: Mon, 11 Apr 2016 14:54:08 +0100
Subject: [PATCH v5 4/9] irqchip/gic-v2: Parse and export virtual GIC
 information
In-Reply-To: <570B174B.2050905@linaro.org>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-5-git-send-email-julien.grall@arm.com>
 <570B174B.2050905@linaro.org>
Message-ID: <570BAC80.2090708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/16 04:17, Hanjun Guo wrote:
> Hi Julian,

Hi Hanjun,

>
> On 2016/4/4 19:37, Julien Grall wrote:
>> @@ -1302,6 +1339,41 @@ static bool __init gic_validate_dist(struct
>> acpi_subtable_header *header,
>>
>>   #define ACPI_GICV2_DIST_MEM_SIZE    (SZ_4K)
>>   #define ACPI_GIC_CPU_IF_MEM_SIZE    (SZ_8K)
>> +#define ACPI_GICV2_VCTRL_MEM_SIZE    (SZ_4K)
>> +#define ACPI_GICV2_VCPU_MEM_SIZE    (SZ_8K)
>> +
>> +static void __init gic_acpi_setup_kvm_info(void)
>> +{
>> +    int irq;
>> +    struct resource *vctrl_res = &gic_v2_kvm_info.vctrl;
>> +    struct resource *vcpu_res = &gic_v2_kvm_info.vcpu;
>> +
>> +    gic_v2_kvm_info.type = GIC_V2;
>> +
>> +    irq = acpi_register_gsi(NULL, acpi_data.maint_irq,
>> +                acpi_data.maint_irq_mode,
>> +                ACPI_ACTIVE_HIGH);
>> +    if (irq <= 0)
>> +        return;
>> +
>> +    gic_v2_kvm_info.maint_irq = irq;
>> +
>> +    if (!acpi_data.vctrl_base)
>> +        return;
>
> It might be worth to unregister gsi before return, or just
> move
>
> +    irq = acpi_register_gsi(NULL, acpi_data.maint_irq,
> +                acpi_data.maint_irq_mode,
> +                ACPI_ACTIVE_HIGH);
> +    if (irq <= 0)
> +        return;
> +
> +    gic_v2_kvm_info.maint_irq = irq;
>
> before gic_set_kvm_info(&gic_v2_kvm_info); below...
>
>> +
>> +    vctrl_res->flags = IORESOURCE_MEM;
>> +    vctrl_res->start = acpi_data.vctrl_base;
>> +    vctrl_res->end = vctrl_res->start + ACPI_GICV2_VCTRL_MEM_SIZE - 1;
>> +
>> +    if (!acpi_data.vcpu_base)
>> +        return;
>> +
>> +    vcpu_res->flags = IORESOURCE_MEM;
>> +    vcpu_res->start = acpi_data.vcpu_base;
>> +    vcpu_res->end = vcpu_res->start + ACPI_GICV2_VCPU_MEM_SIZE - 1;
>
> ...
> Move them just here will be better.

I will move the code to get the maintenance interrupt here.

Regards,

-- 
Julien Grall
