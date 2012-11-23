From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 23 Nov 2012 07:40:30 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxMC8xMF0gQVJNOiBGSVE6IEdldCByaWQgb2YgaW5pdF9G?=
 =?UTF-8?B?SVEoKQ==?=
In-Reply-To: <1353631803-4853-10-git-send-email-anton.vorontsov@linaro.org>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
 <1353631803-4853-10-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <1353642030.851395840@f20.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The function only saves initial arch-specific "no FIQ" instruction, by
> placing the code into set_fiq_handler() we can:
> 
> - Have less code and logic in the platform-specific files;
> - Have the code that manages FIQ vector overwriting in one place, i.e.
>   don't spread the logic around.
> 
> p.s. Also, I noticed that we saved no_fiq_insn w/o bothering about
> !CONFIG_CPU_USE_DOMAINS case, but set_fiq_handler() handles this case
> specifically. I wonder, was that on purpose, e.g. it does not matter for
> init_FIQ(), or it was just overlooked? In the latter case, the patch fixes
> the issue.
...
> diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
> index 9bf3a60..3602df6 100644
> --- a/arch/arm/kernel/fiq.c
> +++ b/arch/arm/kernel/fiq.c
> @@ -49,6 +49,7 @@
>  #include <asm/mach/irq.h>
>  
>  static unsigned long no_fiq_insn;
> +static int got_no_fiq_insn;
>  
>  /* Default reacquire function
>   * - we always relinquish FIQ control
> @@ -78,11 +79,14 @@ void show_fiq_list(struct seq_file *p, int prec)
>  
>  void set_fiq_handler(void *start, unsigned int length)
>  {
> -#if defined(CONFIG_CPU_USE_DOMAINS)
> -	memcpy((void *)0xffff001c, start, length);
> -#else
> -	memcpy(vectors_page + 0x1c, start, length);
> +	unsigned long *addr = (void *)0xffff001c;
> +
> +#ifndef CONFIG_CPU_USE_DOMAINS
> +	addr = vectors_page + 0x1c;
>  #endif
> +	if (!cmpxchg(&got_no_fiq_insn, 0, 1))
> +		no_fiq_insn = *addr;
> +	memcpy(addr, start, length);
>  	flush_icache_range(0xffff001c, 0xffff001c + length);
>  	if (!vectors_high())
>  		flush_icache_range(0x1c, 0x1c + length);
> @@ -126,8 +130,3 @@ EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
>  EXPORT_SYMBOL(__get_fiq_regs);	/* defined in fiqasm.S */
>  EXPORT_SYMBOL(claim_fiq);
>  EXPORT_SYMBOL(release_fiq);
> -
> -void __init init_FIQ(void)
> -{
> -	no_fiq_insn = *(unsigned long *)0xffff001c;

it seems that this is wrong. In this case we have an uninitialized variable and
sequential call claim_fiq and release_fiq could be fatal. FIXME please.

---
