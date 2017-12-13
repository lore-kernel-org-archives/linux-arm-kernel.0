From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 13 Dec 2017 02:05:33 +0100
Subject: [PATCH v3 1/2] cpuidle: Add new macro to enter a retention idle
 state
In-Reply-To: <1510765910-23739-2-git-send-email-pprakash@codeaurora.org>
References: <1510765910-23739-1-git-send-email-pprakash@codeaurora.org>
 <1510765910-23739-2-git-send-email-pprakash@codeaurora.org>
Message-ID: <2279450.Sc9T3hx1hA@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 15, 2017 6:11:49 PM CET Prashanth Prakash wrote:
> If a CPU is entering a low power idle state where it doesn't lose any
> context, then there is no need to call cpu_pm_enter()/cpu_pm_exit().
> Add a new macro(CPU_PM_CPU_IDLE_ENTER_RETENTION) to be used by cpuidle
> drivers when they are entering retention state. By not calling
> cpu_pm_enter and cpu_pm_exit we reduce the latency involved in
> entering and exiting the retention idle states.
> 
> CPU_PM_CPU_IDLE_ENTER_RETENTION assumes that no state is lost and
> hence CPU PM notifiers will not be called. We may need a broader
> change if we need to support partial retention states effeciently.
> 
> On ARM64 based Qualcomm Server Platform we measured below overhead for
> for calling cpu_pm_enter and cpu_pm_exit for retention states.
> 
> workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
>         Average overhead of cpu_pm_enter - 1.2us
>         Average overhead of cpu_pm_exit  - 3.1us
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  include/linux/cpuidle.h | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 8f7788d..871f9e2 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -257,22 +257,30 @@ static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
>  {return 0;}
>  #endif
>  
> -#define CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx)	\
> -({								\
> -	int __ret;						\
> -								\
> -	if (!idx) {						\
> -		cpu_do_idle();					\
> -		return idx;					\
> -	}							\
> -								\
> -	__ret = cpu_pm_enter();					\
> -	if (!__ret) {						\
> -		__ret = low_level_idle_enter(idx);		\
> -		cpu_pm_exit();					\
> -	}							\
> -								\
> -	__ret ? -1 : idx;					\
> +#define __CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, is_retention) \
> +({									\
> +	int __ret = 0;							\
> +									\
> +	if (!idx) {							\
> +		cpu_do_idle();						\
> +		return idx;						\
> +	}								\
> +									\
> +	if (!is_retention)						\
> +		__ret =  cpu_pm_enter();				\
> +	if (!__ret) {							\
> +		__ret = low_level_idle_enter(idx);			\
> +		if (!is_retention)					\
> +			cpu_pm_exit();					\
> +	}								\
> +									\
> +	__ret ? -1 : idx;						\
>  })
>  
> +#define CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx)	\
> +	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, 0)
> +
> +#define CPU_PM_CPU_IDLE_ENTER_RETENTION(low_level_idle_enter, idx)	\
> +	__CPU_PM_CPU_IDLE_ENTER(low_level_idle_enter, idx, 1)
> +
>  #endif /* _LINUX_CPUIDLE_H */
> 

This change is fine by me, so you can add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it, but it kind of doesn't make sense to apply it alone, so please feel free
to route it via ARM64.

Thanks,
Rafael
