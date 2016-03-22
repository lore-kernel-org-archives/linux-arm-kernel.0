From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 22 Mar 2016 23:31:11 +0100
Subject: [PATCH v3 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <1458667179-19630-5-git-send-email-cmetcalf@mellanox.com>
References: <1458667179-19630-1-git-send-email-cmetcalf@mellanox.com>
 <1458667179-19630-5-git-send-email-cmetcalf@mellanox.com>
Message-ID: <54039485.X1biSGXPBa@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 22, 2016 01:19:39 PM Chris Metcalf wrote:
> When doing an nmi backtrace of many cores, most of which are idle,
> the output is a little overwhelming and very uninformative.  Suppress
> messages for cpus that are idling when they are interrupted and just
> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> 
> We do this by grouping all the cpuidle code together into a new
> .cpuidle.text section, and then checking the address of the
> interrupted PC to see if it lies within that section.
> 
> This commit suitably tags x86, arm64, and tile idle routines,
> and only adds in the minimal framework for other architectures.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> ---

[cut]

> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index cd4510a63375..924554f920fb 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -725,8 +725,8 @@ static struct cpuidle_state avn_cstates[] = {
>   *
>   * Must be called under local_irq_disable().
>   */
> -static int intel_idle(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index)
> +static __cpuidle int intel_idle(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
>  {
>  	unsigned long ecx = 1; /* break on interrupt flag */
>  	struct cpuidle_state *state = &drv->states[index];

Well, what about intel_idle_freeze()?  Or do we not care?

And analogous stuff in processor_idle.c for that matter?

acpi_idle_enter()/acpi_idle_enter_freeze() plus stuff called by those?

Thanks,
Rafael
