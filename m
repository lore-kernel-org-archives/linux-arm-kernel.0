From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Jul 2014 16:12:19 +0800
Subject: [PATCH 10/19] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
In-Reply-To: <20140725122424.GD19632@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-11-git-send-email-hanjun.guo@linaro.org>
 <20140724154745.GD26190@leverpostej> <53D236B9.7000302@linaro.org>
 <20140725122424.GD19632@leverpostej>
Message-ID: <53D75763.1090601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-25 20:24, Mark Rutland wrote:
> On Fri, Jul 25, 2014 at 11:51:37AM +0100, Hanjun Guo wrote:
>> On 2014-7-24 23:47, Mark Rutland wrote:
>>> On Thu, Jul 24, 2014 at 02:00:16PM +0100, Hanjun Guo wrote:
>>>> ACPI 5.1 only has two explicit methods to boot up SMP,
>>>> PSCI and Parking protocol, but the Parking protocol is
>>>> only suitable for ARMv7 now, so make PSCI as the only way
>>>> for the SMP boot protocol before some updates for the
>>>> ACPI spec or the Parking protocol spec.
>>>>
[...]
>>>> -#include <asm/cpu_ops.h>
>>>> -#include <asm/smp_plat.h>
>>>>  #include <linux/errno.h>
>>>>  #include <linux/of.h>
>>>>  #include <linux/string.h>
>>>> +#include <linux/acpi.h>
>>>> +
>>>> +#include <asm/cpu_ops.h>
>>>> +#include <asm/smp_plat.h>
>>>
>>> Was the header move just for consistency with other files, or is there
>>> some ordering requirement here?
>>
>> Ordering requirement, it will meet compile error for "return -ENODEV;"
>> in the head file which I introduced, I know I can include the right
>> head file in asm/cpu_ops.h, but I think move the asm/xx.h after the
>> include of linux/xx.h would be fine.
> 
> If a file uses something defined in a header, it should include that
> header. So if you need ENODEV in cpu_ops.h, make cpu_ops.h include
> <linux/errno.h>. It is not fine to deliberately rely on implicit
> includes.

ok, will fix that in next version.

> 
> Moving the headers around is a separate issue. I have no problem with
> doing that for consistency with other files.
> 
>>
>>>
>>>>
>>>>  extern const struct cpu_operations smp_spin_table_ops;
>>>>  extern const struct cpu_operations cpu_psci_ops;
>>>> @@ -52,7 +54,7 @@ static const struct cpu_operations * __init cpu_get_ops(const char *name)
>>>>  /*
>>>>   * Read a cpu's enable method from the device tree and record it in cpu_ops.
>>>>   */
>>>> -int __init cpu_read_ops(struct device_node *dn, int cpu)
>>>> +int __init cpu_of_read_ops(struct device_node *dn, int cpu)
>>>>  {
>>>>         const char *enable_method = of_get_property(dn, "enable-method", NULL);
>>>>         if (!enable_method) {
>>>> @@ -76,12 +78,52 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
>>>>         return 0;
>>>>  }
>>>>
>>>> +#ifdef CONFIG_ACPI
>>>> +/*
>>>> + * Read a cpu's enable method in the ACPI way and record it in cpu_ops.
>>>> + */
>>>> +int __init cpu_acpi_read_ops(int cpu)
>>>> +{
>>>> +       /*
>>>> +        * For ACPI 5.1, only two kind of methods are provided,
>>>> +        * Parking protocol and PSCI, but Parking protocol is
>>>> +        * used on ARMv7 only, so make PSCI as the only method
>>>> +        * for SMP initialization before the ACPI spec or Parking
>>>> +        * protocol spec is updated.
>>>> +        */
>>>
>>> That comment is a little misleading. The parking protocol is _specified_
>>> for ARMv7 only.
>>
>> Agreed. But I'm just wondering if the Parking protocol is modified and
>> then support ARMv8, how to describe it in the comments?
> 
> We update the comments if and when that happens.

Ok.

Thanks
Hanjun
