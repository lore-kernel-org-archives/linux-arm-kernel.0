From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 25 Jul 2014 18:39:08 +0800
Subject: [PATCH 09/19] ARM64 / ACPI: Move the initialization of
 cpu_logical_map(0) before acpi_boot_init()
In-Reply-To: <20140724152103.GB26190@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-10-git-send-email-hanjun.guo@linaro.org>
 <20140724152103.GB26190@leverpostej>
Message-ID: <53D233CC.1070006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-24 23:21, Mark Rutland wrote:
> On Thu, Jul 24, 2014 at 02:00:15PM +0100, Hanjun Guo wrote:
>> Move the initialization of cpu_logical_map(0) before acpi_boot_init()
>> to remove the duplicated initialization of cpu_logical_map(0).
> 
> It always make sense to initialise CPU0's logical map entry from the
> hardware values, so you could do this earlier in the series, before you
> introduce any ACPI code. Then you don't have the churn in acpi.c

ok, I will prepare a separate patch to do this before ACPI code, does it
make sense to you?

> 
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/kernel/acpi.c  |    3 ---
>>  arch/arm64/kernel/setup.c |    3 ++-
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index 801e268..ff0f6a0 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -244,9 +244,6 @@ int __init acpi_boot_init(void)
>>  	if (err)
>>  		pr_err("Can't find FADT\n");
>>  
>> -	/* Get the boot CPU's MPIDR before MADT parsing */
>> -	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>> -
>>  	err = acpi_parse_madt_gic_cpu_interface_entries();
>>  
>>  	return err;
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index e00d40c..17ab98e 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -394,13 +394,14 @@ void __init setup_arch(char **cmdline_p)
>>  
>>  	efi_idmap_init();
>>  
>> +	/* Get the boot CPU's MPIDR before cpu logical map is built */
> 
> That comment's a bit useless; I think it can just be dropped.
> 
> All you need to do is move the initialisation of cpu_logical_map(0)
> before unflatten_device_tree(). When you introduce acpi_boot_init(),
> place it after the initialisation.

ok, I agree with you, will update it.

Thanks
Hanjun
