From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 11:44:08 +0100
Subject: [PATCH 04/17] ARM: vfp: Use cpu pm notifiers to save vfp state
In-Reply-To: <1310053830-23779-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-5-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20110709104408.GK4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 04:50:17PM +0100, Lorenzo Pieralisi wrote:
> From: Colin Cross <ccross@android.com>
> 
> When the cpu is powered down in a low power mode, the vfp
> registers may be reset.
> 
> This patch uses CPU_PM_ENTER and CPU_PM_EXIT notifiers to save
> and restore the cpu's vfp registers.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
>  arch/arm/vfp/vfpmodule.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> index f25e7ec..6f08dbe 100644
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -21,6 +21,7 @@
>  #include <asm/cputype.h>
>  #include <asm/thread_notify.h>
>  #include <asm/vfp.h>
> +#include <asm/cpu_pm.h>
>  
>  #include "vfpinstr.h"
>  #include "vfp.h"
> @@ -169,6 +170,44 @@ static struct notifier_block vfp_notifier_block = {
>  	.notifier_call	= vfp_notifier,
>  };
>  
> +#ifdef CONFIG_CPU_PM
> +static int vfp_cpu_pm_notifier(struct notifier_block *self, unsigned long cmd,
> +	void *v)
> +{
> +	u32 fpexc = fmrx(FPEXC);
> +	unsigned int cpu = smp_processor_id();
> +
> +	switch (cmd) {
> +	case CPU_PM_ENTER:
> +		if (last_VFP_context[cpu]) {
> +			fmxr(FPEXC, fpexc | FPEXC_EN);
> +			vfp_save_state(last_VFP_context[cpu], fpexc);
> +			/* force a reload when coming back from idle */
> +			last_VFP_context[cpu] = NULL;
> +			fmxr(FPEXC, fpexc & ~FPEXC_EN);
> +		}
> +		break;

This doesn't look right.  On SMP setups, we always save the state of an
enabled VFP on thread switches.  That means the saved context in every
thread is always up to date for all threads, except _possibly_ for the
currently executing thread on the CPU.

On UP setups, we only save the state when we need to, so we need to do
something like the above.

However, we're growing more and more functions in the VFP code dealing
with saving and restoring state, and it's starting to become really silly
and confusing about which function is called for what and why, and why
it's different from another function doing something similar.

We need to sort this out so we have a _sane_ approach to this, rather
than inventing more and more creative ways to save VFP state and
restore it later.
