From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 1 Nov 2017 12:43:10 -0400
Subject: [PATCH 1/2] arm64: Fix static use of function graph
In-Reply-To: <1509546824-46165-2-git-send-email-julien.thierry@arm.com>
References: <1509546824-46165-1-git-send-email-julien.thierry@arm.com>
 <1509546824-46165-2-git-send-email-julien.thierry@arm.com>
Message-ID: <20171101124310.3ab66a69@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  1 Nov 2017 14:33:43 +0000
Julien Thierry <julien.thierry@arm.com> wrote:

> Function graph does not work currently when CONFIG_DYNAMIC_TRACE is not
> set. This is because ftrace_function_trace is not always set to ftrace_stub
> when function_graph is in use.
> 
> Do not skip checking of graph tracer functions when ftrace_function_trace
> is set.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>

My arm code is very rusty and I have no idea if this works or not, but
for what it's worth.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/kernel/entry-ftrace.S | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index e1be42e..1175f58 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -108,13 +108,8 @@ ENTRY(_mcount)
>  	mcount_get_lr	x1		//       function's lr (= parent's pc)
>  	blr	x2			//   (*ftrace_trace_function)(pc, lr);
> 
> -#ifndef CONFIG_FUNCTION_GRAPH_TRACER
> -skip_ftrace_call:			//   return;
> -	mcount_exit			// }
> -#else
> -	mcount_exit			//   return;
> -					// }
> -skip_ftrace_call:
> +skip_ftrace_call:			// }
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	ldr_l	x2, ftrace_graph_return
>  	cmp	x0, x2			//   if ((ftrace_graph_return
>  	b.ne	ftrace_graph_caller	//        != ftrace_stub)
> @@ -123,9 +118,8 @@ skip_ftrace_call:
>  	adr_l	x0, ftrace_graph_entry_stub //     != ftrace_graph_entry_stub))
>  	cmp	x0, x2
>  	b.ne	ftrace_graph_caller	//     ftrace_graph_caller();
> -
> -	mcount_exit
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> +	mcount_exit
>  ENDPROC(_mcount)
> 
>  #else /* CONFIG_DYNAMIC_FTRACE */
> --
> 1.9.1
