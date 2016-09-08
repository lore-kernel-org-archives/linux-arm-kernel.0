From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Sep 2016 14:02:45 +0100
Subject: [PATCH] arm64: use preempt_disable_notrace in _percpu_read/write
In-Reply-To: <1473338802-18712-1-git-send-email-zhang.chunyan@linaro.org>
References: <1473338802-18712-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <20160908130245.GD26570@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In future, please ensure that you include the arm64 maintainers when
sending changes to core arm64 code. I've copied Catalin and Will for you
this time.

Thanks,
Mark.

On Thu, Sep 08, 2016 at 08:46:42PM +0800, Chunyan Zhang wrote:
> When debug preempt or preempt tracer is enabled, preempt_count_add/sub()
> can be traced by function and function graph tracing, and
> preempt_disable/enable() would call preempt_count_add/sub(), so in Ftrace
> subsystem we should use preempt_disable/enable_notrace instead.
> 
> In the commit 345ddcc882d8 ("ftrace: Have set_ftrace_pid use the bitmap
> like events do") the function this_cpu_read() was added to
> trace_graph_entry(), and if this_cpu_read() calls preempt_disable(), graph
> tracer will go into a recursive loop, even if the tracing_on is
> disabled.
> 
> So this patch change to use preempt_enable/disable_notrace instead in
> this_cpu_read().
> 
> Since Yonghui Yang helped a lot to find the root cause of this problem,
> so also add his SOB.
> 
> Signed-off-by: Yonghui Yang <mark.yang@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  arch/arm64/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> index 0a456be..2fee2f5 100644
> --- a/arch/arm64/include/asm/percpu.h
> +++ b/arch/arm64/include/asm/percpu.h
> @@ -199,19 +199,19 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
>  #define _percpu_read(pcp)						\
>  ({									\
>  	typeof(pcp) __retval;						\
> -	preempt_disable();						\
> +	preempt_disable_notrace();					\
>  	__retval = (typeof(pcp))__percpu_read(raw_cpu_ptr(&(pcp)), 	\
>  					      sizeof(pcp));		\
> -	preempt_enable();						\
> +	preempt_enable_notrace();					\
>  	__retval;							\
>  })
>  
>  #define _percpu_write(pcp, val)						\
>  do {									\
> -	preempt_disable();						\
> +	preempt_disable_notrace();					\
>  	__percpu_write(raw_cpu_ptr(&(pcp)), (unsigned long)(val), 	\
>  				sizeof(pcp));				\
> -	preempt_enable();						\
> +	preempt_enable_notrace();					\
>  } while(0)								\
>  
>  #define _pcp_protect(operation, pcp, val)			\
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
