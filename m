From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 19 Mar 2015 13:39:58 -0400
Subject: [RFC PATCH 2/7] printk: Simple implementation for NMI backtracing
In-Reply-To: <1426688428-3150-3-git-send-email-daniel.thompson@linaro.org>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
 <1426688428-3150-3-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150319133958.4821493e@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Mar 2015 14:20:23 +0000
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> Currently there is a quite a pile of code sitting in
> arch/x86/kernel/apic/hw_nmi.c to support safe all-cpu backtracing from NMI.
> The code is inaccessible to backtrace implementations for other
> architectures, which is a shame because they would probably like to be
> safe too.
> 
> Copy this code into printk, reworking it a little as we do so to make
> it easier to exploit as library code.
> 
> We'll port the x86 NMI backtrace logic to it in a later patch.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  include/linux/printk.h        |  20 ++++++
>  init/Kconfig                  |   3 +
>  kernel/printk/Makefile        |   1 +
>  kernel/printk/nmi_backtrace.c | 148 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 172 insertions(+)
>  create mode 100644 kernel/printk/nmi_backtrace.c
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index baa3f97d8ce8..44bb85ad1f62 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -228,6 +228,26 @@ static inline void show_regs_print_info(const char *log_lvl)
>  }
>  #endif
>  
> +#ifdef CONFIG_PRINTK_NMI_BACKTRACE
> +/*
> + * printk_nmi_backtrace_prepare/complete are called to prepare the
> + * system for some or all cores to issue trace from NMI.
> + * printk_nmi_backtrace_complete will print buffered output and cannot
> + * (safely) be called from NMI.
> + */
> +extern int printk_nmi_backtrace_prepare(void);
> +extern void printk_nmi_backtrace_complete(void);
> +
> +/*
> + * printk_nmi_backtrace_this_cpu_begin/end are used divert/restore printk
> + * on this cpu. The result is the output of printk() (by this CPU) will be
> + * stored in temporary buffers for later printing by
> + * printk_nmi_backtrace_complete.
> + */
> +extern void printk_nmi_backtrace_this_cpu_begin(void);
> +extern void printk_nmi_backtrace_this_cpu_end(void);
> +#endif
> +
>  extern asmlinkage void dump_stack(void) __cold;
>  
>  #ifndef pr_fmt
> diff --git a/init/Kconfig b/init/Kconfig
> index f5dbc6d4261b..0107e9b4d2cf 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1421,6 +1421,9 @@ config PRINTK
>  	  very difficult to diagnose system problems, saying N here is
>  	  strongly discouraged.
>  
> +config PRINTK_NMI_BACKTRACE
> +	bool
> +
>  config BUG
>  	bool "BUG() support" if EXPERT
>  	default y
> diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
> index 85405bdcf2b3..1849b001384a 100644
> --- a/kernel/printk/Makefile
> +++ b/kernel/printk/Makefile
> @@ -1,2 +1,3 @@
>  obj-y	= printk.o
> +obj-$(CONFIG_PRINTK_NMI_BACKTRACE)	+= nmi_backtrace.o
>  obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
> diff --git a/kernel/printk/nmi_backtrace.c b/kernel/printk/nmi_backtrace.c
> new file mode 100644
> index 000000000000..e9a06929c4f3
> --- /dev/null
> +++ b/kernel/printk/nmi_backtrace.c
> @@ -0,0 +1,148 @@
> +#include <linux/kernel.h>
> +#include <linux/seq_buf.h>
> +
> +#define NMI_BUF_SIZE		4096
> +
> +struct nmi_seq_buf {
> +	unsigned char		buffer[NMI_BUF_SIZE];
> +	struct seq_buf		seq;
> +};
> +
> +/* Safe printing in NMI context */
> +static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);
> +
> +static DEFINE_PER_CPU(printk_func_t, nmi_print_saved_print_func);
> +
> +/* "in progress" flag of NMI printing */
> +static unsigned long nmi_print_flag;
> +
> +static int __init printk_nmi_backtrace_init(void)
> +{
> +	struct nmi_seq_buf *s;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		s = &per_cpu(nmi_print_seq, cpu);
> +		seq_buf_init(&s->seq, s->buffer, NMI_BUF_SIZE);
> +	}
> +
> +	return 0;
> +}
> +pure_initcall(printk_nmi_backtrace_init);
> +
> +/*
> + * It is not safe to call printk() directly from NMI handlers.
> + * It may be fine if the NMI detected a lock up and we have no choice
> + * but to do so, but doing a NMI on all other CPUs to get a back trace
> + * can be done with a sysrq-l. We don't want that to lock up, which
> + * can happen if the NMI interrupts a printk in progress.
> + *
> + * Instead, we redirect the vprintk() to this nmi_vprintk() that writes
> + * the content into a per cpu seq_buf buffer. Then when the NMIs are
> + * all done, we can safely dump the contents of the seq_buf to a printk()
> + * from a non NMI context.
> + *
> + * This is not a generic printk() implementation and must be used with
> + * great care. In particular there is a static limit on the quantity of
> + * data that may be emitted during NMI, only one client can be active at
> + * one time (arbitrated by the return value of printk_nmi_begin() and
> + * it is required that something at task or interrupt context be scheduled
> + * to issue the output.
> + */
> +static int nmi_vprintk(const char *fmt, va_list args)
> +{
> +	struct nmi_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
> +	unsigned int len = seq_buf_used(&s->seq);
> +
> +	seq_buf_vprintf(&s->seq, fmt, args);
> +	return seq_buf_used(&s->seq) - len;
> +}
> +
> +/*
> + * Reserve the NMI printk mechanism. Return an error if some other component
> + * is already using it.
> + */
> +int printk_nmi_backtrace_prepare(void)
> +{
> +	if (test_and_set_bit(0, &nmi_print_flag)) {
> +		/*
> +		 * If something is already using the NMI print facility we
> +		 * can't allow a second one...
> +		 */
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static void print_seq_line(struct nmi_seq_buf *s, int start, int end)
> +{
> +	const char *buf = s->buffer + start;
> +
> +	printk("%.*s", (end - start) + 1, buf);
> +}
> +
> +void printk_nmi_backtrace_complete(void)
> +{
> +	struct nmi_seq_buf *s;
> +	int len, cpu, i, last_i;
> +
> +	/*
> +	 * Now that all the NMIs have triggered, we can dump out their
> +	 * back traces safely to the console.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		s = &per_cpu(nmi_print_seq, cpu);
> +		last_i = 0;
> +
> +		len = seq_buf_used(&s->seq);
> +		if (!len)
> +			continue;
> +
> +		/* Print line by line. */
> +		for (i = 0; i < len; i++) {
> +			if (s->buffer[i] == '\n') {
> +				print_seq_line(s, last_i, i);
> +				last_i = i + 1;
> +			}
> +		}
> +		/* Check if there was a partial line. */
> +		if (last_i < len) {
> +			print_seq_line(s, last_i, len - 1);
> +			pr_cont("\n");
> +		}
> +
> +		/* Wipe out the buffer ready for the next time around. */
> +		seq_buf_clear(&s->seq);
> +	}
> +
> +	clear_bit(0, &nmi_print_flag);
> +	smp_mb__after_atomic();

Is this really necessary. What is the mb synchronizing?

[ Added Peter Zijlstra to confirm it's not needed ]

-- Steve


> +}
> +
> +void printk_nmi_backtrace_this_cpu_begin(void)
> +{
> +	/*
> +	 * Detect double-begins and report them. This code is unsafe (because
> +	 * it will print from NMI) but things are pretty badly damaged if the
> +	 * NMI re-enters and is somehow granted permission to use NMI printk,
> +	 * so how much worse can it get? Also since this code interferes with
> +	 * the operation of printk it is unlikely that any consequential
> +	 * failures will be able to log anything making this our last
> +	 * opportunity to tell anyone that something is wrong.
> +	 */
> +	if (this_cpu_read(nmi_print_saved_print_func)) {
> +		this_cpu_write(printk_func,
> +			       this_cpu_read(nmi_print_saved_print_func));
> +		BUG();
> +	}
> +
> +	this_cpu_write(nmi_print_saved_print_func, this_cpu_read(printk_func));
> +	this_cpu_write(printk_func, nmi_vprintk);
> +}
> +
> +void printk_nmi_backtrace_this_cpu_end(void)
> +{
> +	this_cpu_write(printk_func, this_cpu_read(nmi_print_saved_print_func));
> +	this_cpu_write(nmi_print_saved_print_func, NULL);
> +}
