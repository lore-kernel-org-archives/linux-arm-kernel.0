From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Jul 2010 14:38:58 +0100
Subject: [PATCH] ARM: perf: ensure counter delta is limited to 32-bits
In-Reply-To: <20100702180503.GF2357@wear.picochip.com>
References: <1278074642-3045-1-git-send-email-will.deacon@arm.com>
	<20100702180503.GF2357@wear.picochip.com>
Message-ID: <004401cb19eb$ecab2840$c60178c0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, the results are in!

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

 Performance counter stats for 'git status':

         3650781413  cycles                  
          289950734  instructions             #      0.079 IPC  
             144882  context-switches        
              13677  page-faults             
          473580406  branches                

       82.426290000  seconds time elapsed


Which looks insane to me. The IPC is appalling and we've taken
more branches than we've executed instructions!

Will
