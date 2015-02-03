From: joshc@ni.com (Josh Cartwright)
Date: Tue, 3 Feb 2015 14:13:26 -0600
Subject: [PATCH] clocksource: mark sched_clock_read functions notrace
In-Reply-To: <1422643216-26673-1-git-send-email-nathan.sullivan@ni.com>
References: <1422643216-26673-1-git-send-email-nathan.sullivan@ni.com>
Message-ID: <20150203201326.GH11832@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 12:40:15PM -0600, Nathan Sullivan wrote:
> These functions will be called by ftrace code when function_graph is
> used, so mark them notrace to avoid infinite recursion.

It would be useful to have a full stack trace to show the particular
case you're hitting.  Is the issue that trace_clock_local() is calling
sched_clock(), and in these cases sched_clock() isn't being marked
notrace?

> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
>  drivers/clocksource/arm_arch_timer.c    |    2 +-
>  drivers/clocksource/arm_global_timer.c  |    2 +-
>  drivers/clocksource/samsung_pwm_timer.c |    2 +-
>  drivers/clocksource/timer-prima2.c      |    2 +-
>  drivers/clocksource/timer-sun5i.c       |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 095c177..df5af55 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -405,7 +405,7 @@ u32 arch_timer_get_rate(void)
>  	return arch_timer_rate;
>  }
>  
> -static u64 arch_counter_get_cntvct_mem(void)
> +static u64 notrace arch_counter_get_cntvct_mem(void)

Assuming you're trying to mark all sched_clock() implementations
notrace, then you missed a few: arch_counter_get_cntvct and
arch_counter_get_cntpct.

  Josh
