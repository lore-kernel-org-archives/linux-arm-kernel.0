From: jamie.iles@picochip.com (Jamie Iles)
Date: Fri, 2 Jul 2010 14:48:48 -0400
Subject: [PATCH] ARM: perf: ensure counter delta is limited to 32-bits
In-Reply-To: <004401cb19eb$ecab2840$c60178c0$@deacon@arm.com>
References: <1278074642-3045-1-git-send-email-will.deacon@arm.com>
	<20100702180503.GF2357@wear.picochip.com>
	<004401cb19eb$ecab2840$c60178c0$@deacon@arm.com>
Message-ID: <20100702184848.GH2357@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 02:38:58PM +0100, Will Deacon wrote:
> Ok, the results are in!
> 
> > Well spotted! I think this may have actually been a typo when porting to ARM
> > from the sparc and x86 code, and this should address it so we do the same:
> > 
> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > index 9e70f20..6c0f3ca 100644
> > --- a/arch/arm/kernel/perf_event.c
> > +++ b/arch/arm/kernel/perf_event.c
> > @@ -164,7 +164,7 @@ armpmu_event_update(struct perf_event *event,
> >  		    int idx)
> >  {
> >  	int shift = 64 - 32;
> > -	s64 prev_raw_count, new_raw_count;
> > +	u64 prev_raw_count, new_raw_count;
> >  	s64 delta;
> > 
> >  again:
> 
>  Performance counter stats for 'git status':
> 
>          3650781413  cycles                  
>           289950734  instructions             #      0.079 IPC  
>              144882  context-switches        
>               13677  page-faults             
>           473580406  branches                
> 
>        82.426290000  seconds time elapsed
> 
> 
> Which looks insane to me. The IPC is appalling and we've taken
> more branches than we've executed instructions!
No, that certainly doesn't look right. Referring back your earlier email, when
we do the cmpxchng, shouldn't it get sign extended then? An atomic64_t should
be signed, but looking at the arm implementation, we're using u64's. Could
this have anything to do with it? The generic implementation in lib/atomic64.c
uses 'long long's.

Providing that the sign extension does work, I've had a quick play with some
uint64_t's and int64_t's in userspace and I think the algorithm is ok. Is the
assumption of atomic64_t's being signed wrong?

Jamie
