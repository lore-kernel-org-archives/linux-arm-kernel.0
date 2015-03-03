From: pmladek@suse.cz (Petr Mladek)
Date: Tue, 3 Mar 2015 17:29:24 +0100
Subject: [RFC PATCH v4 23/34] ftrace: notify kprobe when ftrace is
 initialized.
In-Reply-To: <1425306312-3437-24-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
 <1425306312-3437-24-git-send-email-wangnan0@huawei.com>
Message-ID: <20150303162924.GF3703@dhcp128.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2015-03-02 22:25:01, Wang Nan wrote:
> Makes ftrace calls init_kprobes_on_ftrace() when ftrace_init()
> finished. Before this call, marks kprobes on ftrace with
> 'KPROBE_FLAG_FTRACE_EARLY' instead of 'KPROBE_FLAG_FTRACE' to make
> kprobe not to kprobe treats these kprobes as ftrace kprobes.
> 
> Following patches should convert such kprobes into kprobes on ftrace.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> ---
>  include/linux/kprobes.h | 11 +++++++++++
>  kernel/kprobes.c        | 17 ++++++++++++++++-
>  kernel/trace/ftrace.c   |  2 ++
>  3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index bb2b2c6..96dc842 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -130,6 +130,8 @@ struct kprobe {
>  				   * this flag is only for optimized_kprobe.
>  				   */
>  #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
> +/* probe will use ftrace, but ftrace is not ready when registering */
> +#define KPROBE_FLAG_FTRACE_EARLY	16
>  
>  /* Has this kprobe gone ? */
>  static inline int kprobe_gone(struct kprobe *p)
> @@ -269,6 +271,14 @@ extern void show_registers(struct pt_regs *regs);
>  extern void kprobes_inc_nmissed_count(struct kprobe *p);
>  extern bool arch_within_kprobe_blacklist(unsigned long addr);
>  
> +#if defined(CONFIG_EARLY_KPROBES) && defined(CONFIG_KPROBES_ON_FTRACE)
> +extern void init_kprobes_on_ftrace(void);
> +#else
> +static inline void init_kprobes_on_ftrace(void)
> +{
> +}
> +#endif // CONFIG_EARLY_KPROBES && CONFIG_KPROBES_ON_FTRACE
> +
>  #ifdef CONFIG_EARLY_KPROBES
>  
>  #define NR_EARLY_KPROBES_SLOTS	CONFIG_NR_EARLY_KPROBES_SLOTS
> @@ -453,6 +463,7 @@ extern int proc_kprobes_optimization_handler(struct ctl_table *table,
>  extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  				  struct ftrace_ops *ops, struct pt_regs *regs);
>  extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
> +
>  #endif
>  
>  int arch_check_ftrace_location(struct kprobe *p);
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 4b7b20a..b5e13ba 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -69,6 +69,11 @@
>  
>  static int kprobes_initialized;
>  static int kprobes_blacklist_initialized;
> +#if defined(CONFIG_KPROBES_ON_FTRACE) && defined(CONFIG_EARLY_KPROBES)
> +static bool kprobes_on_ftrace_initialized __read_mostly = false;
> +#else
> +# define kprobes_on_ftrace_initialized	false
> +#endif
>  
>  bool kprobes_is_early(void)
>  {
> @@ -1497,7 +1502,10 @@ int __weak arch_check_ftrace_location(struct kprobe *p)
>  		/* Given address is not on the instruction boundary */
>  		if ((unsigned long)p->addr != ftrace_addr)
>  			return -EILSEQ;
> -		p->flags |= KPROBE_FLAG_FTRACE;
> +		if (unlikely(!kprobes_on_ftrace_initialized))
> +			p->flags |= KPROBE_FLAG_FTRACE_EARLY;
> +		else
> +			p->flags |= KPROBE_FLAG_FTRACE;
>  #else	/* !CONFIG_KPROBES_ON_FTRACE */
>  		return -EINVAL;
>  #endif
> @@ -2574,3 +2582,10 @@ module_init(init_kprobes);
>  
>  /* defined in arch/.../kernel/kprobes.c */
>  EXPORT_SYMBOL_GPL(jprobe_return);
> +
> +#if defined(CONFIG_KPROBES_ON_FTRACE) && defined(CONFIG_EARLY_KPROBES)
> +void init_kprobes_on_ftrace(void)
> +{
> +	kprobes_on_ftrace_initialized = true;

This flag is later used to decide whether the location is modified by
ftrace or by kprobe, see https://lkml.org/lkml/2015/3/3/4

Therefore you need to convert the probes and set the flag atomically. By
other words, you need to set this flag at the end of
convert_early_kprobes_on_ftrace() when you still hold kprobe_mutex.
Or you need to take the mutex already in init_kprobes_on_frace()
around both changes.

Note that I check only this aspect of this patchset because it was
affected by my fix of the kprobe recovery code.

Best Regards,
Petr

> +}
> +#endif
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7fa88d0..5cb0269 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -23,6 +23,7 @@
>  #include <linux/kthread.h>
>  #include <linux/uaccess.h>
>  #include <linux/bsearch.h>
> +#include <linux/kprobes.h>
>  #include <linux/module.h>
>  #include <linux/ftrace.h>
>  #include <linux/sysctl.h>
> @@ -5022,6 +5023,7 @@ void __init ftrace_init(void)
>  	if (ret)
>  		pr_warning("Failed to register trace ftrace module exit notifier\n");
>  
> +	init_kprobes_on_ftrace();
>  	set_ftrace_early_filters();
>  
>  	return;
> -- 
> 1.8.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
