From: jgchunter@gmail.com (Jon Hunter)
Date: Wed, 11 Feb 2015 17:39:38 +0000
Subject: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only
 Kconfigs
In-Reply-To: <alpine.DEB.2.02.1502110218090.3767@utopia.booyaka.com>
References: <alpine.DEB.2.02.1502070020530.3767@utopia.booyaka.com>
 <54D9CFBC.3070405@nvidia.com> <54D9E42C.7010105@gmail.com>
 <alpine.DEB.2.02.1502110218090.3767@utopia.booyaka.com>
Message-ID: <54DB93DA.8050308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 02/11/2015 02:25 AM, Paul Walmsley wrote:
> Hi John,
> 
> thanks for the review,
> 
> On Tue, 10 Feb 2015, Jon Hunter wrote:

[snip]

> Subject: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only Kconfigs
> 
> Building an OMAP1510-only Kconfig generates the following warnings:
> 
> arch/arm/mach-omap1/pm.c: In function ?omap1_pm_idle?:
> arch/arm/mach-omap1/pm.c:123:2: warning: #warning Enable 32kHz OS timer in order to allow sleep states in idle [-Wcpp]
>  #warning Enable 32kHz OS timer in order to allow sleep states in idle
>   ^
> arch/arm/mach-omap1/pm.c: At top level:
> arch/arm/mach-omap1/pm.c:76:23: warning: ?enable_dyn_sleep? defined but not used [-Wunused-variable]
>  static unsigned short enable_dyn_sleep = 0;
>                        ^
> 
> These are not so easy to fix in an obviously correct fashion, since I
> don't have these devices up and running in my testbed.  So, use
> arch/arm/plat-omap/Kconfig and the existing pm.c source as a guide,
> and posit that deep power saving states are only supported on OMAP16xx
> chips with kernels built with both CONFIG_OMAP_DM_TIMER=y and
> CONFIG_OMAP_32K_TIMER=y.
> 
> While here, clean up a few printk()s and unnecessary #ifdefs.
> 
> This second version of the patch incorporates several suggestions from
> Jon Hunter <jgchunter@gmail.com>.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Acked-by: Jon Hunter <jgchunter@gmail.com>
> ---
>  arch/arm/mach-omap1/pm.c | 51 ++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index 34b4c0044961..dd94567c3628 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -71,13 +71,7 @@ static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
>  static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
>  static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
>  
> -#ifndef CONFIG_OMAP_32K_TIMER
> -
> -static unsigned short enable_dyn_sleep = 0;
> -
> -#else
> -
> -static unsigned short enable_dyn_sleep = 1;
> +static unsigned short enable_dyn_sleep;
>  
>  static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
> @@ -90,8 +84,9 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
>  {
>  	unsigned short value;
>  	if (sscanf(buf, "%hu", &value) != 1 ||
> -	    (value != 0 && value != 1)) {
> -		printk(KERN_ERR "idle_sleep_store: Invalid value\n");
> +	    (value != 0 && value != 1) ||
> +	    (value != 0 && !IS_ENABLED(CONFIG_OMAP_32K_TIMER))) {
> +		pr_err("idle_sleep_store: Invalid value\n");
>  		return -EINVAL;
>  	}
>  	enable_dyn_sleep = value;
> @@ -101,7 +96,6 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
>  static struct kobj_attribute sleep_while_idle_attr =
>  	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
>  
> -#endif
>  
>  static void (*omap_sram_suspend)(unsigned long r0, unsigned long r1) = NULL;
>  
> @@ -115,16 +109,11 @@ void omap1_pm_idle(void)
>  {
>  	extern __u32 arm_idlect1_mask;
>  	__u32 use_idlect1 = arm_idlect1_mask;
> -	int do_sleep = 0;
>  
>  	local_fiq_disable();
>  
>  #if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
> -#warning Enable 32kHz OS timer in order to allow sleep states in idle

Thinking about this some more, I don't understand the dependency on the
DM_TIMER here. For an omap1 device, regardless of whether the DM_TIMERs
are enable or not, the device should be able to enter low power if the
32K is enabled. Hence, shouldn't this have been !(CONFIG_OMAP_32K_TIMER)
above?

Furthermore, you will get the above warning on a omap16xx only build if
you disable DM_TIMERs and keep MPU_TIMER enabled, which should be a
valid thing to do.

Tony, I see you added the DM_TIMER dependency in commit
be26a008414414c69a4ae9fe9877401c3ba62c5a. I understand your motivation,
but why not just use !(CONFIG_OMAP_32K_TIMER) here? Bit 9 of the idlect1
is only for the TIMCK clock that is used for the MPU timers and not the
DM_TIMERs.

-#if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
-#warning Enable 32kHz OS timer in order to allow sleep states in idle
+#if !defined(CONFIG_OMAP_32K_TIMER)
        use_idlect1 = use_idlect1 & ~(1 << 9);
-#else
-       if (enable_dyn_sleep)
-               do_sleep = 1;
 #endif


>  	use_idlect1 = use_idlect1 & ~(1 << 9);
> -#else
> -	if (enable_dyn_sleep)
> -		do_sleep = 1;
>  #endif
>  
>  #ifdef CONFIG_OMAP_DM_TIMER
> @@ -134,10 +123,12 @@ void omap1_pm_idle(void)
>  	if (omap_dma_running())
>  		use_idlect1 &= ~(1 << 6);
>  
> -	/* We should be able to remove the do_sleep variable and multiple
> +	/*
> +	 * We should be able to remove the do_sleep variable and multiple
>  	 * tests above as soon as drivers, timer and DMA code have been fixed.
> -	 * Even the sleep block count should become obsolete. */
> -	if ((use_idlect1 != ~0) || !do_sleep) {
> +	 * Even the sleep block count should become obsolete.
> +	 */
> +	if ((use_idlect1 != ~0) || !enable_dyn_sleep) {
>  
>  		__u32 saved_idlect1 = omap_readl(ARM_IDLECT1);
>  		if (cpu_is_omap15xx())
> @@ -635,15 +626,25 @@ static const struct platform_suspend_ops omap_pm_ops = {
>  
>  static int __init omap_pm_init(void)
>  {
> -
> -#ifdef CONFIG_OMAP_32K_TIMER
> -	int error;
> -#endif
> +	int error = 0;
>  
>  	if (!cpu_class_is_omap1())
>  		return -ENODEV;
>  
> -	printk("Power Management for TI OMAP.\n");
> +	pr_info("Power Management for TI OMAP.\n");
> +
> +	if (!IS_ENABLED(CONFIG_OMAP_32K_TIMER))
> +		pr_info("OMAP1 PM: sleep states in idle disabled due to no 32KiHz timer\n");
> +
> +	if (!IS_ENABLED(CONFIG_OMAP_DM_TIMER))
> +		pr_info("OMAP1 PM: sleep states in idle disabled due to no DMTIMER support\n");

I am not sure this print is really needed.

> +	if (IS_ENABLED(CONFIG_OMAP_32K_TIMER) &&
> +	    IS_ENABLED(CONFIG_OMAP_DM_TIMER)) {

Or this dependency on DM_TIMERs either.

Sorry, should have looked a bit more closely at this.

Jon
