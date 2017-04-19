From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Apr 2017 18:54:55 +0100
Subject: [patch V2 11/24] ARM/hw_breakpoint: Use
 cpuhp_setup_state_cpuslocked()
In-Reply-To: <20170418170553.274229815@linutronix.de>
References: <20170418170442.665445272@linutronix.de>
 <20170418170553.274229815@linutronix.de>
Message-ID: <20170419175454.GM27829@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 18, 2017 at 07:04:53PM +0200, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> arch_hw_breakpoint_init() holds get_online_cpus() while registerring the
> hotplug callbacks.
> 
> cpuhp_setup_state() invokes get_online_cpus() as well. This is correct, but
> prevents the conversion of the hotplug locking to a percpu rwsem.
> 
> Use cpuhp_setup_state_cpuslocked() to avoid the nested call.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> 
> ---
>  arch/arm/kernel/hw_breakpoint.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -1098,8 +1098,9 @@ static int __init arch_hw_breakpoint_ini
>  	 * assume that a halting debugger will leave the world in a nice state
>  	 * for us.
>  	 */
> -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm/hw_breakpoint:online",
> -				dbg_reset_online, NULL);
> +	ret = cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN,
> +					   "arm/hw_breakpoint:online",
> +					   dbg_reset_online, NULL);

Given the callsite, this particular change looks ok to me. So FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

However, as a more general note, the changes make the API feel odd. per
their current names, {get,put}_online_cpus() sound/feel like refcounting
ops, which should be able to nest.

Is there any chance these could get a better name, e.g.
{lock,unlock}_online_cpus(), so as to align with _cpuslocked?

Thanks,
Mark.
