From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Sep 2015 19:08:08 +0100
Subject: [PATCH] arm64: cpu hotplug: ensure we mask out CPU_TASKS_FROZEN
 in notifiers
In-Reply-To: <1442249991-13345-1-git-send-email-will.deacon@arm.com>
References: <1442249991-13345-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150914180808.GA12541@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 05:59:51PM +0100, Will Deacon wrote:
> We have a couple of CPU hotplug notifiers for resetting the CPU debug
> state to a sane value when a CPU comes online.
> 
> This patch ensures that we mask out CPU_TASKS_FROZEN so that we don't
> miss any online events occuring due to suspend/resume.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/debug-monitors.c | 2 +-
>  arch/arm64/kernel/hw_breakpoint.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> 
> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
> index 9b3b62ac9c24..cebf78661a55 100644
> --- a/arch/arm64/kernel/debug-monitors.c
> +++ b/arch/arm64/kernel/debug-monitors.c
> @@ -134,7 +134,7 @@ static int os_lock_notify(struct notifier_block *self,
>  				    unsigned long action, void *data)
>  {
>  	int cpu = (unsigned long)data;
> -	if (action == CPU_ONLINE)
> +	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE)
>  		smp_call_function_single(cpu, clear_os_lock, NULL, 1);
>  	return NOTIFY_OK;
>  }
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 565244fd57ff..2926c3dd6479 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -878,7 +878,7 @@ static int hw_breakpoint_reset_notify(struct notifier_block *self,
>  						void *hcpu)
>  {
>  	int cpu = (long)hcpu;
> -	if (action == CPU_ONLINE)
> +	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE)
>  		smp_call_function_single(cpu, hw_breakpoint_reset, NULL, 1);
>  	return NOTIFY_OK;
>  }
> -- 
> 2.1.4
> 
