From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 14 Jul 2015 17:50:11 +0800
Subject: [PATCH v2 3/3] drivers: firmware: psci: add system suspend support
In-Reply-To: <55A4D2F1.5070702@arm.com>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-4-git-send-email-sudeep.holla@arm.com>
 <20150714141703.0d77242c@xhacker>	<55A4D2F1.5070702@arm.com>
Message-ID: <20150714175011.31c3d714@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sudeep,

On Tue, 14 Jul 2015 10:14:25 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> 
> 
> On 14/07/15 07:17, Jisheng Zhang wrote:
> > Hi Sudeep,
> >
> > I'm sorry to being late. Just have some comments below.
> >
> > On Thu, 18 Jun 2015 15:41:34 +0100
> > Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> >> PSCI v1.0 introduces a new API called PSCI_SYSTEM_SUSPEND. This API
> >> provides the mechanism by which the calling OS can request entry into
> >> the deepest possible system sleep state.
> >>
> >> It meets all the necessary preconditions for entering suspend to RAM
> >> state in Linux. This patch adds support for PSCI_SYSTEM_SUSPEND in psci
> >> firmware and registers a psci system suspend operation to implement the
> >> suspend-to-RAM(s2r) in a generic way on all the platforms implementing
> >> PSCI.
> >>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>   drivers/firmware/psci.c   | 31 +++++++++++++++++++++++++++++++
> >>   include/uapi/linux/psci.h |  3 +++
> >>   2 files changed, 34 insertions(+)
> >>
> >> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> >> index 752ca7c9eb97..f2b2b3e1c6e4 100644
> >> --- a/drivers/firmware/psci.c
> >> +++ b/drivers/firmware/psci.c
> >> @@ -20,11 +20,13 @@
> >>   #include <linux/printk.h>
> >>   #include <linux/psci.h>
> >>   #include <linux/reboot.h>
> >> +#include <linux/suspend.h>
> >>
> >>   #include <uapi/linux/psci.h>
> >>
> >>   #include <asm/system_misc.h>
> >>   #include <asm/smp_plat.h>
> >> +#include <asm/suspend.h>
> >>
> >>   /*
> >>    * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> >> @@ -222,6 +224,33 @@ static int __init psci_features(u32 psci_func_id)
> >>   			      psci_func_id, 0, 0);
> >>   }
> >>
> >> +static int psci_system_suspend(unsigned long unused)
> >> +{
> >> +	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
> >> +			      virt_to_phys(cpu_resume), 0, 0);
> >> +}
> >> +
> >> +static int psci_system_suspend_enter(suspend_state_t state)
> >> +{
> >> +	return cpu_suspend(0, psci_system_suspend);
> >> +}
> >> +
> >> +static const struct platform_suspend_ops psci_suspend_ops = {
> >> +	.valid          = suspend_valid_only_mem,
> >> +	.enter          = psci_system_suspend_enter,
> >> +};
> >> +
> >> +static void __init psci_init_system_suspend(void)
> >> +{
> >> +	if (!IS_ENABLED(CONFIG_SUSPEND))
> >> +		return;
> >> +
> >> +	if (psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND)))
> >> +		return;
> >
> > So this requires the firmware implements SYSTEM_SUSPEND which doesn't exist
> > until PSCI 1.0,
> 
> Correct, if you need System to RAM in Linux on a platform with PSCI
> firmware, firmware *must implement* SYSTEM_SUSPEND.
> 
> > and even in PSCI 1.0 SYSTEM_SUSPEND is optional,
> 
> Optional here means, that you may chose to implement or not in the
> firmware. It doesn't mean we can implement S2R in Linux using other
> PSCI methods. SYSTEM_SUSPEND was added mainly to avoid since workarounds
> in the kernel.
> 
> >we also want
> > suspend to ram feature on PSCI 0.2 or PSCI 1.0 w/o SYSTEM_SUSPEND,
> 
> Why do you choose to have PSCIv1.0 w/o SYSTEM_SUSPEND when you need that
> feature in Linux. Is it just because we can manage with workarounds ?
> Sorry, that's not an option.

The problem is the PSCI 1.0 SYSTEM_SUSPEND definition: we can't pass something
like stateid as in CPU_SUSPEND to firmware. The stateid is used to tell
firmware to go to different Sleep state, for example S2 or S3.

With your RFC patch, it's easy to extend to support this feature, but if we
are limited to SYSTEM_SUSPEND in PSCI 1.0, we have to use a different code
path for non-S3 sleep state.

Is there any elegant solution?

Thanks,
Jisheng

> 
> > is there
> > any possibility to bring your previous RFC patch[1] back? Or ARM expect all
> > PSCI users must have SYSTEM_SUSPEND implemented if they want s2ram?
> 
> OK, we did expect response back then[1] when we clearly asked if the
> firmware can be upgraded to v1.0 from v0.2 as the delta is not much and
> helps up to avoid special DT bindings for that case. Since nobody
> responded for last 6 months, it's assumed that it's no longer required.
> 
> So to answer you, no the RFC is dead and it's expected to have PSCI
> firmware support for SYSTEM_SUSPEND if S2R is desired feature in Linux.
> 
> Regards,
> Sudeep
> 
> [1] 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/322278.html
