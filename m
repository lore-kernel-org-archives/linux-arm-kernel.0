From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 24 Oct 2013 11:51:18 +1030
Subject: [RFC PATCH] kernel/kallsyms.c: only show legal kernel symbol
In-Reply-To: <1382498320-26594-1-git-send-email-tom.leiming@gmail.com>
References: <1382498320-26594-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <87eh7bfoq9.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ming Lei <tom.leiming@gmail.com> writes:
> Address of non-module kernel symbol should always be located
> from CONFIG_PAGE_OFFSET on, so only show these legal kernel
> symbols in /proc/kallsyms.
>
> On ARM, some symbols(see below) may drop in relocatable code, so
> perf can't parse kernel symbols any more from /proc/kallsyms, this
> patch fixes the problem.
>
> 	00000000 t __vectors_start
> 	00000020 A cpu_v7_suspend_size
> 	00001000 t __stubs_start
> 	00001004 t vector_rst
> 	00001020 t vector_irq
> 	000010a0 t vector_dabt
> 	00001120 t vector_pabt
> 	000011a0 t vector_und
> 	00001220 t vector_addrexcptn
> 	00001224 t vector_fiq
> 	00001224 T vector_fiq_offset
>
> The issue can be fixed in scripts/kallsyms.c too, but looks this
> approach is easier.

This fix looks hacky; if these symbols are not available, don't just
remove them from /proc/kallsyms, but don't put them in the kernel at
all.

That way, they won't interfere with other kallsyms uses (eg. backtrace).

Or, better, figure out a smart way of excluding them by knowing why
these symbol addresses are wrong.

Thanks,
Rusty.

> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Chen Gang <gang.chen@asianux.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  kernel/kallsyms.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 3127ad5..184f271 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -543,7 +543,7 @@ static int s_show(struct seq_file *m, void *p)
>  					tolower(iter->type);
>  		seq_printf(m, "%pK %c %s\t[%s]\n", (void *)iter->value,
>  			   type, iter->name, iter->module_name);
> -	} else
> +	} else if (iter->value >= CONFIG_PAGE_OFFSET)
>  		seq_printf(m, "%pK %c %s\n", (void *)iter->value,
>  			   iter->type, iter->name);
>  	return 0;
> -- 
> 1.7.9.5
