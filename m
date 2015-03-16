From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 16 Mar 2015 20:14:52 +0800
Subject: [update][PATCH v10 06/21] ACPI / sleep: Introduce
 CONFIG_ACPI_GENERIC_SLEEP
In-Reply-To: <2027737.r7gkxqZ3Xv@vostro.rjw.lan>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org>
 <2027737.r7gkxqZ3Xv@vostro.rjw.lan>
Message-ID: <5506C93C.704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?03?14? 05:49, Rafael J. Wysocki wrote:
> On Friday, March 13, 2015 04:14:29 PM Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> ACPI 5.1 does not currently support S states for ARM64 hardware but
>> ACPI code will call acpi_target_system_state() and acpi_sleep_init()
>> for device power management, so introduce CONFIG_ACPI_GENERIC_SLEEP
>> and select it for x86 and ia64 only to make sleep functions available,
>> and also introduce stub function to allow other drivers to function
>> until S states are defined for ARM64.
>>
>> It will be no functional change for x86 and IA64.
>>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Robert Richter <rrichter@cavium.com>
>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   arch/ia64/Kconfig       | 1 +
>>   arch/x86/Kconfig        | 1 +
>>   drivers/acpi/Kconfig    | 4 ++++
>>   drivers/acpi/Makefile   | 2 +-
>>   drivers/acpi/internal.h | 4 ++++
>>   5 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
>> index 074e52b..e8728d7 100644
>> --- a/arch/ia64/Kconfig
>> +++ b/arch/ia64/Kconfig
>> @@ -10,6 +10,7 @@ config IA64
>>   	select ARCH_MIGHT_HAVE_PC_SERIO
>>   	select PCI if (!IA64_HP_SIM)
>>   	select ACPI if (!IA64_HP_SIM)
>> +	select ACPI_GENERIC_SLEEP if ACPI
>>   	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
>>   	select HAVE_UNSTABLE_SCHED_CLOCK
>>   	select HAVE_IDE
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index b7d31ca..9804431 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -22,6 +22,7 @@ config X86_64
>>   ### Arch settings
>>   config X86
>>   	def_bool y
>> +	select ACPI_GENERIC_SLEEP if ACPI
>
> One more nit.  If you did
>
> +	select ACPI_GENERIC_SLEEP if ACPI_SLEEP
>
> here (and above for ia64), you'd avoid having to make ACPI_SLEEP
> depend on ACPI_GENERIC_SLEEP which goes somewhat backwards.

In sleep.c,

#ifdef CONFIG_ACPI_SLEEP
acpi_target_system_state()
{
}
#endif

and CONFIG_ACPI_SLEEP depends on SUSPEND || HIBERNATION,
which one of them will be enabled on ARM64 so ACPI_SLEEP
will also enabled too.

So if we

+select ACPI_GENERIC_SLEEP if ACPI_SLEEP

and

+acpi-$(CONFIG_ACPI_GENERIC_SLEEP) += sleep.o

it will lead to errors for acpi_target_system_state() that
is declared but not defined, so I will keep the code as
it is, what do you think?

Thanks
Hanjun
