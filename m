From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 17 Jul 2015 11:49:52 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150716162255.0beedc76@gandalf.local.home>
References: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>	<1436765375-7119-3-git-send-email-takahiro.akashi@linaro.org>	<DAAB1BC4-B36E-436D-8EAD-548641E58490@gmail.com>	<20150714093154.4d73e551@gandalf.local.home>	<55A5A75A.1060401@linaro.org>	<20150714225105.6c1e4f15@gandalf.local.home>	<55A646EE.6030402@linaro.org>	<20150715105536.42949ea9@gandalf.local.home>	<20150715121337.3b31aa84@gandalf.local.home>	<55A6FA82.9000901@linaro.org>	<55A703F3.8050203@linaro.org>	<A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>	<20150716102405.2cc8c406@gandalf.local.home>	<12F47692-3010-4886-B87D-3D7820609177@gmail.com>	<20150716113115.45a17f17@gandalf.local.home>	<5176E676-1AAA-4F2B-827B-BEF3A2620D86@gmail.com>
 <20150716162255.0beedc76@gandalf.local.home>
Message-ID: <55A86D50.9060407@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Steve,

On 07/17/2015 05:22 AM, Steven Rostedt wrote:
>
> Here's the patch I now have in my local repo, and plan on pushing to my
> repo on korg.
>
> -- Steve
>
>  From d21f02a45fa367beaf97b153aa29849c06ac5609 Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> Date: Thu, 16 Jul 2015 13:24:54 -0400
> Subject: [PATCH] tracing: Clean up stack tracing and fix fentry updates
>
> Akashi Takahiro was porting the stack tracer to arm64 and found some
> issues with it. One was that it repeats the top function, due to the
> stack frame added by the mcount caller and added by itself. This
> was added when fentry came in, and before fentry created its own stack
> frame. But x86's fentry now creates its own stack frame, and there's
> no need to insert the function again.
>
> This also cleans up the code a bit, where it doesn't need to do something
> special for fentry, and doesn't include insertion of a duplicate
> entry for the called function being traced.
>
> Link: http://lkml.kernel.org/r/55A646EE.6030402 at linaro.org
>
> Some-Suggestions-by: Jungseok Lee <jungseoklee85@gmail.com>
> Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>   kernel/trace/trace_stack.c | 62 ++++++++++++++--------------------------------
>   1 file changed, 19 insertions(+), 43 deletions(-)
>
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 3f34496244e9..e615cdc9e38a 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -18,12 +18,6 @@
>
>   #define STACK_TRACE_ENTRIES 500
>
> -#ifdef CC_USING_FENTRY
> -# define fentry		1
> -#else
> -# define fentry		0
> -#endif
> -
>   static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
>   	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
>   static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
> @@ -35,7 +29,7 @@ static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
>    */
>   static struct stack_trace max_stack_trace = {
>   	.max_entries		= STACK_TRACE_ENTRIES - 1,
> -	.entries		= &stack_dump_trace[1],
> +	.entries		= &stack_dump_trace[0],
>   };
>
>   static unsigned long max_stack_size;
> @@ -77,7 +71,7 @@ check_stack(unsigned long ip, unsigned long *stack)
>   	unsigned long this_size, flags; unsigned long *p, *top, *start;
>   	static int tracer_frame;
>   	int frame_size = ACCESS_ONCE(tracer_frame);
> -	int i;
> +	int i, x;
>
>   	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
>   	this_size = THREAD_SIZE - this_size;
> @@ -105,26 +99,20 @@ check_stack(unsigned long ip, unsigned long *stack)
>   	max_stack_size = this_size;
>
>   	max_stack_trace.nr_entries = 0;
> -
> -	if (using_ftrace_ops_list_func())
> -		max_stack_trace.skip = 4;
> -	else
> -		max_stack_trace.skip = 3;
> +	max_stack_trace.skip = 3;

I don't think this last line is necessary because we will skip all
the functions anyway below:

>   	save_stack_trace(&max_stack_trace);
>
> -	/*
> -	 * Add the passed in ip from the function tracer.
> -	 * Searching for this on the stack will skip over
> -	 * most of the overhead from the stack tracer itself.
> -	 */
> -	stack_dump_trace[0] = ip;
> -	max_stack_trace.nr_entries++;
> +	/* Skip over the overhead of the stack tracer itself */
> +	for (i = 0; i < max_stack_trace.nr_entries; i++) {
> +		if (stack_dump_trace[i] == ip)
> +			break;
> +	}

here. Now "i" indicates the start point, excepting tracer functions,
and "x" will eventually represent the exact number of functions
that we are interested in after searching the stack.

To calc "stack_max_size" correctly, we should change the line:
     if (unlikely(tracer_frame) && i == 1) {
to
     if (unlikely(tracer_frame)) {

With these two changes applied, the issues Jungseok mentioned will be
fixed.

Thanks,
-Takahiro AKASHI

>   	/*
>   	 * Now find where in the stack these are.
>   	 */
> -	i = 0;
> +	x = 0;
>   	start = stack;
>   	top = (unsigned long *)
>   		(((unsigned long)start & ~(THREAD_SIZE-1)) + THREAD_SIZE);
> @@ -139,12 +127,13 @@ check_stack(unsigned long ip, unsigned long *stack)
>   	while (i < max_stack_trace.nr_entries) {
>   		int found = 0;
>
> -		stack_dump_index[i] = this_size;
> +		stack_dump_index[x] = this_size;
>   		p = start;
>
>   		for (; p < top && i < max_stack_trace.nr_entries; p++) {
>   			if (*p == stack_dump_trace[i]) {
> -				this_size = stack_dump_index[i++] =
> +				stack_dump_trace[x] = stack_dump_trace[i++];
> +				this_size = stack_dump_index[x++] =
>   					(top - p) * sizeof(unsigned long);
>   				found = 1;
>   				/* Start the search from here */
> @@ -168,6 +157,10 @@ check_stack(unsigned long ip, unsigned long *stack)
>   			i++;
>   	}
>
> +	max_stack_trace.nr_entries = x;
> +	for (; x < i; x++)
> +		stack_dump_trace[x] = ULONG_MAX;
> +
>   	if (task_stack_end_corrupted(current)) {
>   		print_max_stack();
>   		BUG();
> @@ -192,24 +185,7 @@ stack_trace_call(unsigned long ip, unsigned long parent_ip,
>   	if (per_cpu(trace_active, cpu)++ != 0)
>   		goto out;
>
> -	/*
> -	 * When fentry is used, the traced function does not get
> -	 * its stack frame set up, and we lose the parent.
> -	 * The ip is pretty useless because the function tracer
> -	 * was called before that function set up its stack frame.
> -	 * In this case, we use the parent ip.
> -	 *
> -	 * By adding the return address of either the parent ip
> -	 * or the current ip we can disregard most of the stack usage
> -	 * caused by the stack tracer itself.
> -	 *
> -	 * The function tracer always reports the address of where the
> -	 * mcount call was, but the stack will hold the return address.
> -	 */
> -	if (fentry)
> -		ip = parent_ip;
> -	else
> -		ip += MCOUNT_INSN_SIZE;
> +	ip += MCOUNT_INSN_SIZE;
>
>   	check_stack(ip, &stack);
>
> @@ -284,7 +260,7 @@ __next(struct seq_file *m, loff_t *pos)
>   {
>   	long n = *pos - 1;
>
> -	if (n >= max_stack_trace.nr_entries || stack_dump_trace[n] == ULONG_MAX)
> +	if (n > max_stack_trace.nr_entries || stack_dump_trace[n] == ULONG_MAX)
>   		return NULL;
>
>   	m->private = (void *)n;
> @@ -354,7 +330,7 @@ static int t_show(struct seq_file *m, void *v)
>   		seq_printf(m, "        Depth    Size   Location"
>   			   "    (%d entries)\n"
>   			   "        -----    ----   --------\n",
> -			   max_stack_trace.nr_entries - 1);
> +			   max_stack_trace.nr_entries);
>
>   		if (!stack_tracer_enabled && !max_stack_size)
>   			print_disabled(m);
>
