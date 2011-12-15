From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Dec 2011 22:56:49 +0100
Subject: [PATCH v2] [RESEND] Handle instruction cache maintenance fault
 properly
In-Reply-To: <AANLkTilVp0xvAJNns3TEe4SzEUpN8hMC9DdwmwW7i9yX@mail.gmail.com>
References: <AANLkTilVp0xvAJNns3TEe4SzEUpN8hMC9DdwmwW7i9yX@mail.gmail.com>
Message-ID: <20111215215649.GJ24496@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 11, 2010 at 01:33:14PM +0300, Kirill A. Shutemov wrote:
> Between "clean D line..." and "invalidate I line" operations in
> v7_coherent_user_range(), the memory page may get swapped out.
> And the fault on "invalidate I line" could not be properly handled
> causing the oops.
> 
> In ARMv6 "external abort on linefetch" replaced by "instruction cache
> maintenance fault". Let's handle it as translation fault. It fixes the
> issue.
> 
> I'm not sure if it's reasonable to check arch version in run-time.
> Let's do it in compile time for now.
> 
> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
I found this patch in Catalin's stack that I picked up to get support
for Cortex-M3. Is this still relevant?

Best regards
Uwe

> Sorry for resend. I've made mistake in maillist address.
> 
> ---
>  arch/arm/mm/fault.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 9d40c34..7f193ea 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -463,7 +463,12 @@ static struct fsr_info {
>  	{ do_bad,		SIGILL,	 BUS_ADRALN,	"alignment exception"		   },
>  	{ do_bad,		SIGKILL, 0,		"terminal exception"		   },
>  	{ do_bad,		SIGILL,	 BUS_ADRALN,	"alignment exception"		   },
> +/* Do we need runtime check ? */
> +#if __LINUX_ARM_ARCH__ < 6
>  	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
> +#else
> +	{ do_translation_fault,	SIGSEGV, SEGV_MAPPER,	"I-cache maintenance
> fault"	   },
> +#endif
>  	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation
> fault"	   },
>  	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
>  	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
> -- 
> 1.7.0.4
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
