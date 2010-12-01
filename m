From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 1 Dec 2010 11:19:02 +0100
Subject: [PATCH 1/3] ARM: SAMSUNG: Convert s3c_irqext_wake() to new irq_
	interrupt methods
In-Reply-To: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20101201101902.GA22683@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 03:18:27PM +0000, Mark Brown wrote:

> Kernel 2.6.37 adds new interrupt methods which take a struct irq_data
> rather than an irq number. Begin converting Samsung platforms over to
> these methods by converting s3c_irqext_wake() with a simple textual
> substitution.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/irq-eint.c        |    2 +-
>  arch/arm/mach-s5pv310/irq-eint.c        |    2 +-
>  arch/arm/plat-s3c24xx/irq.c             |    2 +-
>  arch/arm/plat-s5p/irq-eint.c            |    4 ++--
>  arch/arm/plat-samsung/include/plat/pm.h |    4 +++-
>  arch/arm/plat-samsung/pm.c              |    6 +++---
>  6 files changed, 11 insertions(+), 9 deletions(-)

It would seem that this patch breaks s3c:

./mach-s3c64xx/irq-eint.c:	.irq_set_wake	= s3c_irqext_wake,
./plat-s3c24xx/irq.c:	.irq_set_wake	= s3c_irqext_wake



> diff --git a/arch/arm/mach-s3c64xx/irq-eint.c b/arch/arm/mach-s3c64xx/irq-eint.c
> index 5682d6a..1a1aa5d 100644
> --- a/arch/arm/mach-s3c64xx/irq-eint.c
> +++ b/arch/arm/mach-s3c64xx/irq-eint.c
> @@ -145,7 +145,7 @@ static struct irq_chip s3c_irq_eint = {
>  	.mask_ack	= s3c_irq_eint_maskack,
>  	.ack		= s3c_irq_eint_ack,
>  	.set_type	= s3c_irq_eint_set_type,
> -	.set_wake	= s3c_irqext_wake,
> +	.irq_set_wake	= s3c_irqext_wake,
>  };
>  
>  /* s3c_irq_demux_eint
> diff --git a/arch/arm/mach-s5pv310/irq-eint.c b/arch/arm/mach-s5pv310/irq-eint.c
> index 5877503..f5a415e 100644
> --- a/arch/arm/mach-s5pv310/irq-eint.c
> +++ b/arch/arm/mach-s5pv310/irq-eint.c
> @@ -152,7 +152,7 @@ static struct irq_chip s5pv310_irq_eint = {
>  	.ack		= s5pv310_irq_eint_ack,
>  	.set_type	= s5pv310_irq_eint_set_type,
>  #ifdef CONFIG_PM
> -	.set_wake	= s3c_irqext_wake,
> +	.irq_set_wake	= s3c_irqext_wake,
>  #endif
>  };
>  
> diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
> index ad0d44e..91ce383 100644
> --- a/arch/arm/plat-s3c24xx/irq.c
> +++ b/arch/arm/plat-s3c24xx/irq.c
> @@ -238,7 +238,7 @@ static struct irq_chip s3c_irqext_chip = {
>  	.unmask		= s3c_irqext_unmask,
>  	.ack		= s3c_irqext_ack,
>  	.set_type	= s3c_irqext_type,
> -	.set_wake	= s3c_irqext_wake
> +	.irq_set_wake	= s3c_irqext_wake
>  };
>  
>  static struct irq_chip s3c_irq_eint0t4 = {
> diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
> index 752f1a6..f2f2e1c 100644
> --- a/arch/arm/plat-s5p/irq-eint.c
> +++ b/arch/arm/plat-s5p/irq-eint.c
> @@ -125,7 +125,7 @@ static struct irq_chip s5p_irq_eint = {
>  	.ack		= s5p_irq_eint_ack,
>  	.set_type	= s5p_irq_eint_set_type,
>  #ifdef CONFIG_PM
> -	.set_wake	= s3c_irqext_wake,
> +	.irq_set_wake	= s3c_irqext_wake,
>  #endif
>  };
>  
> @@ -194,7 +194,7 @@ static struct irq_chip s5p_irq_vic_eint = {
>  	.ack		= s5p_irq_vic_eint_ack,
>  	.set_type	= s5p_irq_eint_set_type,
>  #ifdef CONFIG_PM
> -	.set_wake	= s3c_irqext_wake,
> +	.irq_set_wake	= s3c_irqext_wake,
>  #endif
>  };
>  
> diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-samsung/include/plat/pm.h
> index 245836d..d9025e3 100644
> --- a/arch/arm/plat-samsung/include/plat/pm.h
> +++ b/arch/arm/plat-samsung/include/plat/pm.h
> @@ -15,6 +15,8 @@
>   * management
>  */
>  
> +#include <linux/irq.h>
> +
>  #ifdef CONFIG_PM
>  
>  extern __init int s3c_pm_init(void);
> @@ -100,7 +102,7 @@ extern void s3c_pm_do_restore(struct sleep_save *ptr, int count);
>  extern void s3c_pm_do_restore_core(struct sleep_save *ptr, int count);
>  
>  #ifdef CONFIG_PM
> -extern int s3c_irqext_wake(unsigned int irqno, unsigned int state);
> +extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
>  extern int s3c24xx_irq_suspend(struct sys_device *dev, pm_message_t state);
>  extern int s3c24xx_irq_resume(struct sys_device *dev);
>  #else
> diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
> index 5bf3f2f..02d531f 100644
> --- a/arch/arm/plat-samsung/pm.c
> +++ b/arch/arm/plat-samsung/pm.c
> @@ -136,15 +136,15 @@ static void s3c_pm_restore_uarts(void) { }
>  unsigned long s3c_irqwake_intmask	= 0xffffffffL;
>  unsigned long s3c_irqwake_eintmask	= 0xffffffffL;
>  
> -int s3c_irqext_wake(unsigned int irqno, unsigned int state)
> +int s3c_irqext_wake(struct irq_data *data, unsigned int state)
>  {
> -	unsigned long bit = 1L << IRQ_EINT_BIT(irqno);
> +	unsigned long bit = 1L << IRQ_EINT_BIT(data->irq);
>  
>  	if (!(s3c_irqwake_eintallow & bit))
>  		return -ENOENT;
>  
>  	printk(KERN_INFO "wake %s for irq %d\n",
> -	       state ? "enabled" : "disabled", irqno);
> +	       state ? "enabled" : "disabled", data->irq);
>  
>  	if (!state)
>  		s3c_irqwake_eintmask |= bit;
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
