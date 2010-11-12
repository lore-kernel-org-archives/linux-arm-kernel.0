From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Nov 2010 08:40:32 +0100
Subject: ARM: fix compile warning in mm/init.c
In-Reply-To: <1289542753-30185-1-git-send-email-gadiyar@ti.com>
References: <1289542753-30185-1-git-send-email-gadiyar@ti.com>
Message-ID: <20101112074032.GF18358@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 11:49:13AM +0530, Anand Gadiyar wrote:
> Commit 7c63984b86 (ARM: do not define VMALLOC_END relative to PAGE_OFFSET)
> changed VMALLOC_END to be an explicit value. Before this, it was
> relative to PAGE_OFFSET and therefore automatically upgraded to
> unsigned long as PAGE_OFFSET was an unsigned long. This introduced
> the following build warning. Fix this.
> 
>   CC      arch/arm/mm/init.o
> arch/arm/mm/init.c: In function 'mem_init':
> arch/arm/mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but argument 12 has type 'unsigned int'
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> ---
>  arch/arm/mm/init.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: ehci/arch/arm/mm/init.c
> ===================================================================
> --- ehci.orig/arch/arm/mm/init.c
> +++ ehci/arch/arm/mm/init.c
> @@ -593,7 +593,7 @@ void __init mem_init(void)
>  #ifdef CONFIG_MMU
>  			MLM(CONSISTENT_BASE, CONSISTENT_END),
>  #endif
> -			MLM(VMALLOC_START, VMALLOC_END),
> +			MLM(VMALLOC_START, (unsigned long)VMALLOC_END),
I wonder if this is the only place where this is a problem.  Maybe it's
better to make the defined value of all VMALLOC_END an unsigned long as
some already are?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
