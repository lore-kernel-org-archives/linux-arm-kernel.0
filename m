From: sergey.senozhatsky@gmail.com (Sergey Senozhatsky)
Date: Wed, 27 Jun 2018 23:20:53 +0900
Subject: [PATCH v9 4/6] init: allow initcall tables to be emitted using
 relative references
In-Reply-To: <20180626182802.19932-5-ard.biesheuvel@linaro.org>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
 <20180626182802.19932-5-ard.biesheuvel@linaro.org>
Message-ID: <20180627142053.GB477@tigerII.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (06/26/18 20:27), Ard Biesheuvel wrote:
>  /*
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 247808333ba4..688a27b0888c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2772,7 +2772,8 @@ EXPORT_SYMBOL(unregister_console);
>  void __init console_init(void)
>  {
>  	int ret;
> -	initcall_t *call;
> +	initcall_t call;
> +	initcall_entry_t *ce;
>  
>  	/* Setup the default TTY line discipline. */
>  	n_tty_init();
> @@ -2781,13 +2782,14 @@ void __init console_init(void)
>  	 * set up the console device so that later boot sequences can
>  	 * inform about problems etc..
>  	 */
> -	call = __con_initcall_start;
> +	ce = __con_initcall_start;
>  	trace_initcall_level("console");
> -	while (call < __con_initcall_end) {
> -		trace_initcall_start((*call));
> -		ret = (*call)();
> -		trace_initcall_finish((*call), ret);
> -		call++;
> +	while (ce < __con_initcall_end) {
> +		call = initcall_from_entry(ce);
> +		trace_initcall_start(call);
> +		ret = call();
> +		trace_initcall_finish(call, ret);
> +		ce++;
>  	}
>  }

printk bits look OK to me.
The patch set works fine on my x86_64 and does reduce the size of vmlinux.

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
