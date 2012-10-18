From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Thu, 18 Oct 2012 15:09:48 +0530
Subject: [PATCH 5/9] uprobes: allow arch-specific initialization
In-Reply-To: <1350242593-17761-5-git-send-email-rabin@rab.in>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-5-git-send-email-rabin@rab.in>
Message-ID: <20121018093948.GA10321@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rabin Vincent <rabin@rab.in> [2012-10-14 21:23:09]:

> Add a weak function for any architecture-specific initialization.  ARM
> will use this to register the handlers for the undefined instructions it
> uses to implement uprobes.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  include/linux/uprobes.h |    1 +
>  kernel/events/uprobes.c |   10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index b4380ad..c3dc5de 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -130,6 +130,7 @@ extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned l
>  extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern void __weak arch_uprobe_xol_copy(struct arch_uprobe *auprobe, void *vaddr);
> +extern int __weak arch_uprobes_init(void);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index f7ff3a4..ca000a9 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1634,8 +1634,14 @@ static struct notifier_block uprobe_exception_nb = {
>  	.priority		= INT_MAX-1,	/* notified after kprobes, kgdb */
>  };
> 
> +int __weak __init arch_uprobes_init(void)
> +{
> +	return 0;
> +}
> +
>  static int __init init_uprobes(void)
>  {
> +	int ret;
>  	int i;
> 
>  	for (i = 0; i < UPROBES_HASH_SZ; i++) {
> @@ -1643,6 +1649,10 @@ static int __init init_uprobes(void)
>  		mutex_init(&uprobes_mmap_mutex[i]);
>  	}
> 
> +	ret = arch_uprobes_init();
> +	if (ret)
> +		return ret;
> +
>  	return register_die_notifier(&uprobe_exception_nb);
>  }
>  module_init(init_uprobes);
> -- 

We should be able to move the register_die_notifier and
uprobe_exception_nb structure into the default arch_uprobes_init.

Right? 

-- 
thanks and regards
Srikar
