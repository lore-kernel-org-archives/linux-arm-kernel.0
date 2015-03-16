From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 16 Mar 2015 19:45:25 +0800
Subject: [PATCH v10 10/21] ARM64 / ACPI: Get PSCI flags in FADT for PSCI
 init
In-Reply-To: <20150313145111.GB5229@red-moon>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-11-git-send-email-hanjun.guo@linaro.org>
 <20150313145111.GB5229@red-moon>
Message-ID: <5506C255.3020307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?03?13? 22:51, Lorenzo Pieralisi wrote:
> On Wed, Mar 11, 2015 at 12:39:36PM +0000, Hanjun Guo wrote:
>
> [...]
>
>> +static void __init psci_0_2_set_functions(void)
>> +{
>> +	pr_info("Using standard PSCI v0.2 function IDs\n");
>> +	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_0_2_FN64_CPU_SUSPEND;
>> +	psci_ops.cpu_suspend = psci_cpu_suspend;
>> +
>> +	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
>> +	psci_ops.cpu_off = psci_cpu_off;
>> +
>> +	psci_function_id[PSCI_FN_CPU_ON] = PSCI_0_2_FN64_CPU_ON;
>> +	psci_ops.cpu_on = psci_cpu_on;
>> +
>> +	psci_function_id[PSCI_FN_MIGRATE] = PSCI_0_2_FN64_MIGRATE;
>> +	psci_ops.migrate = psci_migrate;
>> +
>> +	psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_0_2_FN64_AFFINITY_INFO;
>> +	psci_ops.affinity_info = psci_affinity_info;
>> +
>> +	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] =
>> +		PSCI_0_2_FN_MIGRATE_INFO_TYPE;
>> +	psci_ops.migrate_info_type = psci_migrate_info_type;
>> +
>> +	arm_pm_restart = psci_sys_reset;
>> +
>> +	pm_power_off = psci_sys_poweroff;
>> +}
>> +
>>   /*
>>    * PSCI Function IDs for v0.2+ are well defined so use
>>    * standard values.
>> @@ -306,29 +335,7 @@ static int __init psci_0_2_init(struct device_node *np)
>>   		}
>>   	}
>>
>> -	pr_info("Using standard PSCI v0.2 function IDs\n");
>> -	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_0_2_FN64_CPU_SUSPEND;
>> -	psci_ops.cpu_suspend = psci_cpu_suspend;
>> -
>> -	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
>> -	psci_ops.cpu_off = psci_cpu_off;
>> -
>> -	psci_function_id[PSCI_FN_CPU_ON] = PSCI_0_2_FN64_CPU_ON;
>> -	psci_ops.cpu_on = psci_cpu_on;
>> -
>> -	psci_function_id[PSCI_FN_MIGRATE] = PSCI_0_2_FN64_MIGRATE;
>> -	psci_ops.migrate = psci_migrate;
>> -
>> -	psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_0_2_FN64_AFFINITY_INFO;
>> -	psci_ops.affinity_info = psci_affinity_info;
>> -
>> -	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] =
>> -		PSCI_0_2_FN_MIGRATE_INFO_TYPE;
>> -	psci_ops.migrate_info_type = psci_migrate_info_type;
>> -
>> -	arm_pm_restart = psci_sys_reset;
>> -
>> -	pm_power_off = psci_sys_poweroff;
>> +	psci_0_2_set_functions();
>
> You should have factored out the firmware version probing too, that's
> the only way we can detect the PSCI firmware version when booting through
> ACPI. You can end up initializing pointers for v0.2+ with a mismatching
> version implemented in PSCI firmware, eg 0.1.
>
> We should do that incrementally, I will put together a patch to
> factor out the FW version probing first, you can rebase on top of it.

Incrementally patches on top of this patch set? I think v10 of this
patch set is ready for merge, but I'm open for suggestions if we will
not miss the merge window for Catalin.

>
>>   out_put_node:
>>   	of_node_put(np);
>> @@ -381,7 +388,7 @@ static const struct of_device_id psci_of_match[] __initconst = {
>>   	{},
>>   };
>>
>> -int __init psci_init(void)
>> +int __init psci_dt_init(void)
>>   {
>>   	struct device_node *np;
>>   	const struct of_device_id *matched_np;
>> @@ -396,6 +403,29 @@ int __init psci_init(void)
>>   	return init_fn(np);
>>   }
>>
>> +/*
>> + * We use PSCI 0.2+ when ACPI is deployed on ARM64 and it's
>> + * explicitly clarified in SBBR
>> + */
>> +int __init psci_acpi_init(void)
>> +{
>> +	if (!acpi_psci_present()) {
>> +		pr_info("is not implemented in ACPI.\n");
>> +		return -EOPNOTSUPP;
>> +	}
>
> If PSCI is not present, that's a problem related to SMP init, right ?
> That's where a warning should be printed if any, not here, the SBBR
> mandates PSCI as secondaries bring up method, warn otherwise.

The SBBR is also said that if PSCI is not available, Parking protocol
will be used as secondaries bring up method, so I said that it is ok
to me that we don't print warn message for no PSCI support when parsing
FADT.

So maybe we can go back to the previous solution, print some warning
message if no PSCI when parsing FADT?

Thanks
Hanjun
