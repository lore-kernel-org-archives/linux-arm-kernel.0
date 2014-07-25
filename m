From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 25 Jul 2014 18:51:37 +0800
Subject: [PATCH 10/19] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
In-Reply-To: <20140724154745.GD26190@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org>
 <20140724154745.GD26190@leverpostej>
Message-ID: <53D236B9.7000302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-24 23:47, Mark Rutland wrote:
> On Thu, Jul 24, 2014 at 02:00:16PM +0100, Hanjun Guo wrote:
>> ACPI 5.1 only has two explicit methods to boot up SMP,
>> PSCI and Parking protocol, but the Parking protocol is
>> only suitable for ARMv7 now, so make PSCI as the only way
>> for the SMP boot protocol before some updates for the
>> ACPI spec or the Parking protocol spec.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> ---
>>  arch/arm64/include/asm/acpi.h    |   21 +++++++++++++++
>>  arch/arm64/include/asm/cpu_ops.h |    9 ++++++-
>>  arch/arm64/include/asm/smp.h     |    2 +-
>>  arch/arm64/kernel/acpi.c         |    9 +++++++
>>  arch/arm64/kernel/cpu_ops.c      |   52 ++++++++++++++++++++++++++++++++++----
>>  arch/arm64/kernel/smp.c          |   29 +++++++++++++++++++--
>>  6 files changed, 113 insertions(+), 9 deletions(-)
[...]
>>  /*
>> - * Setup the set of possible CPUs (via set_cpu_possible)
>> + * Platform specific SMP operations
>>   */
>>  extern void smp_init_cpus(void);
> 
> While the originial comment is out of date, the new form is plain wrong.
> 
> Something like "Discover the set of possible CPUs and determine their
> SMP operations" would be a better description of what's going on here.

Agreed.

> 
>>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index ff0f6a0..2af6662 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -184,6 +184,15 @@ static int __init acpi_parse_madt_gic_cpu_interface_entries(void)
>>         return 0;
>>  }
>>
>> +/* Protocol to bring up secondary CPUs */
>> +enum acpi_smp_boot_protocol smp_boot_protocol(void)
>> +{
>> +       if (acpi_psci_present)
>> +               return ACPI_SMP_BOOT_PSCI;
>> +       else
>> +               return ACPI_SMP_BOOT_PARKING_PROTOCOL;
>> +}
>> +
>>  static int __init acpi_parse_fadt(struct acpi_table_header *table)
>>  {
>>         struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
>> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
>> index d62d12f..4d9b3cf 100644
>> --- a/arch/arm64/kernel/cpu_ops.c
>> +++ b/arch/arm64/kernel/cpu_ops.c
>> @@ -16,11 +16,13 @@
>>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>   */
>>
>> -#include <asm/cpu_ops.h>
>> -#include <asm/smp_plat.h>
>>  #include <linux/errno.h>
>>  #include <linux/of.h>
>>  #include <linux/string.h>
>> +#include <linux/acpi.h>
>> +
>> +#include <asm/cpu_ops.h>
>> +#include <asm/smp_plat.h>
> 
> Was the header move just for consistency with other files, or is there
> some ordering requirement here?

Ordering requirement, it will meet compile error for "return -ENODEV;"
in the head file which I introduced, I know I can include the right
head file in asm/cpu_ops.h, but I think move the asm/xx.h after the
include of linux/xx.h would be fine.

> 
>>
>>  extern const struct cpu_operations smp_spin_table_ops;
>>  extern const struct cpu_operations cpu_psci_ops;
>> @@ -52,7 +54,7 @@ static const struct cpu_operations * __init cpu_get_ops(const char *name)
>>  /*
>>   * Read a cpu's enable method from the device tree and record it in cpu_ops.
>>   */
>> -int __init cpu_read_ops(struct device_node *dn, int cpu)
>> +int __init cpu_of_read_ops(struct device_node *dn, int cpu)
>>  {
>>         const char *enable_method = of_get_property(dn, "enable-method", NULL);
>>         if (!enable_method) {
>> @@ -76,12 +78,52 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_ACPI
>> +/*
>> + * Read a cpu's enable method in the ACPI way and record it in cpu_ops.
>> + */
>> +int __init cpu_acpi_read_ops(int cpu)
>> +{
>> +       /*
>> +        * For ACPI 5.1, only two kind of methods are provided,
>> +        * Parking protocol and PSCI, but Parking protocol is
>> +        * used on ARMv7 only, so make PSCI as the only method
>> +        * for SMP initialization before the ACPI spec or Parking
>> +        * protocol spec is updated.
>> +        */
> 
> That comment is a little misleading. The parking protocol is _specified_
> for ARMv7 only.

Agreed. But I'm just wondering if the Parking protocol is modified and
then support ARMv8, how to describe it in the comments?

> 
>> +       switch (smp_boot_protocol()) {
>> +       case ACPI_SMP_BOOT_PSCI:
>> +               cpu_ops[cpu] = cpu_get_ops("psci");
>> +               break;
>> +       case ACPI_SMP_BOOT_PARKING_PROTOCOL:
>> +       default:
>> +               cpu_ops[cpu] = NULL;
>> +               break;
>> +       }
>> +
>> +       if (!cpu_ops[cpu]) {
>> +               pr_warn("CPU %d: unsupported enable-method, only PSCI is supported\n",
>> +                       cpu);
>> +               return -EOPNOTSUPP;
>> +       }
> 
> That's going to require changes as things get updated, and
> "enable-method" is a term from DT rather than ACPI.
> 
> How about:
> 
> 	"CPU%d: boot protocol unsupported or unknown\n".

Pretty fine to me :)

Thanks
Hanjun
