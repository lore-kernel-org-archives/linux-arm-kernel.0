From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 25 Jun 2014 09:14:16 +0200
Subject: [PATCH v2] sched: Fix compiler warnings
In-Reply-To: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
References: <1403658329-13196-1-git-send-email-linux@roeck-us.net>
Message-ID: <20140625071416.GM14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 06:05:29PM -0700, Guenter Roeck wrote:
> Commit 143e1e28cb (sched: Rework sched_domain topology definition)
> introduced a number of functions with a return value of 'const int'.
> gcc doesn't know what to do with that and, if the kernel is compiled
> with W=1, complains with the following warnings whenever sched.h
> is included.
> 
> include/linux/sched.h:875:25: warning:
> 	type qualifiers ignored on function return type
> include/linux/sched.h:882:25: warning:
> 	type qualifiers ignored on function return type
> include/linux/sched.h:889:25: warning:
> 	type qualifiers ignored on function return type
> include/linux/sched.h:1002:21: warning:
> 	type qualifiers ignored on function return type
> 
> Commits fb2aa855 (sched, ARM: Create a dedicated scheduler topology table)
> and 607b45e9a (sched, powerpc: Create a dedicated topology table) introduce
> the same warning in the arm and powerpc code.
> 
> Drop 'const' from the function declarations to fix the problem.
> 
> The fix for all three patches has to be applied together to avoid
> compilation failures for the affected architectures.
> 
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Fix problem in all affected architectures with a single patch
>     to avoid compilation errors.
> 
>  arch/arm/kernel/topology.c | 2 +-
>  arch/powerpc/kernel/smp.c  | 2 +-
>  include/linux/sched.h      | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 9d85318..e35d880 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -275,7 +275,7 @@ void store_cpu_topology(unsigned int cpuid)
>  		cpu_topology[cpuid].socket_id, mpidr);
>  }
>  
> -static inline const int cpu_corepower_flags(void)
> +static inline int cpu_corepower_flags(void)
>  {
>  	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
>  }
Maybe the author's intention was:

	static inline int cpu_corepower_flags(void) __attribute__((const));

?
This specifies that the function has no side effects and the return value
only depends on the (here non-existing) function arguments.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
