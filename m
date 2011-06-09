From: dwalker@fifo99.com (Daniel Walker)
Date: Thu, 09 Jun 2011 06:41:50 -0700
Subject: [PATCH] msm: timer: compensate for timer shift in
	msm_read_timer_count
In-Reply-To: <1307591042-2369-1-git-send-email-johlstei@codeaurora.org>
References: <1307591042-2369-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1307626910.16418.1.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-08 at 20:44 -0700, Jeff Ohlstein wrote:
> Some msm targets have timers whose lower bits are unreliable. So, we
> present our timers as lower frequency than they actually are, and ignore
> the bottom 5 bits on such targets. This compensation was erroneously
> removed from the msm_read_timer_count function, so restore it.
> 
> This was broken by 94790ec25 "msm: timer: SMP timer support for msm".
> 
> Change-Id: I8c56bdf82629638748ccf352118ea664f967b87d

Drop this Change-ID ..

> Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
> ---
>  arch/arm/mach-msm/timer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> index 38b95e9..b3579fe 100644
> --- a/arch/arm/mach-msm/timer.c
> +++ b/arch/arm/mach-msm/timer.c
> @@ -100,7 +100,7 @@ static cycle_t msm_read_timer_count(struct clocksource *cs)
>  {
>  	struct msm_clock *clk = container_of(cs, struct msm_clock, clocksource);
>  
> -	return readl(clk->global_counter);
> +	return readl(clk->global_counter) >> clk->shift;
>  }

Could you comment in the code with something explaining what the shift
is doing.

Daniel
