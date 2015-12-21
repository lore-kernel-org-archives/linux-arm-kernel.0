From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Dec 2015 12:04:38 +0000
Subject: [PATCH v7 5/6] arm64: ftrace: add arch-specific stack tracer
In-Reply-To: <1450168424-10010-6-git-send-email-takahiro.akashi@linaro.org>
References: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
 <1450168424-10010-6-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20151221120438.GI23092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On Tue, Dec 15, 2015 at 05:33:43PM +0900, AKASHI Takahiro wrote:
> Background and issues on generic check_stack():
> 1) slurping stack
> 
>     Assume that a given function A was invoked, and it was invoked again in
>     another context, then it called another function B which allocated
>     a large size of local variables on the stack, but it has not modified
>     the variable(s) yet.
>     When stack tracer, check_stack(), examines the stack looking for B,
>     then A, we may have a chance to accidentally find a stale, not current,
>     stack frame for A because the old frame might reside on the memory for
>     the variable which has not been overwritten.
> 
>     (issue) The stack_trace output may have stale entries.
> 
> 2) differences between x86 and arm64
> 
>     On x86, "call" instruction automatically pushes a return address on
>     the top of the stack and decrements a stack pointer. Then child
>     function allocates its local variables on the stack.
> 
>     On arm64, a child function is responsible for allocating memory for
>     local variables as well as a stack frame, and explicitly pushes
>     a return address (LR) and old frame pointer in its function prologue
>     *after* decreasing a stack pointer.
> 
>     Generic check_stack() recogizes 'idxB,' which is the next address of
>     the location where 'fpB' is found, in the picture below as an estimated
>     stack pointer. This seems to fine with x86, but on arm64, 'idxB' is
>     not appropriate just because it contains child function's "local
>     variables."
>     We should instead use spB, if possible, for better interpretation of
>     func_B's stack usage.
> 
> LOW      |  ...   |
> fpA      +--------+   func_A (pcA, fpA, spA)
>          |  fpB   |
>     idxB + - - - -+
>          |  pcB   |
>          |  ... <----------- static local variables in func_A
>          |  ...   |             and extra function args to func_A
> spB      + - - - -+
>          |  ... <----------- dynamically allocated variables in func_B
> fpB      +--------+   func_B (pcB, fpB, spB)
>          |  fpC   |
>     idxC + - - - -+
>          |  pcC   |
>          |  ... <----------- static local variables in func_B
>          |  ...   |             and extra function args to func_B
> spC      + - - - -+
>          |  ...   |
> fpC      +--------+   func_C (pcC, fpC, spC)
> HIGH     |        |
> 
>     (issue) Stack size for a function in stack_trace output is inaccurate,
>             or rather wrong.  It looks as if <Size> field is one-line
> 	    offset against <Location>.
> 
>                 Depth    Size   Location    (49 entries)
>                 -----    ----   --------
>          40)     1416      64   path_openat+0x128/0xe00       -> 176
>          41)     1352     176   do_filp_open+0x74/0xf0        -> 256
>          42)     1176     256   do_open_execat+0x74/0x1c8     -> 80
>          43)      920      80   open_exec+0x3c/0x70           -> 32
>          44)      840      32   load_elf_binary+0x294/0x10c8
> 
> Implementation on arm64:
> So we want to have our own stack tracer, check_stack().
> Our approach is uniqeue in the following points:
> * analyze a function prologue of a traced function to estimate a more
>   accurate stack pointer value, replacing naive '<child's fp> + 0x10.'
> * use walk_stackframe(), instead of slurping stack contents as orignal
>   check_stack() does, to identify a stack frame and a stack index (height)
>   for every callsite.
> 
> Regarding a function prologue analyzer, there is no guarantee that we can
> handle all the possible patterns of function prologue as gcc does not use
> any fixed templates to generate them. 'Instruction scheduling' is another
> issue here.

Have you run this past any of the GCC folks? It would be good to at least
make them aware of the heuristics you're using and the types of prologue
that we can handle. They even have suggestions to improve on your approach
(e.g. using -fstack-usage).

> +static void __save_stack_trace_tsk(struct task_struct *tsk,
> +		struct stack_trace *trace, unsigned long *stack_dump_sp)
>  {
>  	struct stack_trace_data data;
>  	struct stackframe frame;
>  
>  	data.trace = trace;
>  	data.skip = trace->skip;
> +#ifdef CONFIG_STACK_TRACER
> +	data.sp = stack_dump_sp;
> +#endif
>  
>  	if (tsk != current) {
>  		data.no_sched_functions = 1;
> @@ -149,7 +319,8 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>  		data.no_sched_functions = 0;
>  		frame.fp = (unsigned long)__builtin_frame_address(0);
>  		frame.sp = current_stack_pointer;
> -		frame.pc = (unsigned long)save_stack_trace_tsk;
> +		asm("1:");
> +		asm("ldr %0, =1b" : "=r" (frame.pc));

This looks extremely fragile. Does the original code not work?

Will
