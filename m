From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 20 Feb 2018 18:26:10 +0000
Subject: [PATCH 01/11] ACPI / APEI: Move the estatus queue code up,
 and under its own ifdef
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-2-james.morse@arm.com>
Message-ID: <87zi43zfel.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

A couple of nitpicks below.

James Morse <james.morse@arm.com> writes:

> To support asynchronous NMI-like notifications on arm64 we need to use
> the estatus-queue. These patches refactor it to allow multiple APEI
> notification types to use it.
>
> First we move the estatus-queue code higher in the file so that any
> notify_foo() handler can make user of it.
                                ^
                                use

>
> This patch moves code around ... and makes the following trivial change:
> Freshen the dated comment above ghes_estatus_llist. printk() is no
> longer the issue, its the helpers like memory_failure_queue() that
> still aren't nmi safe.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 267 ++++++++++++++++++++++++-----------------------
>  1 file changed, 139 insertions(+), 128 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 1efefe919555..e42b587c509b 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -545,6 +545,16 @@ static int ghes_print_estatus(const char *pfx,
>  	return 0;
>  }
>  
> +static void __ghes_panic(struct ghes *ghes)
> +{
> +	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
> +
> +	/* reboot to log the error! */
> +	if (!panic_timeout)
> +		panic_timeout = ghes_panic_timeout;
> +	panic("Fatal hardware error!");
> +}
> +
>  /*
>   * GHES error status reporting throttle, to report more kinds of
>   * errors, instead of just most frequently occurred errors.
> @@ -672,6 +682,135 @@ static void ghes_estatus_cache_add(
>  	rcu_read_unlock();
>  }
>  
> +#ifdef CONFIG_HAVE_ACPI_APEI_NMI
> +/*
> + * While printk() now has an in_nmi() path, the handling for CPER records
> + * does not. For example, memory_failure_queue() takes spinlocks and calls
> + * schedule_work_on().
> + *
> + * So in any NMI-like handler, we allocate required memory from lock-less
> + * memory allocator (ghes_estatus_pool), save estatus into it, put them into
> + * lock-less list (ghes_estatus_llist), then delay printk into IRQ context via
> + * irq_work (ghes_proc_irq_work).  ghes_estatus_size_request record
> + * required pool size by all NMI error source.

I am not sure it is worth keeping specific references to printk
around. As you're refreshing the comment, I'd suggest replacing the
above reference with "...processing of error status reported by the
NMI..." or something similar.

Thanks,
Punit


[...]
