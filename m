From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 13 Oct 2017 12:51:39 -0500
Subject: [PATCH v3 2/7] ACPI: Enable PPTT support on ARM64
In-Reply-To: <59E08D32.2010605@huawei.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-3-jeremy.linton@arm.com> <59E08D32.2010605@huawei.com>
Message-ID: <68f0af6f-2552-0e1a-5242-a89acf3656d9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/13/2017 04:53 AM, Hanjun Guo wrote:
> Hi Jeremy,
> 
> On 2017/10/13 3:48, Jeremy Linton wrote:
>> Now that we have a PPTT parser, in preparation for its use
>> on arm64, lets build it.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/Kconfig         | 1 +
>>   drivers/acpi/Makefile      | 1 +
>>   drivers/acpi/arm64/Kconfig | 3 +++
>>   3 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 0df64a6a56d4..68c9d1289735 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -7,6 +7,7 @@ config ARM64
>>   	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>>   	select ACPI_MCFG if ACPI
>>   	select ACPI_SPCR_TABLE if ACPI
>> +	select ACPI_PPTT if ACPI
>>   	select ARCH_CLOCKSOURCE_DATA
>>   	select ARCH_HAS_DEBUG_VIRTUAL
>>   	select ARCH_HAS_DEVMEM_IS_ALLOWED
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 90265ab4437a..c92a0c937551 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -85,6 +85,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>>   obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>>   obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
>>   obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>> +obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>>   
>>   # processor has its own "processor." module_param namespace
>>   processor-y			:= processor_driver.o
>> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
>> index 5a6f80fce0d6..74b855a669ea 100644
>> --- a/drivers/acpi/arm64/Kconfig
>> +++ b/drivers/acpi/arm64/Kconfig
>> @@ -7,3 +7,6 @@ config ACPI_IORT
>>   
>>   config ACPI_GTDT
>>   	bool
>> +
>> +config ACPI_PPTT
>> +	bool
> 
> Can this be located in drivers/acpi/Kconfig? then other
> platform can select ACPI_PPTT if they want.

It can be, but I've been resisting doing that because without any 
callers using it will do little but bloat the code of anyone that dares 
enable it.

So my assumption is that when the code to enable PPTT on x86 shows up 
the config option can be moved as well.

How about I meet you 1/2 way, and put it in the acpi/Kconfig but wrapped 
in the arm64 exclusive section?
