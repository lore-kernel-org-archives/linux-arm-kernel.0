From: jamie.iles@picochip.com (Jamie Iles)
Date: Fri, 2 Jul 2010 16:04:56 -0400
Subject: [PATCH] ARM: perf: ensure counter delta is limited to 32-bits
In-Reply-To: <004501cb19f1$4a9a25a0$dfce70e0$@deacon@arm.com>
References: <1278074642-3045-1-git-send-email-will.deacon@arm.com>
	<20100702180503.GF2357@wear.picochip.com>
	<004401cb19eb$ecab2840$c60178c0$@deacon@arm.com>
	<20100702184848.GH2357@wear.picochip.com>
	<004501cb19f1$4a9a25a0$dfce70e0$@deacon@arm.com>
Message-ID: <20100702200456.GI2357@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 03:17:23PM +0100, Will Deacon wrote:
> I don't think the signedness of atomic64_t actually matters because everything
> is handled in assembly anyway.
Good point. I guess we could probably cast the new value to an s32 before
doing the cmpxchng to get the sign extension, but a lot of this stuff isn't
obvious anyway and your fix is certainly cleaner.

[...]
> 
> Actually, a much neater fix to this problem is to make delta unsigned and
> leave everything else as-is (although I'm not a massive fan of all the
> 64-bit shifting).
> 
> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> index c457686..de12536 100644
> --- a/arch/arm/kernel/perf_event.c
> +++ b/arch/arm/kernel/perf_event.c
> @@ -201,7 +201,7 @@ armpmu_event_update(struct perf_event *event,
>  {
>         int shift = 64 - 32;
>         s64 prev_raw_count, new_raw_count;
> -       s64 delta;
> +       u64 delta;
>  
>  again:
>         prev_raw_count = atomic64_read(&hwc->prev_count);
> 
> 
> What do you think?
Yes, that looks good to me.

Acked-by: Jamie Iles <jamie.iles@picochip.com>

Jamie
