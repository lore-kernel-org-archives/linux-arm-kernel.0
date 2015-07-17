From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 17 Jul 2015 23:28:13 +0900
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150717090009.720f6bd0@gandalf.local.home>
References: <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home> <55A6FA82.9000901@linaro.org>
 <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <20150716102405.2cc8c406@gandalf.local.home>
 <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <20150716121658.7982fdf5@gandalf.local.home>
 <20150717124054.GE26091@leverpostej>
 <20150717090009.720f6bd0@gandalf.local.home>
Message-ID: <77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 17, 2015, at 10:00 PM, Steven Rostedt wrote:

Hi Steve,

> Here's my latest version of the patch. I also added a fix that made
> entries off from the real number of entries. That was to stop the loop
> on ULONG_MAX in stack_dump_trace[i], otherwise if for some reason
> nr_entries is one off and points to ULONG_MAX, and there is a -1 in the
> stack, the trace will include it in the count. The output of the stack
> tests against both nr_entries and ULONG_MAX and will stop with either
> case, making the dump and the count different.
> 
> -- Steve
> 
> From 1c3697c3c4ce1f237466f76e40c91f66e2030bac Mon Sep 17 00:00:00 2001
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
> Some-suggestions-by: Jungseok Lee <jungseoklee85@gmail.com>
> Some-suggestions-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> kernel/trace/trace_stack.c | 68 ++++++++++++++++------------------------------
> 1 file changed, 23 insertions(+), 45 deletions(-)
> 
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 3f34496244e9..b746399ab59c 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -18,12 +18,6 @@
> 
> #define STACK_TRACE_ENTRIES 500
> 
> -#ifdef CC_USING_FENTRY
> -# define fentry		1
> -#else
> -# define fentry		0
> -#endif
> -
> static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
> 	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };
> static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
> @@ -35,7 +29,7 @@ static unsigned stack_dump_index[STACK_TRACE_ENTRIES];
>  */
> static struct stack_trace max_stack_trace = {
> 	.max_entries		= STACK_TRACE_ENTRIES - 1,
> -	.entries		= &stack_dump_trace[1],
> +	.entries		= &stack_dump_trace[0],
> };
> 
> static unsigned long max_stack_size;
> @@ -55,7 +49,7 @@ static inline void print_max_stack(void)
> 
> 	pr_emerg("        Depth    Size   Location    (%d entries)\n"
> 			   "        -----    ----   --------\n",
> -			   max_stack_trace.nr_entries - 1);
> +			   max_stack_trace.nr_entries);
> 
> 	for (i = 0; i < max_stack_trace.nr_entries; i++) {
> 		if (stack_dump_trace[i] == ULONG_MAX)
> @@ -77,7 +71,7 @@ check_stack(unsigned long ip, unsigned long *stack)
> 	unsigned long this_size, flags; unsigned long *p, *top, *start;
> 	static int tracer_frame;
> 	int frame_size = ACCESS_ONCE(tracer_frame);
> -	int i;
> +	int i, x;
> 
> 	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
> 	this_size = THREAD_SIZE - this_size;
> @@ -105,26 +99,20 @@ check_stack(unsigned long ip, unsigned long *stack)
> 	max_stack_size = this_size;
> 
> 	max_stack_trace.nr_entries = 0;
> -
> -	if (using_ftrace_ops_list_func())
> -		max_stack_trace.skip = 4;
> -	else
> -		max_stack_trace.skip = 3;
> +	max_stack_trace.skip = 3;
> 
> 	save_stack_trace(&max_stack_trace);
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
> 
> 	/*
> 	 * Now find where in the stack these are.
> 	 */
> -	i = 0;
> +	x = 0;
> 	start = stack;
> 	top = (unsigned long *)
> 		(((unsigned long)start & ~(THREAD_SIZE-1)) + THREAD_SIZE);
> @@ -139,12 +127,15 @@ check_stack(unsigned long ip, unsigned long *stack)
> 	while (i < max_stack_trace.nr_entries) {
> 		int found = 0;
> 
> -		stack_dump_index[i] = this_size;
> +		stack_dump_index[x] = this_size;
> 		p = start;
> 
> 		for (; p < top && i < max_stack_trace.nr_entries; p++) {
> +			if (stack_dump_trace[i] == ULONG_MAX)
> +				break;
> 			if (*p == stack_dump_trace[i]) {
> -				this_size = stack_dump_index[i++] =
> +				stack_dump_trace[x] = stack_dump_trace[i++];
> +				this_size = stack_dump_index[x++] =
> 					(top - p) * sizeof(unsigned long);
> 				found = 1;
> 				/* Start the search from here */
> @@ -156,7 +147,7 @@ check_stack(unsigned long ip, unsigned long *stack)
> 				 * out what that is, then figure it out
> 				 * now.
> 				 */
> -				if (unlikely(!tracer_frame) && i == 1) {
> +				if (unlikely(!tracer_frame)) {
> 					tracer_frame = (p - stack) *
> 						sizeof(unsigned long);
> 					max_stack_size -= tracer_frame;
> @@ -168,6 +159,10 @@ check_stack(unsigned long ip, unsigned long *stack)
> 			i++;
> 	}
> 
> +	max_stack_trace.nr_entries = x;
> +	for (; x < i; x++)
> +		stack_dump_trace[x] = ULONG_MAX;
> +
> 	if (task_stack_end_corrupted(current)) {
> 		print_max_stack();
> 		BUG();
> @@ -192,24 +187,7 @@ stack_trace_call(unsigned long ip, unsigned long parent_ip,
> 	if (per_cpu(trace_active, cpu)++ != 0)
> 		goto out;
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
> 	check_stack(ip, &stack);
> 
> @@ -284,7 +262,7 @@ __next(struct seq_file *m, loff_t *pos)
> {
> 	long n = *pos - 1;
> 
> -	if (n >= max_stack_trace.nr_entries || stack_dump_trace[n] == ULONG_MAX)
> +	if (n > max_stack_trace.nr_entries || stack_dump_trace[n] == ULONG_MAX)
> 		return NULL;
> 
> 	m->private = (void *)n;
> @@ -354,7 +332,7 @@ static int t_show(struct seq_file *m, void *v)
> 		seq_printf(m, "        Depth    Size   Location"
> 			   "    (%d entries)\n"
> 			   "        -----    ----   --------\n",
> -			   max_stack_trace.nr_entries - 1);
> +			   max_stack_trace.nr_entries);
> 
> 		if (!stack_tracer_enabled && !max_stack_size)
> 			print_disabled(m);
> -- 


I have reviewed and tested the kernel including this patch and only [RFC 1/3].

Now, the number of entries and max_stack_size are always okay, but unexpected functions,
such as ftrace_ops_no_ops and ftrace_call, are *sometimes* listed as follows.

$ cat /sys/kernel/debug/tracing/stack_trace 

        Depth    Size   Location    (49 entries)
        -----    ----   --------
  0)     4456      16   arch_counter_read+0xc/0x24
  1)     4440      16   ktime_get+0x44/0xb4
  2)     4424      48   get_drm_timestamp+0x30/0x40
  3)     4376      16   drm_get_last_vbltimestamp+0x94/0xb4
  4)     4360      80   drm_handle_vblank+0x84/0x3c0
  5)     4280     144   mdp5_irq+0x118/0x130
  6)     4136      80   msm_irq+0x2c/0x68
  7)     4056      32   handle_irq_event_percpu+0x60/0x210
  8)     4024      96   handle_irq_event+0x50/0x80
  9)     3928      64   handle_fasteoi_irq+0xb0/0x178
 10)     3864      48   generic_handle_irq+0x38/0x54
 11)     3816      32   __handle_domain_irq+0x68/0xbc
 12)     3784      64   gic_handle_irq+0x38/0x88
 13)     3720     280   el1_irq+0x64/0xd8
 14)     3440     168   ftrace_ops_no_ops+0xb4/0x16c
 15)     3272      64   ftrace_call+0x0/0x4
 16)     3208      16   _raw_spin_lock_irqsave+0x14/0x70
 17)     3192      32   msm_gpio_set+0x44/0xb4
 18)     3160      48   _gpiod_set_raw_value+0x68/0x148
 19)     3112      64   gpiod_set_value+0x40/0x70
 20)     3048      32   gpio_led_set+0x3c/0x94
 21)     3016      48   led_set_brightness+0x50/0xa4
 22)     2968      32   led_trigger_event+0x4c/0x78
 23)     2936      48   mmc_request_done+0x38/0x84
 24)     2888      32   sdhci_tasklet_finish+0xcc/0x12c
 25)     2856      48   tasklet_action+0x64/0x120
 26)     2808      48   __do_softirq+0x114/0x2f0
 27)     2760     128   irq_exit+0x98/0xd8
 28)     2632      32   __handle_domain_irq+0x6c/0xbc
 29)     2600      64   gic_handle_irq+0x38/0x88
 30)     2536     280   el1_irq+0x64/0xd8
 31)     2256     168   ftrace_ops_no_ops+0xb4/0x16c
 32)     2088      64   ftrace_call+0x0/0x4
 33)     2024      16   __schedule+0x1c/0x748
 34)     2008      80   schedule+0x38/0x94
 35)     1928      32   schedule_timeout+0x1a8/0x200
 36)     1896     128   wait_for_common+0xa8/0x150
 37)     1768     128   wait_for_completion+0x24/0x34
 38)     1640      32   mmc_wait_for_req_done+0x3c/0x104
 39)     1608      64   mmc_wait_for_cmd+0x68/0x94
 40)     1544     128   get_card_status.isra.25+0x6c/0x88
 41)     1416     112   card_busy_detect.isra.31+0x7c/0x154
 42)     1304     128   mmc_blk_err_check+0xd0/0x4f8
 43)     1176     192   mmc_start_req+0xe4/0x3a8
 44)      984     160   mmc_blk_issue_rw_rq+0xc4/0x9c0
 45)      824     176   mmc_blk_issue_rq+0x19c/0x450
 46)      648     112   mmc_queue_thread+0x134/0x17c
 47)      536      80   kthread+0xe0/0xf8
 48)      456     456   ret_from_fork+0xc/0x50

$ cat /sys/kernel/debug/tracing/stack_max_size
4456

This issue might be related to arch code, not this change.
IMHO, this patch look settled now.

Best Regards
Jungseok Lee
