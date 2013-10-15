From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Oct 2013 12:27:15 +0100
Subject: [PATCH v2 08/13] arm64: kernel: implement debug monitors CPU PM
 notifiers
In-Reply-To: <1381748590-14279-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1381748590-14279-9-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20131015112715.GC30411@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 12:03:05PM +0100, Lorenzo Pieralisi wrote:
> When a CPU is shutdown either through CPU idle or suspend to RAM, the
> content of debug monitor registers must be reset or restored to proper
> values when CPU resume from low power states. This patch implements a
> CPU PM notifier that allows to restore the content of debug monitor
> registers to allow proper suspend/resume operations.

How do you deal with pstate in this series? In particular, the single-step
state machine is partially driven by bits in the SPSR, so you need to be
careful with preserving that (may even require a dummy exception return...
not sure).

> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/kernel/debug-monitors.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index cbfacf7..28ce685 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include <linux/cpu.h>
> +#include <linux/cpu_pm.h>
>  #include <linux/debugfs.h>
>  #include <linux/hardirq.h>
>  #include <linux/init.h>
> @@ -154,6 +155,42 @@ static struct notifier_block os_lock_nb = {
>  	.notifier_call = os_lock_notify,
>  };
>  
> +#ifdef CONFIG_CPU_PM
> +static DEFINE_PER_CPU(u32, mdscr);
> +
> +static int dm_cpu_pm_notify(struct notifier_block *self, unsigned long action,
> +			    void *v)
> +{
> +	switch (action) {
> +	case CPU_PM_ENTER:
> +		__get_cpu_var(mdscr) = mdscr_read();

I'm concerned about simply saving/restoring the mdscr. Both the MDE and KDE
bits are ref-counted for each CPU, so we'd need to guarantee no context
switching between the CPU_PM_ENTER and CPU_PM_EXIT invocations of this
notifier. Is that the case?

> +		break;
> +	case CPU_PM_EXIT:
> +		clear_os_lock(NULL);
> +		mdscr_write(__get_cpu_var(mdscr));

I think you should do this the other way round. Also, back to PSTATE, you
need to take care when clearing the D bit, since you definitely want to
either restore or zero the mdscr first.

Will
