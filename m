From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Dec 2015 18:47:42 +0000
Subject: [PATCH v3 4/4] drivers: psci: replace psci firmware calls
In-Reply-To: <1448449461-5043-5-git-send-email-jens.wiklander@linaro.org>
References: <1448449461-5043-1-git-send-email-jens.wiklander@linaro.org>
 <1448449461-5043-5-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20151201184741.GE29045@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

On Wed, Nov 25, 2015 at 12:04:21PM +0100, Jens Wiklander wrote:
> Switch to use a generic interface for issuing SMC/HVC based on ARM SMC
> Calling Convention. Removes now the now unused psci-call.S.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/kernel/Makefile      |  1 -
>  arch/arm/kernel/psci-call.S   | 31 -------------------------------
>  arch/arm64/kernel/Makefile    |  2 +-
>  arch/arm64/kernel/psci-call.S | 28 ----------------------------
>  drivers/firmware/psci.c       | 23 +++++++++++++++++++++--
>  5 files changed, 22 insertions(+), 63 deletions(-)
>  delete mode 100644 arch/arm/kernel/psci-call.S
>  delete mode 100644 arch/arm64/kernel/psci-call.S

As a heads-up, this conflicts with changes in drivers/firmware/psci.c
that appeared in for v4.4-rc1.

The conflict is trivial (upstream some functions were added to the same
location as the invocation functions), but even git am -3 doesn't seem
to be able to fix that up automatically, so it would be good if you
could rebase this to v4.4-rc1 so as to avoid that conflict.

> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 42700f0..9c55d11 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -19,6 +19,7 @@
>  #include <linux/pm.h>
>  #include <linux/printk.h>
>  #include <linux/psci.h>
> +#include <linux/arm-smccc.h>
>  #include <linux/reboot.h>

Nit: please move the arm-smccc.h include to the start of the list to
keep this ordered alphabetically.

> +static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
> +			unsigned long arg0, unsigned long arg1,
> +			unsigned long arg2)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_hvc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
> +	return res.a0;
> +}
> +
> +static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
> +			unsigned long arg0, unsigned long arg1,
> +			unsigned long arg2)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
> +	return res.a0;
> +}
> +

As mentioned above, this part needs to be rebased to v4.4-rc1 to avoid
conflicts.

I've given this a spin on arm64 (native and virtual) and arm (virtual).
SMP bringup, hotplug, and reboot worked as expected in all cases.

Assuming you apply the fixes requested above, for the PSCI parts:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

What's the plan for merging this? I assume this'll go via arm-soc?

Thanks,
Mark.
