From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 14 Jul 2015 19:40:38 +0800
Subject: [PATCH v2 3/3] drivers: firmware: psci: add system suspend support
In-Reply-To: <55A4EC37.7030900@arm.com>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-4-git-send-email-sudeep.holla@arm.com>
 <20150714141703.0d77242c@xhacker>	<55A4D2F1.5070702@arm.com>
 <20150714175011.31c3d714@xhacker>	<55A4EC37.7030900@arm.com>
Message-ID: <20150714194038.47ccf2e5@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sudeep,

On Tue, 14 Jul 2015 12:02:15 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> 
> 
> On 14/07/15 10:50, Jisheng Zhang wrote:
> > Dear Sudeep,
> >
> > On Tue, 14 Jul 2015 10:14:25 +0100
> > Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> >>
> >>
> >> On 14/07/15 07:17, Jisheng Zhang wrote:
> >>> Hi Sudeep,
> >>>
> >>> I'm sorry to being late. Just have some comments below.
> >>>
> >>> On Thu, 18 Jun 2015 15:41:34 +0100
> >>> Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>>
> >>>> PSCI v1.0 introduces a new API called PSCI_SYSTEM_SUSPEND. This API
> >>>> provides the mechanism by which the calling OS can request entry into
> >>>> the deepest possible system sleep state.
> >>>>
> >>>> It meets all the necessary preconditions for entering suspend to RAM
> >>>> state in Linux. This patch adds support for PSCI_SYSTEM_SUSPEND in psci
> >>>> firmware and registers a psci system suspend operation to implement the
> >>>> suspend-to-RAM(s2r) in a generic way on all the platforms implementing
> >>>> PSCI.
> >>>>
> >>>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>>> ---
> >>>>    drivers/firmware/psci.c   | 31 +++++++++++++++++++++++++++++++
> >>>>    include/uapi/linux/psci.h |  3 +++
> >>>>    2 files changed, 34 insertions(+)
> >>>>
> >>>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> >>>> index 752ca7c9eb97..f2b2b3e1c6e4 100644
> >>>> --- a/drivers/firmware/psci.c
> >>>> +++ b/drivers/firmware/psci.c
> >>>> @@ -20,11 +20,13 @@
> >>>>    #include <linux/printk.h>
> >>>>    #include <linux/psci.h>
> >>>>    #include <linux/reboot.h>
> >>>> +#include <linux/suspend.h>
> >>>>
> >>>>    #include <uapi/linux/psci.h>
> >>>>
> >>>>    #include <asm/system_misc.h>
> >>>>    #include <asm/smp_plat.h>
> >>>> +#include <asm/suspend.h>
> >>>>
> >>>>    /*
> >>>>     * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> >>>> @@ -222,6 +224,33 @@ static int __init psci_features(u32 psci_func_id)
> >>>>    			      psci_func_id, 0, 0);
> >>>>    }
> >>>>
> >>>> +static int psci_system_suspend(unsigned long unused)
> >>>> +{
> >>>> +	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
> >>>> +			      virt_to_phys(cpu_resume), 0, 0);
> >>>> +}
> >>>> +
> >>>> +static int psci_system_suspend_enter(suspend_state_t state)
> >>>> +{
> >>>> +	return cpu_suspend(0, psci_system_suspend);
> >>>> +}
> >>>> +
> >>>> +static const struct platform_suspend_ops psci_suspend_ops = {
> >>>> +	.valid          = suspend_valid_only_mem,
> >>>> +	.enter          = psci_system_suspend_enter,
> >>>> +};
> >>>> +
> >>>> +static void __init psci_init_system_suspend(void)
> >>>> +{
> >>>> +	if (!IS_ENABLED(CONFIG_SUSPEND))
> >>>> +		return;
> >>>> +
> >>>> +	if (psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND)))
> >>>> +		return;
> >>>
> >>> So this requires the firmware implements SYSTEM_SUSPEND which doesn't exist
> >>> until PSCI 1.0,
> >>
> >> Correct, if you need System to RAM in Linux on a platform with PSCI
> >> firmware, firmware *must implement* SYSTEM_SUSPEND.
> >>
> >>> and even in PSCI 1.0 SYSTEM_SUSPEND is optional,
> >>
> >> Optional here means, that you may chose to implement or not in the
> >> firmware. It doesn't mean we can implement S2R in Linux using other
> >> PSCI methods. SYSTEM_SUSPEND was added mainly to avoid since workarounds
> >> in the kernel.
> >>
> >>> we also want
> >>> suspend to ram feature on PSCI 0.2 or PSCI 1.0 w/o SYSTEM_SUSPEND,
> >>
> >> Why do you choose to have PSCIv1.0 w/o SYSTEM_SUSPEND when you need that
> >> feature in Linux. Is it just because we can manage with workarounds ?
> >> Sorry, that's not an option.
> >
> > The problem is the PSCI 1.0 SYSTEM_SUSPEND definition: we can't pass something
> > like stateid as in CPU_SUSPEND to firmware. The stateid is used to tell
> > firmware to go to different Sleep state, for example S2 or S3.
> >
> 
> Can you elaborate on S2 here with an example ? You are using ACPI
> Sleep State definitions here which should not be mixed with PSCI.

Yes, it's ACPI concept. Here "S2" can be the "S2" mentioned in PSCI 1.0 spec.

PSCI 1.0 SPEC says:

"While ACPI distinguishes between two system level suspend to RAM states,
S2 and S3, PSCI provides a single API. In practice, operating systems use
only one suspend to RAM state, so this is not seen as a limitation. Note
that this specification is using the state definitions of S2 and S3 provided
by ACPI, but does not limit use of this PSCI function to ACPI based systems.
Semantics such as those described for sleep states S2 and S3 are used in
non-ACPI based systems."

Here is an example:

S3 is the state where All devices are suspended and power down,  memory is
placed in self-refresh mode. Usually this is the suspend to ram state.

S2 is the state where devices except cpus are suspended and put in a
low-power state(not power off), if the deivce doesn't support lower power mode,
the device is left on. memory is placed in self-refresh mode. secondary CPUs
are powered off via. PSCI_CPU_OFF, boot cpu is put into WFI state and runs at
low freq.

Thanks,
Jisheng

> 
> *Let's refrain ourselves from using ACPI S-states here* until it's well
> defined on ARM systems. The current definition is x86 based and doesn't
> suit ARM at all.
> 
> It's difficult to distinguish between the intermediate system suspend
> sleep states you are referring and the composite cpu idle states. That's
> the reason I am asking for the example to see if the sleep states you
> referring can be considered as composite cpu idle states.
> I strongly believe that's the case.
> 
> I would consider any other states as composite CPU idle states. In
> order to utilize Linux PM features, we would use PSCI functions as
> below.
> 
> /-----------------------------------\
> | PSCI Feature   | Linux PM feature |
> |-----------------------------------|
> | SYSTEM_SUSPEND |  Suspend-to-RAM  |
> |-----------------------------------|
> | SYSTEM_SHUTDOWN|  Suspend-to-Disk |
> \-----------------------------------/
> 
> > With your RFC patch, it's easy to extend to support this feature, but if we
> > are limited to SYSTEM_SUSPEND in PSCI 1.0, we have to use a different code
> > path for non-S3 sleep state.
> >
> 
> As I said above can you provide examples for such states.
> 
> Regards,
> Sudeep
