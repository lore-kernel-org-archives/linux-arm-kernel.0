From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 May 2014 15:20:07 -0700
Subject: [PATCH] bus/omap_l3: avoid sync initcall for modules
In-Reply-To: <1399560990-1402858-6-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-6-git-send-email-arnd@arndb.de>
Message-ID: <20140512222006.GI5668@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [140508 07:57]:
> The postcore_initcall_sync() macro is only defined for built-in
> code, but the omap_l3 bus code can be built as a module, which
> currently causes a build failure.
> 
> This works around the problem by using #ifdef MODULE to decide
> whether to use a regular module_init() function or not.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/bus/omap_l3_noc.c | 4 ++++
>  drivers/bus/omap_l3_smx.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
> index feeecae..648f158 100644
> --- a/drivers/bus/omap_l3_noc.c
> +++ b/drivers/bus/omap_l3_noc.c
> @@ -257,7 +257,11 @@ static int __init omap4_l3_init(void)
>  {
>  	return platform_driver_register(&omap4_l3_driver);
>  }
> +#ifdef MODULE
> +module_init(omap4_l3_init);
> +#else
>  postcore_initcall_sync(omap4_l3_init);
> +#endif
>  
>  static void __exit omap4_l3_exit(void)
>  {
> diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
> index acc2164..f752d1b 100644
> --- a/drivers/bus/omap_l3_smx.c
> +++ b/drivers/bus/omap_l3_smx.c
> @@ -288,7 +288,11 @@ static int __init omap3_l3_init(void)
>  {
>  	return platform_driver_probe(&omap3_l3_driver, omap3_l3_probe);
>  }
> +#ifdef MODULE
> +module_init(omap3_l3_init);
> +#else
>  postcore_initcall_sync(omap3_l3_init);
> +#endif
>  
>  static void __exit omap3_l3_exit(void)
>  {

How about instead let's add this into include/linux/module.h
like we have for other initcalls:

#define postcore_initcall(fn)		module_init(fn)

There may be others missing too from there. BTW, this driver
might be few of the drivers that actually might need to be
initialized early for debugging to catch bad access from
other drivers.

Regards,

Tony
