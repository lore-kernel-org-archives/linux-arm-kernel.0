From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 17:13:47 +0200
Subject: [PATCH 2/2] arch: arm: samsung: Clean-up usage of
 CONFIG_SERIAL_SAMSUNG_UARTS symbol
In-Reply-To: <1412087695-10591-2-git-send-email-a.kesavan@samsung.com>
References: <1412087695-10591-1-git-send-email-a.kesavan@samsung.com>
 <1412087695-10591-2-git-send-email-a.kesavan@samsung.com>
Message-ID: <2267491.QlLoTEuT3L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 20:04:55 Abhilash Kesavan wrote:
> --- a/arch/arm/mach-s3c64xx/irq-pm.c
> +++ b/arch/arm/mach-s3c64xx/irq-pm.c
> @@ -55,10 +55,10 @@ static struct irq_grp_save {
>         u32     mask;
>  } eint_grp_save[5];
>  
> -#ifndef CONFIG_SERIAL_SAMSUNG_UARTS
> -#define SERIAL_SAMSUNG_UARTS 0
> +#ifndef CONFIG_SERIAL_SAMSUNG
> +#define SERIAL_SAMSUNG_UARTS   0
>  #else
> -#define        SERIAL_SAMSUNG_UARTS CONFIG_SERIAL_SAMSUNG_UARTS
> +#define SERIAL_SAMSUNG_UARTS   4
>  #endif
>  
>  static u32 irq_uart_mask[SERIAL_SAMSUNG_UARTS];

I think this won't work because now you access invalid registers
on machines that have only three uarts.

> diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
> index 11fbbc2..03cafe9 100644
> --- a/arch/arm/plat-samsung/init.c
> +++ b/arch/arm/plat-samsung/init.c
> @@ -93,8 +93,8 @@ void __init s3c24xx_init_clocks(int xtal)
>  #if IS_ENABLED(CONFIG_SAMSUNG_ATAGS)
>  static int nr_uarts __initdata = 0;
>  
> -#ifdef CONFIG_SERIAL_SAMSUNG_UARTS
> -static struct s3c2410_uartcfg uart_cfgs[CONFIG_SERIAL_SAMSUNG_UARTS];
> +#ifdef CONFIG_SERIAL_SAMSUNG
> +static struct s3c2410_uartcfg uart_cfgs[4];
>  #endif
>  
>  /* s3c24xx_init_uartdevs
> @@ -110,7 +110,7 @@ void __init s3c24xx_init_uartdevs(char *name,
>                                   struct s3c24xx_uart_resources *res,
>                                   struct s3c2410_uartcfg *cfg, int no)
>  {
> -#ifdef CONFIG_SERIAL_SAMSUNG_UARTS
> +#ifdef CONFIG_SERIAL_SAMSUNG
>         struct platform_device *platdev;
>         struct s3c2410_uartcfg *cfgptr = uart_cfgs;
>         struct s3c24xx_uart_resources *resp;

Since you hardcode the number here now, you can actually drop this #ifdef.

	Arnd
