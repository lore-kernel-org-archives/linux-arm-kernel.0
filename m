From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Sep 2013 12:34:25 +0200
Subject: [PATCH 3/3] [RFC] ARM: prepare ARMv7-M for MULTIPLATFORM use
In-Reply-To: <1380534577-15076-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380534577-15076-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201309301234.25913.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 September 2013, Uwe Kleine-K?nig wrote:
> v7-M is a third group that is incompatible with both v4/v5 and v6/v7.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> This behaves strange but I think is robust not to allow broken configs:
> 
> When v4/v5 is selected, v6/v7 and v7m are available for enabling, too.
> When v6/v7 is selected the other choices are disabled
> When v7m is selected only v6/v7 are available for enabling.

The Kconfig stuff all looks good, 

Acked-by: Arnd Bergmann <arnd@arndb.de>


> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
> index 52b2643..f72ced6 100644
> --- a/arch/arm/kernel/entry-v7m.S
> +++ b/arch/arm/kernel/entry-v7m.S
> @@ -14,8 +14,6 @@
>  #include <asm/thread_notify.h>
>  #include <asm/v7m.h>
>  
> -#include <mach/entry-macro.S>
> -
>  #include "entry-header.S"
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
> @@ -141,3 +139,7 @@ ENTRY(vector_table)
>  	.rept	64 - 16
>  	.long	__irq_entry		@ 16..64 - External Interrupts
>  	.endr
> +
> +	.globl  handle_arch_irq
> +handle_arch_irq:
> +	.long	0
> -- 
> 1.8.4.rc3

I'm not sure about this part. I guess you should either make it
a separate patch, or describe what it's for in the patch description above.

Also, I'd put all of the text you have in the comment into the actual
changeset text, above the --- line, as others might find that useful
later.

	Arnd
