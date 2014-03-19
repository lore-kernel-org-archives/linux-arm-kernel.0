From: balbi@ti.com (Felipe Balbi)
Date: Wed, 19 Mar 2014 14:59:13 -0500
Subject: [PATCH 23/62] ARM: omap1: fix building without 32K_TIMER
In-Reply-To: <1395257399-359545-24-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-24-git-send-email-arnd@arndb.de>
Message-ID: <20140319195913.GA4271@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 19, 2014 at 08:29:20PM +0100, Arnd Bergmann wrote:
> If we enable CONFIG_OMAP_MPU_TIMER and CONFIG_OMAP_DM_TIMER but
> not CONFIG_OMAP_32K_TIMER on OMAP1, we currently get this build error:
> 
> mach-omap1/pm.c: In function 'omap1_pm_idle':
> mach-omap1/pm.c:123:9: error: 'enable_dyn_sleep' undeclared (first use in this function)
>   while (enable_dyn_sleep) {
>          ^
> mach-omap1/pm.c:123:9: note: each undeclared identifier is reported only once for each function it appears in
> 
> This attempts to fix the #ifdef logic to deal with all combinations
> of timers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-omap at vger.kernel.org
> Cc: Tony Lindgren <tony@atomide.com>

I had sent a fix for months and months ago, what happened to it ?

> ---
>  arch/arm/mach-omap1/pm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index 40a1ae3..7dff68e 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -71,10 +71,10 @@ static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
>  static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
>  static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
>  
> -#ifdef CONFIG_OMAP_32K_TIMER
> -
>  static unsigned short enable_dyn_sleep = 1;
>  
> +#if defined(CONFIG_OMAP_32K_TIMER) || defined(CONFIG_OMAP_MPU_TIMER)
> +
>  static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
> @@ -643,7 +643,7 @@ static const struct platform_suspend_ops omap_pm_ops = {
>  static int __init omap_pm_init(void)
>  {
>  
> -#ifdef CONFIG_OMAP_32K_TIMER
> +#if defined(CONFIG_OMAP_32K_TIMER) || defined(CONFIG_OMAP_MPU_TIMER)
>  	int error;
>  #endif
>  
> @@ -700,7 +700,7 @@ static int __init omap_pm_init(void)
>  	omap_pm_init_debugfs();
>  #endif
>  
> -#ifdef CONFIG_OMAP_32K_TIMER
> +#if defined(CONFIG_OMAP_32K_TIMER) || defined(CONFIG_OMAP_MPU_TIMER)
>  	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
>  	if (error)
>  		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140319/dbfd0ffe/attachment.sig>
