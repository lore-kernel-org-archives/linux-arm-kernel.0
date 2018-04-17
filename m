From: bp@alien8.de (Borislav Petkov)
Date: Tue, 17 Apr 2018 17:10:18 +0200
Subject: [PATCH 02/11] ACPI / APEI: Generalise the estatus queue's
 add/remove and notify code
In-Reply-To: <d15ba145-479c-ffde-14ad-ab7170d0f06e@arm.com>
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-3-james.morse@arm.com>
 <20180301150144.GA4215@pd.tnic>
 <87sh9jbrgc.fsf@e105922-lin.cambridge.arm.com>
 <20180301223529.GA28811@pd.tnic> <5AA02C26.10803@arm.com>
 <20180308104408.GB21166@pd.tnic> <5AAFC939.3010309@arm.com>
 <20180327172510.GB32184@pd.tnic>
 <d15ba145-479c-ffde-14ad-ab7170d0f06e@arm.com>
Message-ID: <20180417151018.GE20840@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 05:30:55PM +0100, James Morse wrote:
> -----------------%<-----------------
>     ACPI / APEI: don't wait to serialise with oops messages when panic()ing
> 
>     oops_begin() exists to group printk() messages with the oops message
>     printed by die(). To reach this caller we know that platform firmware
>     took this error first, then notified the OS via NMI with a 'panic'
>     severity.
> 
>     Don't wait for another CPU to release the die-lock before we can
>     panic(), our only goal is to print this fatal error and panic().
> 
>     This code is always called in_nmi(), and since 42a0bb3f7138 ("printk/nmi:
>     generic solution for safe printk in NMI"), it has been safe to call
>     printk() from this context. Messages are batched in a per-cpu buffer
>     and printed via irq-work, or a call back from panic().
> 
>     Signed-off-by: James Morse <james.morse@arm.com>
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 22f6ea5b9ad5..f348e6540960 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -34,7 +34,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/timer.h>
>  #include <linux/cper.h>
> -#include <linux/kdebug.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
>  #include <linux/ratelimit.h>
> @@ -736,9 +735,6 @@ static int _in_nmi_notify_one(struct ghes *ghes)
> 
>         sev = ghes_severity(ghes->estatus->error_severity);
>         if (sev >= GHES_SEV_PANIC) {
> -#ifdef CONFIG_X86
> -               oops_begin();
> -#endif
>                 ghes_print_queued_estatus();
>                 __ghes_panic(ghes);
>         }
> -----------------%<-----------------

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
