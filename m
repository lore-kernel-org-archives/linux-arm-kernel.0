From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Dec 2015 17:14:01 +0000
Subject: next-20151210 build: 4 failures 43 warnings (next-20151210)
In-Reply-To: <20151210165513.GO5727@sirena.org.uk>
References: <E1a6wEp-0000hU-7o@optimist> <20151210165513.GO5727@sirena.org.uk>
Message-ID: <20151210171401.GG21134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 04:55:13PM +0000, Mark Brown wrote:
> On Thu, Dec 10, 2015 at 08:06:07AM +0000, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build most arm64 configs with some rather
> spectacular errors below introduced by 02598e94ed5a78 (mm, printk:
> introduce new format string for flags) from Andrew's tree.  These in
> turn stem from the fact that we introduce an inclusion of
> linux/tracepoint.h into linux/mmdebug.h which through a chain of nested
> inclusions means that we end up attempting to use definitions from
> headers before they have finished including.  For example:
> 
> > 	arm64-allnoconfig
> > ../include/linux/wait.h:1217:2: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]
> 
> is a result of:
> 
> In file included from include/linux/completion.h:11:0,
>                  from include/linux/rcupdate.h:43,
>                  from include/linux/tracepoint.h:19,
>                  from include/linux/mmdebug.h:6,
>                  from ./arch/arm64/include/asm/cmpxchg.h:22,
>                  from ./arch/arm64/include/asm/atomic.h:41,
>                  from include/linux/atomic.h:4,
>                  from include/linux/spinlock.h:406,
>                  from include/linux/seqlock.h:35,
>                  from include/linux/time.h:5,
>                  from include/uapi/linux/timex.h:56,
>                  from include/linux/timex.h:56,
>                  from include/linux/sched.h:19,
>                  from arch/arm64/kernel/asm-offsets.c:21:
> include/linux/wait.h: In function 'wait_on_atomic_t':
> include/linux/wait.h:1218:2: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]
>   if (atomic_read(val) == 0)
> 
> where atomic_read() will be defined in atomic.h which is part of the
> inclusion chain above but hasn't yet parsed far enough to actually
> define anything.  This is all a bit of a horrific mess the root cause of
> which appears to be that arm64 is unusual in including linux/mmdebug.h
> in asm/cmpxchg.h which triggers the mess.  There doesn't seem to be any
> reason for this inclusion, I've just sent a patch removing it.  It'd be
> good to get this into -next as a matter of urgency.

I'll pick up your fix into the arm64 for-next/core branch.

Cheers,

Will
