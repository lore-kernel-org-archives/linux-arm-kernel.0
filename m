From: FlorianSchandinat@gmx.de (Florian Tobias Schandinat)
Date: Wed, 21 Mar 2012 12:47:46 +0000
Subject: [PATCH] ARM: fix lcd power build failure in collie_defconfig
In-Reply-To: <1331051502-22361-1-git-send-email-paul.gortmaker@windriver.com>
References: <1331051502-22361-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <4F69CDF2.3020609@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 04:31 PM, Paul Gortmaker wrote:
> Commit 086ada54abaa4316e8603f02410fe8ebc9ba2de1 (linux-next)
> 
>   "FB: sa1100: remove global sa1100fb_.*_power function pointers"
> 
> got rid of all instances but one in locomolcd.c -- which was
> conditional on CONFIG_SA1100_COLLIE.  The associated .power
> field which replaces the global is populated in mach-sa1100/collie.c
> so move the assignment there, but make it conditional on the
> locomolcd support, so use CONFIG_BACKLIGHT_LOCOMO in that file.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

What about this patch?
I assumed Russel would pick it up as the commit referenced is also in
his tree but it looks like this patch is still not in -next. Any reasons
for this?


Best regards,

Florian Tobias Schandinat

> 
> diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
> index 48885b7..c7f418b 100644
> --- a/arch/arm/mach-sa1100/collie.c
> +++ b/arch/arm/mach-sa1100/collie.c
> @@ -313,6 +313,10 @@ static struct sa1100fb_mach_info collie_lcd_info = {
>  
>  	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
>  	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
> +
> +#ifdef CONFIG_BACKLIGHT_LOCOMO
> +	.lcd_power	= locomolcd_power
> +#endif
>  };
>  
>  static void __init collie_init(void)
> diff --git a/arch/arm/mach-sa1100/include/mach/collie.h b/arch/arm/mach-sa1100/include/mach/collie.h
> index 52acda7..f33679d 100644
> --- a/arch/arm/mach-sa1100/include/mach/collie.h
> +++ b/arch/arm/mach-sa1100/include/mach/collie.h
> @@ -1,7 +1,7 @@
>  /*
>   * arch/arm/mach-sa1100/include/mach/collie.h
>   *
> - * This file contains the hardware specific definitions for Assabet
> + * This file contains the hardware specific definitions for Collie
>   * Only include this file from SA1100-specific files.
>   *
>   * ChangeLog:
> @@ -13,6 +13,7 @@
>  #ifndef __ASM_ARCH_COLLIE_H
>  #define __ASM_ARCH_COLLIE_H
>  
> +extern void locomolcd_power(int on);
>  
>  #define COLLIE_SCOOP_GPIO_BASE	(GPIO_MAX + 1)
>  #define COLLIE_GPIO_CHARGE_ON	(COLLIE_SCOOP_GPIO_BASE + 0)
> diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
> index be20b5c..3a6d541 100644
> --- a/drivers/video/backlight/locomolcd.c
> +++ b/drivers/video/backlight/locomolcd.c
> @@ -229,14 +229,7 @@ static struct locomo_driver poodle_lcd_driver = {
>  
>  static int __init locomolcd_init(void)
>  {
> -	int ret = locomo_driver_register(&poodle_lcd_driver);
> -	if (ret)
> -		return ret;
> -
> -#ifdef CONFIG_SA1100_COLLIE
> -	sa1100fb_lcd_power = locomolcd_power;
> -#endif
> -	return 0;
> +	return locomo_driver_register(&poodle_lcd_driver);
>  }
>  
>  static void __exit locomolcd_exit(void)
