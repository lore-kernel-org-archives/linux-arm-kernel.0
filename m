From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 04 Sep 2014 22:03:38 +0800
Subject: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <5406F8BC.7000503@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
 <5404AE56.80801@arm.com> <5405AE95.1020201@linaro.org>
 <5405BFE7.5060005@arm.com> <5405E626.4090306@linaro.org>
 <5406EDDC.3020208@arm.com> <5406F8BC.7000503@linaro.org>
Message-ID: <5408713A.3020600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?09?03? 19:17, Hanjun Guo wrote:
>>>>>>> +
>>>>>>> +#ifdef CONFIG_ACPI
>>>>>>> +#define ACPI_MAX_GIC_CPU_INTERFACE_ENTRIES  65535
>>>>>> With GICv2? I doubt it.
>>>>> I will create macro for each GIC driver:
>>>>> #define ACPI_MAX_GICV2_CPU_INTERFACE_ENTRIES    8
>>>>> #define ACPI_MAX_GICV3_CPU_INTERFACE_ENTRIES    65535
>>>> Where do you get this value (ACPI_MAX_GICV3_CPU_INTERFACE_ENTRIES) from?
>>> This value is for max processors entries in MADT, and we will use it to scan MADT
>>> for SMP/GIC Init, I just make it big enough for GICv3/4. since ACPI core will stop
>>> scan MADT if the real numbers of processors entries are reached no matter
>>> how big ACPI_MAX_GICV3_CPU_INTERFACE_ENTRIES is, I think we can just
>>> define a number big enough then it will work (x86 and ia64 did the same thing).
>> Also, with GICv3++, there is no such thing as a memory-mapped CPU
>> interface anymore. What you get is a bunch of redistributors (one per
>> CPU). I assume what you have here actually describe the redistributors,
>> and its name should reflect that.
> As Sudeep said, it is not to link to GIC architecture, so I think we can keep
> it stick with ACPI spec, in ACPI spec, it called "GICC structure" (section 5.2.12.14
> in ACPI 5.1), so we can name it as ACPI_MAX_GICC_STRUCTURE_ENTRIES no matter
> GICv2 or GICv3/4 (with GICv2, it may have more than 8 entries with some disabled
> ones, will no more than 8 enabled entries).
>
> What do you think?

After more consideration on this, we think that we can remove those macros which
introduce confusions, and just pass 0 to ACPI core for the max entries of GICC structure
or GICR structure, ACPI core will continue scan all the entries in MADT with 0 passed.
With that, we can avoid such name confusions for all GIC related structures in MADT
no matter GICv2 or GICv3/4.

Thanks
Hanjun
