From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Jul 2010 14:22:09 +0100
Subject: [PATCH] ARM: perf: ensure counter delta is limited to 32-bits
In-Reply-To: <20100702180503.GF2357@wear.picochip.com>
References: <1278074642-3045-1-git-send-email-will.deacon@arm.com>
	<20100702180503.GF2357@wear.picochip.com>
Message-ID: <004301cb19e9$9314a830$b93df890$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

> Well spotted! I think this may have actually been a typo when porting to ARM
> from the sparc and x86 code, and this should address it so we do the same:
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index 9e70f20..6c0f3ca 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -164,7 +164,7 @@ armpmu_event_update(struct perf_event *event,
>  		    int idx)
>  {
>  	int shift = 64 - 32;
> -	s64 prev_raw_count, new_raw_count;
> +	u64 prev_raw_count, new_raw_count;
>  	s64 delta;
> 
>  again:

I wondered about this approach, but I couldn't convince myself it was
correct. When armpmu_event_set_period updates hwc->prev_count, it sets
the top 32-bits to 1. When we do the cmpxchg in armpmu_event_update, we
will only be writing the bottom 32-bits. This means that prev_count
alternates between s64 and u64 and I'm not sure what the rest of the perf
framework will do in that case.

Tell you what, I'll make the change and see what happens to the numbers...

Will
