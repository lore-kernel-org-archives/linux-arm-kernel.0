From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Jun 2016 18:29:23 +0200
Subject: [PATCH v6 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <20160622141700.GB2733@red-moon>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-5-git-send-email-sudeep.holla@arm.com>
 <20160622141700.GB2733@red-moon>
Message-ID: <57715463.5040305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2016 04:17 PM, Lorenzo Pieralisi wrote:
> Hi Sudeep,
>
> On Tue, Jun 14, 2016 at 03:48:38PM +0100, Sudeep Holla wrote:
>> This patch adds appropriate callbacks to support ACPI Low Power Idle
>> (LPI) on ARM64.
>>
>> Now that arm_enter_idle_state is exactly same in both generic ARM{32,64}
>> CPUIdle driver and ARM64 backend for ACPI processor idle driver, we can
>> unify it and move to cpuidle-arm.h header.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/kernel/cpuidle.c   | 17 +++++++++++++
>>   drivers/cpuidle/cpuidle-arm.c | 23 ++----------------
>>   drivers/firmware/psci.c       | 56 +++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/cpuidle-arm.h   | 30 +++++++++++++++++++++++
>>   4 files changed, 105 insertions(+), 21 deletions(-)
>>   create mode 100644 include/linux/cpuidle-arm.h
>
> This patch seems fine by me, it would be good if Daniel can have
> a look too.
>
> Some minor comments below.
>
> [...]
>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index 03e04582791c..c6caa863d156 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -13,6 +13,7 @@
>>
>>   #define pr_fmt(fmt) "psci: " fmt
>>
>> +#include <linux/acpi.h>
>>   #include <linux/arm-smccc.h>
>>   #include <linux/cpuidle.h>
>>   #include <linux/errno.h>
>> @@ -310,11 +311,66 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>>   	return ret;
>>   }
>>
>> +#ifdef CONFIG_ACPI
>> +#include <acpi/processor.h>
>> +
>> +static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
>> +{
>> +	int i, count;
>> +	u32 *psci_states;
>> +	struct acpi_processor *pr;
>> +	struct acpi_lpi_state *lpi;
>> +
>> +	pr = per_cpu(processors, cpu);
>> +	if (unlikely(!pr || !pr->flags.has_lpi))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * If the PSCI cpu_suspend function hook has not been initialized
>> +	 * idle states must not be enabled, so bail out
>> +	 */
>> +	if (!psci_ops.cpu_suspend)
>> +		return -EOPNOTSUPP;
>> +
>> +	count = pr->power.count - 1;
>> +	if (count <= 0)
>> +		return -ENODEV;
>> +
>> +	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
>> +	if (!psci_states)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		u32 state;
>> +
>> +		lpi = &pr->power.lpi_states[i + 1];
>> +		state = lpi->address & 0xFFFFFFFF;

Why mask 'address' if 'state' is u32 ?

>> +		if (!psci_power_state_is_valid(state)) {
>> +			pr_warn("Invalid PSCI power state %#x\n", state);
>> +			kfree(psci_states);
>> +			return -EINVAL;
>> +		}
>> +		psci_states[i] = state;
>> +	}
>> +	/* Idle states parsed correctly, initialize per-cpu pointer */
>> +	per_cpu(psci_power_state, cpu) = psci_states;
>> +	return 0;

The ACPI and the PSCI code are not self contained here.

It would be nice to move this function to the ACPI code.

>> +}
>> +#else
>> +static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
>> +{
>> +	return -EINVAL;
>> +}
>> +#endif
>> +
>>   int psci_cpu_init_idle(unsigned int cpu)
>>   {
>>   	struct device_node *cpu_node;
>>   	int ret;
>>
>> +	if (!acpi_disabled)
>> +		return psci_acpi_cpu_init_idle(cpu);
>> +

acpi_disabled - acpi_disabled - acpi_disabled everywhere :/

The enable-method approach is not straightforward and now it is polluted 
by acpi-disabled.

So IIUC,

smp_init_cpus (contains acpi_disabled)
   smp_cpu_setup
     cpu_read_ops
       cpu_read_enable_method (contains acpi_disabled)
         acpi_get_enable_method (returns 'psci' after checking 
psci_is_present)

Then psci_cpu_init_idle is called... and check again acpi_disabled.

IMO, the circumlocution with the psci vs acpi vs acpi_disabled is 
getting unnecessary too complex, is prone to error and will lead to 
unmaintainable code very soon.

I suggest to sort out encapsulation and self-contained code before 
adding more feature in this area.


>>   	cpu_node = of_get_cpu_node(cpu, NULL);
>>   	if (!cpu_node)
>>   		return -ENODEV;
>> diff --git a/include/linux/cpuidle-arm.h b/include/linux/cpuidle-arm.h
>> new file mode 100644
>> index 000000000000..b99bcb3f43dd
>> --- /dev/null
>> +++ b/include/linux/cpuidle-arm.h
>
> arm-cpuidle.h for consistency with other (ARM) include/linux files ?
>
>> @@ -0,0 +1,30 @@
>> +#include <linux/cpu_pm.h>
>> +
>> +#include <asm/cpuidle.h>
>> +
>> +/*
>> + * arm_enter_idle_state - Programs CPU to enter the specified state
>> + */
>> +static int arm_generic_enter_idle_state(int idx)
>> +{
>> +	int ret;
>> +
>> +	if (!idx) {
>> +		cpu_do_idle();
>> +		return idx;
>> +	}
>> +
>> +	ret = cpu_pm_enter();
>> +	if (!ret) {
>> +		/*
>> +		 * Pass idle state index to cpu_suspend which in turn will
>> +		 * call the CPU ops suspend protocol with idle index as a
>> +		 * parameter.
>> +		 */
>> +		ret = arm_cpuidle_suspend(idx);
>> +
>> +		cpu_pm_exit();
>> +	}
>> +
>> +	return ret ? -1 : idx;
>> +}
>
> Either you do this, or we have to add it somehow somewhere in
> drivers/cpuidle to avoid duplicating it.
>
> @Daniel: do you have an opinion on this please ?

I don't like the idea to add an ARM arch specific header in 
include/linux. I thought this directory was supposed to contain as much 
as possible arch agnostic headers.

May be the name can be changed to something more generic:

eg.

int cpuidle_generic_enter(int idx);

and then add an option:

HAVE_CPUIDLE_GENERIC_ENTER

, then in the generic header:

#ifdef HAVE_CPUIDLE_GENERIC_ENTER
int cpuidle_generic_enter(int idx);
#endif

, change the function name in cpuidle-arm .c

and finally add in the ARM and ARM64 Kconfig's option 
HAVE_CPUIDLE_GENERIC_ENTER.


   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
