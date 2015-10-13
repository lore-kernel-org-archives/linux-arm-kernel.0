From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 13 Oct 2015 11:45:38 -0400
Subject: [PATCH v3 5/7] ftrace: allow arch-specific stack tracer
In-Reply-To: <1444298504-10392-6-git-send-email-takahiro.akashi@linaro.org>
References: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
 <1444298504-10392-6-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20151013114538.5d37ffc9@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  8 Oct 2015 19:01:42 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

>  include/linux/ftrace.h     |   10 ++++++++++
>  kernel/trace/trace_stack.c |   22 ++++++++++++++--------
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index d77b195..e538400 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -270,7 +270,17 @@ static inline void ftrace_kill(void) { }
>  #define FTRACE_STACK_FRAME_OFFSET 0
>  #endif
>  
> +#define STACK_TRACE_ENTRIES 500
> +
> +struct stack_trace;
> +
> +extern unsigned stack_dump_index[];
> +extern struct stack_trace max_stack_trace;
> +extern unsigned long max_stack_size;
> +extern arch_spinlock_t max_stack_lock;
> +
>  extern int stack_tracer_enabled;
> +void print_max_stack(void);

OK, if we are making these external, they need to have better name
space naming.

stack_dump_index	=>	stack_trace_index
max_stack_trace		=>	stack_trace_max
max_stack_size		=>	stack_trace_max_size
print_max_stack()	=>	stack_trace_print()


-- Steve

>  int
>  stack_trace_sysctl(struct ctl_table *table, int write,
>  		   void __user *buffer, size_t *lenp,
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 30521ea..ff1a191 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -16,24 +16,22 @@
>  
>  #include "trace.h"
>  
