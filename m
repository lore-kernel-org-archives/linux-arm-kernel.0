From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 Jul 2015 16:53:03 +0100
Subject: [PATCH v3] arm64: Modify the dump mem for 64 bit addresses
In-Reply-To: <1436243596-5263-1-git-send-email-maninder1.s@samsung.com>
References: <1436243596-5263-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20150707155303.GC13228@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 10:03:15AM +0530, Maninder Singh wrote:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 1ef2940..53d57db 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -51,8 +51,9 @@ int show_unhandled_signals = 1;
>  /*
>   * Dump out the contents of some memory nicely...
>   */
> +

Unnecessary empty line added here.

>  static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
> -		     unsigned long top)
> +		     unsigned long top, unsigned int width)

I would add a WARN_ON(width != 4 || width != 8).

Alternatively, just change this to a "bool wide" argument and a local
width variable (it helps with the is_compat_thread below).

>  {
>  	unsigned long first;
>  	mm_segment_t fs;
> @@ -70,18 +71,27 @@ static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
>  
>  	for (first = bottom & ~31; first < top; first += 32) {
>  		unsigned long p;
> -		char str[sizeof(" 12345678") * 8 + 1];
> +		char str[sizeof(" 1234567812345678") * 8 + 1];

Does this need to be just "* 4" for 8 byte width? In which case, the
original size covers it since you just have a few spaces less.

>  		memset(str, ' ', sizeof(str));
>  		str[sizeof(str) - 1] = '\0';
>  
> -		for (p = first, i = 0; i < 8 && p < top; i++, p += 4) {
> +		for (p = first, i = 0; i < (width > 4 ? width-4 : width+4)
> +					&& p < top; i++, p += width) {

It's probably clearer as:

		for (p = first, i = 0; i < 32 / width && p < top; i++, p += width)

(the upper limit for i is 32-bytes per line divided by how many bytes we
read@once: 4 or 8)

>  			if (p >= bottom && p < top) {
> -				unsigned int val;
> -				if (__get_user(val, (unsigned int *)p) == 0)
> -					sprintf(str + i * 9, " %08x", val);
> -				else
> -					sprintf(str + i * 9, " ????????");
> +				unsigned long val;
> +
> +				if (width == 8) {
> +					if (__get_user(val, (unsigned long *)p) == 0)
> +						sprintf(str + i * 17, " %016lx", val);
> +					else
> +						sprintf(str + i * 17, " ????????????????");
> +				} else {
> +					if (__get_user(val, (unsigned int *)p) == 0)
> +						sprintf(str + i * 9, " %08x", (unsigned int)val);

I don't think you need the (unsigned int) cast here, just " %08lx".

> @@ -95,7 +105,7 @@ static void dump_backtrace_entry(unsigned long where, unsigned long stack)
>  	print_ip_sym(where);
>  	if (in_exception_text(where))
>  		dump_mem("", "Exception stack", stack,
> -			 stack + sizeof(struct pt_regs));
> +			 stack + sizeof(struct pt_regs), 8);
>  }
>  
>  static void dump_instr(const char *lvl, struct pt_regs *regs)
> @@ -191,6 +201,7 @@ static int __die(const char *str, int err, struct thread_info *thread,
>  	struct task_struct *tsk = thread->task;
>  	static int die_counter;
>  	int ret;
> +	unsigned int width = 8;

You could just set width here:

	unsigned int width = is_compat_thread(thread) ? 4 : 8;

Or, if you pass the argument as bool to dump_mem, just use
is_compat_thread() directly.

>  
>  	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP "\n",
>  		 str, err, ++die_counter);
> @@ -206,8 +217,19 @@ static int __die(const char *str, int err, struct thread_info *thread,
>  		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), thread + 1);
>  
>  	if (!user_mode(regs) || in_interrupt()) {
> -		dump_mem(KERN_EMERG, "Stack: ", regs->sp,
> -			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
> +
> +		if (regs->sp > (unsigned long)task_stack_page(tsk)) {
> +			dump_mem(KERN_EMERG, "Stack: ", regs->sp,
> +				THREAD_SIZE +
> +				(unsigned long)task_stack_page(tsk), width);
> +		} else {
> +			if (compat_user_mode(regs))
> +				width = 4;
> +			dump_mem(KERN_EMERG, "Stack: ",
> +				(unsigned long)task_stack_page(tsk),
> +				THREAD_SIZE +
> +				(unsigned long)task_stack_page(tsk), width);
> +		}

I don't understand this change. If you have a good reason for it, please
add it as a separate patch as it doesn't look to me like it has anything
to do with the width as described in this patch.

-- 
Catalin
