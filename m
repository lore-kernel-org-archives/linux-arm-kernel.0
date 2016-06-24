From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 25 Jun 2016 00:47:41 +0200
Subject: [PATCH v6 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <576DA047.7080808@linaro.org>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <20160622141700.GB2733@red-moon> <576DA047.7080808@linaro.org>
Message-ID: <15462807.mkANpcI9rV@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 24, 2016 11:04:07 PM Daniel Lezcano wrote:
> On 06/22/2016 04:17 PM, Lorenzo Pieralisi wrote:
> > Hi Sudeep,
> >
> > On Tue, Jun 14, 2016 at 03:48:38PM +0100, Sudeep Holla wrote:
> >> This patch adds appropriate callbacks to support ACPI Low Power Idle
> >> (LPI) on ARM64.
> >>
> >> Now that arm_enter_idle_state is exactly same in both generic ARM{32,64}
> >> CPUIdle driver and ARM64 backend for ACPI processor idle driver, we can
> >> unify it and move to cpuidle-arm.h header.
> >>
> >> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>   arch/arm64/kernel/cpuidle.c   | 17 +++++++++++++
> >>   drivers/cpuidle/cpuidle-arm.c | 23 ++----------------
> >>   drivers/firmware/psci.c       | 56 +++++++++++++++++++++++++++++++++++++++++++
> >>   include/linux/cpuidle-arm.h   | 30 +++++++++++++++++++++++
> >>   4 files changed, 105 insertions(+), 21 deletions(-)
> >>   create mode 100644 include/linux/cpuidle-arm.h
> >
> > This patch seems fine by me, it would be good if Daniel can have
> > a look too.
> >
> > Some minor comments below.
> >
> > [...]
> >
> >> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> >> index 03e04582791c..c6caa863d156 100644
> >> --- a/drivers/firmware/psci.c
> >> +++ b/drivers/firmware/psci.c
> >> @@ -13,6 +13,7 @@
> >>
> >>   #define pr_fmt(fmt) "psci: " fmt
> >>
> >> +#include <linux/acpi.h>
> >>   #include <linux/arm-smccc.h>
> >>   #include <linux/cpuidle.h>
> >>   #include <linux/errno.h>
> >> @@ -310,11 +311,66 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
> >>   	return ret;
> >>   }
> >>
> >> +#ifdef CONFIG_ACPI
> >> +#include <acpi/processor.h>
> >> +
> >> +static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
> >> +{
> >> +	int i, count;
> >> +	u32 *psci_states;
> >> +	struct acpi_processor *pr;
> >> +	struct acpi_lpi_state *lpi;
> >> +
> >> +	pr = per_cpu(processors, cpu);
> >> +	if (unlikely(!pr || !pr->flags.has_lpi))
> >> +		return -EINVAL;
> >> +
> >> +	/*
> >> +	 * If the PSCI cpu_suspend function hook has not been initialized
> >> +	 * idle states must not be enabled, so bail out
> >> +	 */
> >> +	if (!psci_ops.cpu_suspend)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	count = pr->power.count - 1;
> >> +	if (count <= 0)
> >> +		return -ENODEV;
> >> +
> >> +	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> >> +	if (!psci_states)
> >> +		return -ENOMEM;
> >> +
> >> +	for (i = 0; i < count; i++) {
> >> +		u32 state;
> >> +
> >> +		lpi = &pr->power.lpi_states[i + 1];
> >> +		state = lpi->address & 0xFFFFFFFF;
> 
> Why is needed to mask 'address' ?
> 
> >> +		if (!psci_power_state_is_valid(state)) {
> >> +			pr_warn("Invalid PSCI power state %#x\n", state);
> >> +			kfree(psci_states);
> >> +			return -EINVAL;
> >> +		}
> >> +		psci_states[i] = state;
> >> +	}
> >> +	/* Idle states parsed correctly, initialize per-cpu pointer */
> >> +	per_cpu(psci_power_state, cpu) = psci_states;
> >> +	return 0;
> >
> > Most of the code in this function is FW independent, it would be nice
> > to factor it out and add the respective ACPI/DT helper functions to
> > retrieve idle states count and parameters, we can update it later
> > anyway it is fine by me to leave it as it is.
> >
> >> +}
> >> +#else
> >> +static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
> >> +{
> >> +	return -EINVAL;
> >> +}
> >> +#endif
> >> +
> >>   int psci_cpu_init_idle(unsigned int cpu)
> >>   {
> >>   	struct device_node *cpu_node;
> >>   	int ret;
> >>
> >> +	if (!acpi_disabled)
> >> +		return psci_acpi_cpu_init_idle(cpu);
> 
> Is it possible the case where there is information in both the DT and in 
> ACPI ?

No, it isn't.

It is either-or, never both at the same time.

Thanks,
Rafael
