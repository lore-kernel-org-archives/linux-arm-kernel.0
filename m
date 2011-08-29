From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 29 Aug 2011 11:14:18 -0400 (EDT)
Subject: [RFC PATCH] arm: fiq: convert enable/disable_fiq to inline
	functions
In-Reply-To: <1314628177-3193-1-git-send-email-svenkatr@ti.com>
References: <1314628177-3193-1-git-send-email-svenkatr@ti.com>
Message-ID: <alpine.LFD.2.00.1108291112010.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Aug 2011, Venkatraman S wrote:

> FIQ_START is an platform specific constant used in the
> implementation of enable_fiq and disable_fiq.
> Converting then to inline functions enables different
> architectures which use the FIQ module to exist in a single
> zImage with different values of FIQ_START.
> 
> Signed-off-by: Venkatraman S <svenkatr@ti.com>

I fail to see how this patch inproves things. The asm/fiq.h file is just 
as global as kernel/fiq.c is.


> ---
>  arch/arm/include/asm/fiq.h |   13 +++++++++++--
>  arch/arm/kernel/fiq.c      |   11 -----------
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
> index d493d0b..e84a8cc 100644
> --- a/arch/arm/include/asm/fiq.h
> +++ b/arch/arm/include/asm/fiq.h
> @@ -17,6 +17,7 @@
>  #define __ASM_FIQ_H
>  
>  #include <asm/ptrace.h>
> +#include <asm/irq.h>
>  
>  struct fiq_handler {
>  	struct fiq_handler *next;
> @@ -36,8 +37,16 @@ struct fiq_handler {
>  extern int claim_fiq(struct fiq_handler *f);
>  extern void release_fiq(struct fiq_handler *f);
>  extern void set_fiq_handler(void *start, unsigned int length);
> -extern void enable_fiq(int fiq);
> -extern void disable_fiq(int fiq);
> +
> +static inline void enable_fiq(int fiq)
> +{
> +	enable_irq(fiq + FIQ_START);
> +}
> +
> +static inline void disable_fiq(int fiq)
> +{
> +	disable_irq(fiq + FIQ_START);
> +}
>  
>  /* helpers defined in fiqasm.S: */
>  extern void __set_fiq_regs(unsigned long const *regs);
> diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
> index 4c164ec..49e5355 100644
> --- a/arch/arm/kernel/fiq.c
> +++ b/arch/arm/kernel/fiq.c
> @@ -122,23 +122,12 @@ void release_fiq(struct fiq_handler *f)
>  	while (current_fiq->fiq_op(current_fiq->dev_id, 0));
>  }
>  
> -void enable_fiq(int fiq)
> -{
> -	enable_irq(fiq + FIQ_START);
> -}
> -
> -void disable_fiq(int fiq)
> -{
> -	disable_irq(fiq + FIQ_START);
> -}
>  
>  EXPORT_SYMBOL(set_fiq_handler);
>  EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
>  EXPORT_SYMBOL(__get_fiq_regs);	/* defined in fiqasm.S */
>  EXPORT_SYMBOL(claim_fiq);
>  EXPORT_SYMBOL(release_fiq);
> -EXPORT_SYMBOL(enable_fiq);
> -EXPORT_SYMBOL(disable_fiq);
>  
>  void __init init_FIQ(void)
>  {
> -- 
> 1.7.1
> 
