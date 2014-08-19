From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 19 Aug 2014 20:11:08 +0800
Subject: [PATCH v2 08/18] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
In-Reply-To: <1408388212.22761.100.camel@smoke>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>	
 <1407166105-17675-9-git-send-email-hanjun.guo@linaro.org>
 <1408388212.22761.100.camel@smoke>
Message-ID: <53F33EDC.3090203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-8-19 2:56, Geoff Levand wrote:
> Hi Hanjun,

Hi Geoff,

> 
> On Mon, 2014-08-04 at 23:28 +0800, Hanjun Guo wrote:
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -14,6 +14,27 @@
>>  
>>  /* Basic configuration for ACPI */
>>  #ifdef	CONFIG_ACPI
> 
> By having this preprocessor conditional in the header leads
> to a proliferation of preprocessor conditionals since any
> code that includes this header will also need to have
> preprocessor conditionals.  Another down side of having
> this is that this code will not get a build test for
> builds with CONFIG_ACPI=n.

I will move some definitions out of preprocessor conditional and
introduce some stub function when CONFIG_ACPI is disabled, then
I think I can remove all the preprocessor conditionals in .c file.

> 
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
>> +	ACPI_SMP_BOOT_PSCI,
>> +	ACPI_SMP_BOOT_PARKING_PROTOCOL,
>> +	ACPI_SMP_BOOT_PROTOCOL_MAX
>> +};
>> +
>> +enum acpi_smp_boot_protocol smp_boot_protocol(void);
> 
> The name smp_boot_protocol() seems like it would be a generic
> routine, but it is acpi specific.  Maybe:
> 
> enum acpi_boot_protocol_type {...};
> 
> enum acpi_boot_protocol_type acpi_boot_protocol(void);

Agreed.

> 
>> --- a/arch/arm64/kernel/cpu_ops.c
>> +++ b/arch/arm64/kernel/cpu_ops.c
>> @@ -49,12 +51,44 @@ static const struct cpu_operations * __init cpu_get_ops(const char *name)
>>  	return NULL;
>>  }
>>  
>> +#ifdef CONFIG_ACPI
>> +/*
>> + * Get a cpu's boot method in the ACPI way.
>> + */
>> +static char * __init acpi_get_cpu_boot_method(void)
>> +{
>> +	/*
>> +	 * For ACPI 5.1, only two kind of methods are provided,
>> +	 * Parking protocol and PSCI, but Parking protocol is
>> +	 * specified for ARMv7 only, so make PSCI as the only method
>> +	 * for SMP initialization before the ACPI spec or Parking
>> +	 * protocol spec is updated.
>> +	 */
>> +	switch (smp_boot_protocol()) {
>> +	case ACPI_SMP_BOOT_PSCI:
>> +		return "psci";
>> +	case ACPI_SMP_BOOT_PARKING_PROTOCOL:
>> +	default:
>> +		return NULL;
>> +	}
>> +}
>> +#else
>> +static inline char * __init acpi_get_cpu_boot_method(void) { return NULL; }
>> +#endif
> 
> Since this is inside a C source file, the inline keyword
> isn't needed since the optimizer will inline regardless.
> 
> With that said, I think it would be cleaner to have this
> as:
> 
> static char * __init acpi_get_cpu_boot_method(void)
> {
> #ifdef CONFIG_ACPI
> 	return NULL;
> #else
>  ...
> #endif
> }
> 
> Or better to make smp_boot_protocol() callable regardless
> of CONFIG_ACPI and then no preprocessor conditionals at all
> would be needed.
> 
>> +
>>  /*
>> - * Read a cpu's enable method from the device tree and record it in cpu_ops.
>> + * Read a cpu's enable method and record it in cpu_ops.
>>   */
>>  int __init cpu_read_ops(struct device_node *dn, int cpu)
>>  {
>> -	const char *enable_method = of_get_property(dn, "enable-method", NULL);
>> +	const char *enable_method;
>> +
>> +	if (!acpi_disabled) {
>> +		enable_method = acpi_get_cpu_boot_method();
>> +		goto get_ops;
>> +	}
>> +
>> +	enable_method = of_get_property(dn, "enable-method", NULL);
>>  	if (!enable_method) {
>>  		/*
>>  		 * The boot CPU may not have an enable method (e.g. when
>> @@ -66,10 +100,17 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
>>  		return -ENOENT;
>>  	}
>>  
>> +get_ops:
>>  	cpu_ops[cpu] = cpu_get_ops(enable_method);
>>  	if (!cpu_ops[cpu]) {
>> -		pr_warn("%s: unsupported enable-method property: %s\n",
>> -			dn->full_name, enable_method);
>> +		if (acpi_disabled) {
>> +			pr_warn("%s: unsupported enable-method property: %s\n",
>> +				dn->full_name, enable_method);
>> +		} else {
>> +			pr_warn("CPU %d: boot protocol unsupported or unknown\n",
>> +				cpu);
>> +		}
>> +
> 
> Can't we have this more integrated, maybe something like this?
> 
> 	enable_method = acpi_disabled ? of_get_property(dn, "enable-method", NULL)
> 		: acpi_get_cpu_boot_method();

I like this :)

> 	message = acpi_disabled ? dn->full_name : "";
> 
> 	...
> 	
> 	pr_warn("CPU %d: %s unsupported enable-method property: %s\n",
> 				cpu, message, enable_method)

In ACPI, there is no enable-method property, it is a term from, so I think the
message printed can be separated.

Thanks
Hanjun
