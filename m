From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 15 May 2014 10:17:10 +0100
Subject: [RFC][PATCH 6/8] sched,idle: Avoid spurious wakeup IPIs
In-Reply-To: <536CEB7E.9080007@imgtec.com>
References: <20140411134243.160989490@infradead.org>
 <20140411135218.478299389@infradead.org>
 <CAAG0J9_q1KsUx10-XAb7AJnxv2ehctg6q1KME7ahsk1OZV8vZQ@mail.gmail.com>
 <20140509141520.GV2844@laptop.programming.kicks-ass.net>
 <536CEB7E.9080007@imgtec.com>
Message-ID: <53748616.3020109@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 09/05/14 15:51, James Hogan wrote:
> On 09/05/14 15:15, Peter Zijlstra wrote:
>> Most archs have (x86) hlt or (arm) wfi like idle instructions, and if
>> that is your only possible idle function, you'll require the interrupt
>> to wake up and there's really no point to having the POLLING bit.
>>
>> Lastly, having the POLLING bit and not needing it is similarly non-fatal.
>>
> 
> Thanks. I think the flag can go for Metag then. I suggest the following
> patch.

This is still bust in linux-next. What's the status of this patch?

Thanks
James

> 
> From 15dd3f9cc18bdb1c8c4d2c395778421022250aa8 Mon Sep 17 00:00:00 2001
> From: James Hogan <james.hogan@imgtec.com>
> Date: Fri, 9 May 2014 15:36:21 +0100
> Subject: [PATCH] metag: Remove TIF_POLLING_NRFLAG
> 
> The Meta idle function jumps into the interrupt handler which
> efficiently blocks waiting for the next interrupt when it reads the
> interrupt status register (TXSTATI). No other (polling) idle functions
> can be used, therefore TIF_POLLING_NRFLAG is unnecessary, so lets remove
> it.
> 
> Peter Zijlstra said:
>> Most archs have (x86) hlt or (arm) wfi like idle instructions, and if
>> that is your only possible idle function, you'll require the interrupt
>> to wake up and there's really no point to having the POLLING bit.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/metag/include/asm/thread_info.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/metag/include/asm/thread_info.h b/arch/metag/include/asm/thread_info.h
> index b19e9c588a16..47711336119e 100644
> --- a/arch/metag/include/asm/thread_info.h
> +++ b/arch/metag/include/asm/thread_info.h
> @@ -117,10 +117,8 @@ static inline int kstack_end(void *addr)
>  #define TIF_SECCOMP		5	/* secure computing */
>  #define TIF_RESTORE_SIGMASK	6	/* restore signal mask in do_signal() */
>  #define TIF_NOTIFY_RESUME	7	/* callback before returning to user */
> -#define TIF_POLLING_NRFLAG      8	/* true if poll_idle() is polling
> -					   TIF_NEED_RESCHED */
> -#define TIF_MEMDIE		9	/* is terminating due to OOM killer */
> -#define TIF_SYSCALL_TRACEPOINT  10	/* syscall tracepoint instrumentation */
> +#define TIF_MEMDIE		8	/* is terminating due to OOM killer */
> +#define TIF_SYSCALL_TRACEPOINT	9	/* syscall tracepoint instrumentation */
>  
>  
>  #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
> 
