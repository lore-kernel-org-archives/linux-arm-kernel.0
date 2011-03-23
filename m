From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 23 Mar 2011 18:13:02 +0000
Subject: [PATCH] ARM: perf: ensure overflows aren't missed due to IRQ
	latency
In-Reply-To: <1300895525-10800-1-git-send-email-will.deacon@arm.com>
References: <1300895525-10800-1-git-send-email-will.deacon@arm.com>
Message-ID: <20110323181302.GF2795@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, Mar 23, 2011 at 03:52:05PM +0000, Will Deacon wrote:
> If a counter overflows during a perf stat profiling run it may overtake
> the last known value of the counter:
> 
>     0        prev     new                0xffffffff
>     |----------|-------|----------------------|
> 
> In this case, the number of events that have occurred is
> (0xffffffff - prev) + new. Unfortunately, the event update code will
> not realise an overflow has occurred and will instead report the event
> delta as (new - prev) which may be considerably smaller than the real
> count.
> 
> This patch adds an extra argument to armpmu_event_update which indicates
> whether or not an overflow has occurred. If an overflow has occurred and
> the new count value is greater than the previous one, then we add on
> the remaining event period (which must have expired for the overflow to
> occur) and the previous count value.
> 
> Cc: Jamie Iles <jamie@jamieiles.com>
> Reported-by: Ashwin Chaugule <ashbertslists@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Jamie, I've changed quite a bit of the delta calculation code in
> armpmu_event_update so that we can detect the problem above.
> 
> Please let me know if I've missed/broken anything!
> 
> Will
> 
>  arch/arm/kernel/perf_event.c        |   19 +++++++++++--------
>  arch/arm/kernel/perf_event_v6.c     |    2 +-
>  arch/arm/kernel/perf_event_v7.c     |    2 +-
>  arch/arm/kernel/perf_event_xscale.c |    4 ++--
>  4 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index d150ad1..53f6068 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -204,11 +204,9 @@ armpmu_event_set_period(struct perf_event *event,
>  static u64
>  armpmu_event_update(struct perf_event *event,
>  		    struct hw_perf_event *hwc,
> -		    int idx)
> +		    int idx, int overflow)
>  {
> -	int shift = 64 - 32;
> -	s64 prev_raw_count, new_raw_count;
> -	u64 delta;
> +	u64 delta, prev_raw_count, new_raw_count;
>  
>  again:
>  	prev_raw_count = local64_read(&hwc->prev_count);
> @@ -218,8 +216,13 @@ again:
>  			     new_raw_count) != prev_raw_count)
>  		goto again;
>  
> -	delta = (new_raw_count << shift) - (prev_raw_count << shift);
> -	delta >>= shift;
> +	new_raw_count &= armpmu->max_period;
> +	prev_raw_count &= armpmu->max_period;
> +
> +	delta = (new_raw_count - prev_raw_count);
> +
> +	if (overflow && new_raw_count > prev_raw_count)
> +		delta += local64_read(&hwc->period_left) + prev_raw_count;
>  
>  	local64_add(delta, &event->count);
>  	local64_sub(delta, &hwc->period_left);

Hmm, I'm not really sure I follow that and see how it works for an 
overflow when new < prev.  Why doesn't the naive:

	new_raw_count &= armpmu->max_period;
	prev_raw_count &= armpmu->max_period;
	if (overflow)
		delta = (armpmu->max_period - prev_raw_count) + 
			new_raw_count
	else
		delta = new_raw_count - prev_raw_count;

work?  I'm sure I'm missing something here!

Jamie
