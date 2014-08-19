From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 19 Aug 2014 19:26:37 +0800
Subject: [PATCH v2 08/18] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
In-Reply-To: <53F2471D.2010203@arm.com>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-9-git-send-email-hanjun.guo@linaro.org>
 <53F2471D.2010203@arm.com>
Message-ID: <53F3346D.7080404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-8-19 2:34, Sudeep Holla wrote:
> On 04/08/14 16:28, Hanjun Guo wrote:
[...]
>>   /* Basic configuration for ACPI */
>>   #ifdef    CONFIG_ACPI
>> +/*
>> + * ACPI 5.1 only has two explicit methods to
>> + * boot up SMP, PSCI and Parking protocol,
>> + * but the Parking protocol is only defined
>> + * for ARMv7 now, so make PSCI as the only
>> + * way for the SMP boot protocol before some
>> + * updates for the ACPI spec or the Parking
>> + * protocol spec.
>> + *
>> + * This enum is intend to make the boot method
>> + * scalable when above updates are happended,
>> + * which NOT means to support all of them.
>> + */
>> +enum acpi_smp_boot_protocol {
>> +    ACPI_SMP_BOOT_PSCI,
>> +    ACPI_SMP_BOOT_PARKING_PROTOCOL,
>> +    ACPI_SMP_BOOT_PROTOCOL_MAX
>> +};
>> +
>> +enum acpi_smp_boot_protocol smp_boot_protocol(void);
>> +
[...]
>> +/* Protocol to bring up secondary CPUs */
>> +enum acpi_smp_boot_protocol smp_boot_protocol(void)
>> +{
>> +    if (acpi_psci_present())
>> +        return ACPI_SMP_BOOT_PSCI;
>> +    else
>> +        return ACPI_SMP_BOOT_PARKING_PROTOCOL;
>> +}
>> +
> 
> Which do you need this here ? Can't you use acpi_psci_present directly
> in acpi_get_cpu_boot_method ?

My intent was to make the code scalable if we introduce another (or more)
boot protocol in ACPI, does it make sense to you?

> 
>>   static int __init acpi_parse_fadt(struct acpi_table_header *table)
>>   {
>>       struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
>> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
>> index d62d12f..05bc314 100644
>> --- a/arch/arm64/kernel/cpu_ops.c
>> +++ b/arch/arm64/kernel/cpu_ops.c
>> @@ -16,11 +16,13 @@
>>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>    */
>>
>> -#include <asm/cpu_ops.h>
>> -#include <asm/smp_plat.h>
>>   #include <linux/errno.h>
>>   #include <linux/of.h>
>>   #include <linux/string.h>
>> +#include <linux/acpi.h>
>> +
>> +#include <asm/cpu_ops.h>
>> +#include <asm/smp_plat.h>
>>
>>   extern const struct cpu_operations smp_spin_table_ops;
>>   extern const struct cpu_operations cpu_psci_ops;
>> @@ -49,12 +51,44 @@ static const struct cpu_operations * __init
>> cpu_get_ops(const char *name)
>>       return NULL;
>>   }
>>
>> +#ifdef CONFIG_ACPI
>> +/*
>> + * Get a cpu's boot method in the ACPI way.
>> + */
>> +static char * __init acpi_get_cpu_boot_method(void)
>> +{
>> +    /*
>> +     * For ACPI 5.1, only two kind of methods are provided,
>> +     * Parking protocol and PSCI, but Parking protocol is
>> +     * specified for ARMv7 only, so make PSCI as the only method
>> +     * for SMP initialization before the ACPI spec or Parking
>> +     * protocol spec is updated.
>> +     */
>> +    switch (smp_boot_protocol()) {
>> +    case ACPI_SMP_BOOT_PSCI:
>> +        return "psci";
>> +    case ACPI_SMP_BOOT_PARKING_PROTOCOL:
>> +    default:
>> +        return NULL;
>> +    }
> 
> Use acpi_psci_present as mentioned above.
> 
>> +}
>> +#else
>> +static inline char * __init acpi_get_cpu_boot_method(void) { return NULL; }
>> +#endif
>> +
>>   /*
>> - * Read a cpu's enable method from the device tree and record it in cpu_ops.
>> + * Read a cpu's enable method and record it in cpu_ops.
>>    */
>>   int __init cpu_read_ops(struct device_node *dn, int cpu)
>>   {
>> -    const char *enable_method = of_get_property(dn, "enable-method", NULL);
>> +    const char *enable_method;
>> +
>> +    if (!acpi_disabled) {
>> +        enable_method = acpi_get_cpu_boot_method();
>> +        goto get_ops;
>> +    }
>> +
>> +    enable_method = of_get_property(dn, "enable-method", NULL);
>>       if (!enable_method) {
>>           /*
>>            * The boot CPU may not have an enable method (e.g. when
>> @@ -66,10 +100,17 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
>>           return -ENOENT;
>>       }
>>
>> +get_ops:
>>       cpu_ops[cpu] = cpu_get_ops(enable_method);
>>       if (!cpu_ops[cpu]) {
>> -        pr_warn("%s: unsupported enable-method property: %s\n",
>> -            dn->full_name, enable_method);
>> +        if (acpi_disabled) {
>> +            pr_warn("%s: unsupported enable-method property: %s\n",
>> +                dn->full_name, enable_method);
>> +        } else {
>> +            pr_warn("CPU %d: boot protocol unsupported or unknown\n",
>> +                cpu);
>> +        }
>> +
>>           return -EOPNOTSUPP;
>>       }
>>
>> @@ -78,7 +119,14 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
>>
>>   void __init cpu_read_bootcpu_ops(void)
>>   {
>> -    struct device_node *dn = of_get_cpu_node(0, NULL);
>> +    struct device_node *dn;
>> +
>> +    if (!acpi_disabled) {
>> +        cpu_read_ops(NULL, 0);
>> +        return;
>> +    }
>> +
> 
> Again not good to mix ACPI in DT functions forcing you to pass
> device_node ptr as NULL, better to separate this. 

I separate them in the first version, and combine tham as Geoff suggested
for scalable reasons.

> Once you gather all
> this !acpi_disabled case, you can create appropriate abstractions to be
> used in setup.c
> 
> E.g. here you check !acpi_disabled and pass NULL for DT node to
> cpu_read_ops and hence again you check for !acpi_disabled in
> cpu_read_ops. So you need first identify all these checks and put in one
> place to understand well how you can refactor existing code to avoid
> these multiple checks.

I will remove the multiple acpi_disabled checks and refactor the code.

Thanks
Hanjun
