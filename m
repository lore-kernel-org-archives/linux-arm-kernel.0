From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 20 Jan 2014 17:30:21 +0800
Subject: [PATCH 07/20] ARM64 / ACPI: Enable ARM64 in Kconfig
In-Reply-To: <52D93F88.8090801@arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-8-git-send-email-hanjun.guo@linaro.org>
 <52D93F88.8090801@arm.com>
Message-ID: <52DCECAD.9090906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-1-17 22:34, Sudeep Holla wrote:
> On 17/01/14 12:25, Hanjun Guo wrote:
>> Add Kconfigs to build ACPI on ARM64, and make ACPI runable on ARM64.
>>
>> acpi_idle driver is x86/IA64 dependent now, so make CONFIG_ACPI_PROCESSOR
>> depends on X86 || IA64, and implement it on ARM/ARM64 in the furture.
>>
>> In order to make arm-core.c can both run on ARM and ARM64, introduce
>> CONFIG_ACPI_ARM to support it.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/Kconfig         |    2 ++
>>  drivers/acpi/Kconfig       |   11 ++++++++---
>>  drivers/acpi/plat/Makefile |    2 +-
>>  3 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6d4dd22..2b1fb1d 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -279,6 +279,8 @@ source "net/Kconfig"
>>  
>>  source "drivers/Kconfig"
>>  
>> +source "drivers/acpi/Kconfig"
>> +
>>  source "fs/Kconfig"
>>  
>>  source "arch/arm64/kvm/Kconfig"
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 4770de5..cae5dc9 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -2,13 +2,16 @@
>>  # ACPI Configuration
>>  #
>>  
>> +config ACPI_ARM
>> +	bool
>> +
>>  menuconfig ACPI
>>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
>>  	depends on !IA64_HP_SIM
>> -	depends on IA64 || X86
>> -	depends on PCI
>> +	depends on ((IA64 || X86) && PCI) || ARM64
>>  	select PNP
>> -	default y
>> +	select ACPI_ARM if ARM64
>> +	default y if !ARM64
>>  	help
>>  	  Advanced Configuration and Power Interface (ACPI) support for 
>>  	  Linux requires an ACPI-compliant platform (hardware/firmware),
>> @@ -149,6 +152,7 @@ config ACPI_PROCESSOR
>>  	tristate "Processor"
>>  	select THERMAL
>>  	select CPU_IDLE
>> +	depends on X86 || IA64
> 
> This doesn't look correct to me. You are disabling Perf/Idle/Thermal/Throttling
> support for ARM64. Any particular reason ?

As I said in the change log, acpi_idle driver is x86/IA64 dependent now,
we should revisit it later for these drivers on ARM64.

Since this is the ARM ACPI core patches, I think we can implement it later.

> 
> Also this is conflicting with other change where you are adding/exporting
> boot_option_idle_override which is mainly used in processor_idle and that's
> disabled for ARM64 here.

boot_option_idle_override is used in processor_core.c and it is the common
file used by every processor drivers including the processor_idle driver,
if I didn't introduce boot_option_idle_override there will be compile errors.

Thanks
Hanjun
